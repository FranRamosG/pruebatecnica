terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  credentials = file(var.credentials_file)

  project = var.project
  region  = var.region
  zone    = var.zone
}

#Red virtual
resource "google_compute_network" "vpc_network" {
  name = "red-local-pt"
}

# Plantilla instancia aplicación
resource "google_compute_instance_template" "default" {
  name = "lb-backend-template"
  machine_type = "n2-standard-2"

  tags = ["allow-health-check"]

  disk {
    source_image = "debian-cloud/debian-11"
    labels = {
      my_label = "value"
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }

  metadata = {
    startup-script = "#! /bin/bash\n     sudo apt-get update\n     sudo apt-get install apache2 -y\n     sudo a2ensite default-ssl\n     sudo a2enmod ssl\n     vm_hostname=\"$(curl -H \"Metadata-Flavor:Google\" \\\n   http://169.254.169.254/computeMetadata/v1/instance/name)\"\n   sudo echo \"Page served from: $vm_hostname\" | \\\n   tee /var/www/html/index.html\n   sudo systemctl restart apache2"
    ssh-keys = "franramosguardiola:${file("~/.ssh/id_rsa.pub")}"
  }
}

#Creamos el grupo con la instancia de aplicación
resource "google_compute_instance_group_manager" "default" {
  name = "lb-backend-example"
  zone = var.zone
  named_port {
    name = "http"
    port = 80
  }
  version {
    instance_template = google_compute_instance_template.default.id
    name              = "primary"
  }
  base_instance_name = "app-instance"
  target_size        = 1
}

#Creamos la ip externa que usará el balanceador
resource "google_compute_global_address" "default" {
  name       = "lb-ipv4-1"
  ip_version = "IPV4"
}

#Instancia Balanceador
resource "google_compute_instance" "bal_instance" {
  name = "bal-instance"
  machine_type = "n2-standard-2"   
  zone = var.zone

  tags = ["http-server","https-server"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }

  metadata = {
    ssh-keys = "franramosguardiola:${file("~/.ssh/id_rsa.pub")}"
  }
}

# configuracion regla de firewall
resource "google_compute_firewall" "default" {
  name = "fw-allow-health-check"
  direction = "INGRESS"
  network = "default"
  priority = 1000
  source_ranges = ["0.0.0.0/0"]
  target_tags = ["allow-health-check"]
  allow {
    ports = ["80"]
    protocol = "tcp"
  }
}

#Configuración del balanceador de cargas
# 1. Creamos verificación de estado
resource "google_compute_health_check" "default" {
  name               = "http-basic-check"
  check_interval_sec = 5
  healthy_threshold  = 2
  http_health_check {
    port               = 80
    port_specification = "USE_FIXED_PORT"
    proxy_header       = "NONE"
    request_path       = "/"
  }
  timeout_sec         = 5
  unhealthy_threshold = 2
}

# 2. Creamos el servicio de Backend
resource "google_compute_backend_service" "default" {
  name                            = "web-backend-service"
  connection_draining_timeout_sec = 0
  health_checks                   = [google_compute_health_check.default.id]
  load_balancing_scheme           = "EXTERNAL_MANAGED"
  port_name                       = "http"
  protocol                        = "HTTP"
  session_affinity                = "NONE"
  timeout_sec                     = 30
  backend {
    group           = google_compute_instance_group_manager.default.instance_group
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
  }
}

# 3. Creamos el mapa de URL
resource "google_compute_url_map" "default" {
  name            = "web-map-http"
  default_service = google_compute_backend_service.default.id
}

# 4. Creamos el proxy HTTP de destino
resource "google_compute_target_http_proxy" "default" {
  name    = "http-lb-proxy"
  url_map = google_compute_url_map.default.id
}

# 5. Creamos la regla de reenvío
resource "google_compute_global_forwarding_rule" "default" {
  name                  = "http-content-rule"
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  port_range            = "80-80"
  target                = google_compute_target_http_proxy.default.id
  ip_address            = google_compute_global_address.default.id
}
