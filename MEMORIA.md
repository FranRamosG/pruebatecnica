# Memoria Infraestructura App/Balanceador
---

## Índice
- [Introducción](#introducción)
- [Descripción](#descripción)
- [Herramientas utilizadas](#herramientas-utilizadas)
- [Proceso](#proceso)
- [Implementación](#implementación)
- [Conclusiones](#conclusiones)

---

## Introducción

Aunque, al plantearse el proyecto, mis conocimientos sobre las herramientas a utilizar eran prácticamente nulos, consideré que este proyecto sería un fantástico reto para aprender y mejorar mis habilidades y mi conocimiento en este ámbito. Aunque no haya podido completarlo al 100%, creo que he aprendido más de lo que habría sido posible sin el proyecto, y mis ganas de seguir aprendiendo han aumentado.

## Descripción

Esta prueba implica la creación de un nuevo entorno de producción para el sitio web corporativo de la empresa Papas ACME, SA. Se solicita diseñar la arquitectura de la solución, que consta de un balanceador de carga y una instancia de aplicación con WordPress.

## Herramientas utilizadas

Las herramientas empleadas en el proyrecto son las siguientes:
- En este proyecto, he optado por utilizar **Google Cloud Platform (GCP)** debido a sus características avanzadas de infraestructura, servicios flexibles y facilidad de integración. GCP proporciona una sólida infraestructura en la nube que respalda la implementación eficiente de la arquitectura propuesta, permitiendo una gestión eficaz de recursos. 
- He empleado **Terraform** para llevar a cabo la implementación de una infraestructura como código, permitiendo la automatización y gestión eficiente de recursos. Esto facilita tanto el aprovisionamiento como la eliminación de recursos mediante un único comando desde la línea de comandos.

## Proceso

Dada mi limitada experiencia en las herramientas necesarias para llevar a cabo esta prueba, mi enfoque inicial consisitió en adquirir conocimientos sobre Terraform, GCP y AWS. La selección de GCP como la plataforma para implementar la infraestructura en la nube se basó principalmente en mi familiaridad pervia con el enntorno de Google.

Posterior a este punto, me centré en la busqueda de como comenzar el proyecto, identificando en la página oficial de Terraform un tutorial especifco que guía la creación de una infraestructura básica con una instancia en GCP:

[![image](https://github.com/FranRamosG/pruebatecnica/assets/131311475/74251376-c86f-429b-9c9f-8972ba10b368)
](https://developer.hashicorp.com/terraform/tutorials/gcp-get-started)

Realizando este tuorial es como aprendi para usar los siguientes archivos:
- [main.tf](https://github.com/FranRamosG/pruebatecnica/blob/main/main.tf) para la creación de la infraestructura como código.
- [variables.tf](https://github.com/FranRamosG/pruebatecnica/blob/main/variables.tf) para guardar las variables
- [terraform.tfvars](https://github.com/FranRamosG/pruebatecnica/blob/main/terraform.tfvars) para las credenciales y el id del proyecto

Tras esto comenze a buscar formas de crear un balanceador de cargas, cuando encontré la siguiente imagen:

<img src="https://github.com/FranRamosG/pruebatecnica/assets/131311475/2753eb9f-03b6-478c-a60e-2203df71af8b" width="447" height="374">

Con la que empecé a entender como funcionaba el balanceador de cargas y con un poco de ayuda de las IA para conocer los elementos de la infraestructura necesarios para cada parte del balanceador y buscando en la documentación oficial de Terraform como funciona:

[![image](https://github.com/FranRamosG/pruebatecnica/assets/131311475/a51b811e-bbda-450a-86f4-30de7d97bd30)](https://registry.terraform.io/providers/hashicorp/google/latest/docs)

Estando en el enlace anterior todos los elementos utilizados con su documentación oficial en la página de Terraform.

Sin embargo, después de este punto, me encontré con la situación en la que solo quedaron dos instancias de manera independiente, sin una guía clara sobre cómo hacer que el balanceador de cargas funcionara. 
Ante esto, comencé a buscar en internet para encontra métodos efectivos de implementar un balanceador de cargas. Finalmente, encontré una breve guía en la página oficial de GCP que utilicé como referncia para establecer la infraestructura necesaria:

[![image](https://github.com/FranRamosG/pruebatecnica/assets/131311475/8f595844-cfd5-4db1-9153-00e9f3db43b0)](https://cloud.google.com/iap/docs/load-balancer-howto?hl=es-419#terraform_2)

A pesar de ello, el balanceador de cargas no es una instancia.

Debido a las limitaciones temporales, no pude continuar explorando la opción de utilizar la instancia como balanceador de cargas. Como resultado, el estado actual del proyecto incluye:

- Una instancia de aplicación llamada `app-instance` con Apache instalado (anterior a la instalación de WordPress) y accesible mediante su dirección IP.
- Un balanceador de cargas que puede acceder al contenido de la instancia de aplicación a través de su dirección IP.
- Una instancia llamada `bal-instance` destinada a funcionar como balanceador de cargas, la cual no ha sido completamente implementada.

## Implementación

### 1. Configuración de Terraform y Proveedor de Google Cloud Platform
Esta sección especifca la versión de Terraform y el proveedor de GCP que se utilizará. Además, configura las credenciales y la información del proyecto, región y zona para la interacción con GCP.
Los  atributos del proveedor como son las nombradas anteriormente han sido guardadas en dos ficheros de variables [variables.tf](https://github.com/FranRamosG/pruebatecnica/blob/main/variables.tf) y [terraform.tfvars](https://github.com/FranRamosG/pruebatecnica/blob/main/terraform.tfvars) como se ha explicado en el proceso.

Para generar las credenciales:
1. acceder a la parte de 'IAM y Administración --> Cuentas de Servicio:

![Captura de pantalla 2024-03-01 124943](https://github.com/FranRamosG/pruebatecnica/assets/131311475/0e0de7e8-71d0-4736-9add-7c098dd8473a)

2. Crear la cuenta de servicio:

![Captura de pantalla 2024-03-01 125032](https://github.com/FranRamosG/pruebatecnica/assets/131311475/738eaa61-6638-4db7-9fc0-d16f2aaad7df)

3. Acceder a la cuenta de servicio y crear la clave de tipo JSON generando un archivo que será el que utilicemos como credenciales:

![Captura de pantalla 2024-03-01 125113](https://github.com/FranRamosG/pruebatecnica/assets/131311475/f1ad22e2-04b6-40f2-9434-c70a37369304)

### 2. Red Virtual

Crea una red virtual en GCP con el nombre `red-local-pt` para alojar los recursos de las infraestructura. ([Código](https://github.com/FranRamosG/pruebatecnica/blob/main/main.tf#L18))

### 3. Plantilla de Instancia de Aplicación

Define una plantilla para la instancia de aplicación que incluye la configuración de la máquina virtual, la imagen del disco, la configuración de red y scripts de inicio. ([Código](https://github.com/FranRamosG/pruebatecnica/blob/main/main.tf#L23))

### 4. Grupo de Instancias y Manager del Grupo

Crea un grupo de instancias y su manager asociado para manejar la instancia de aplicación, estableciendo el tamaño del grupo y la versión de la plantilla. ([Código](https://github.com/FranRamosG/pruebatecnica/blob/main/main.tf#L49))

### 5. IP Externa para el Balanceador de Cargas

Establece una dirección IP global para el balanceador de cargas. ([Código](https://github.com/FranRamosG/pruebatecnica/blob/main/main.tf#L65))

### 6. Instancia del Balanceador de Cargas

Crea una instancia que servirá como el balanceador de cargas. ([Código](https://github.com/FranRamosG/pruebatecnica/blob/main/main.tf#L71))

### 7. Configuración de Firewall

Define una regla de firewall para permitir el tráfico en el puerto 80 utilizado por el balanceador de cargas. ([Código](https://github.com/FranRamosG/pruebatecnica/blob/main/main.tf#L99))

### 8. Configuración del Balanceador de Carga

Las secciones restantes del código configuran el balanceador de cargas, incluyendo la verificación de estado, el servicio de backend, el mapa de URL, el proxy HTTP de destino y la regla de reenvío. ([Código](https://github.com/FranRamosG/pruebatecnica/blob/main/main.tf#L113))

#### 8.1 Creación de la Verificación de Estado

En esta sección, se crea una verificación de estado (health check) llamada `http-basic-check`. Esta verificación se realiza cada 5 segundos, con un umbral de salud positiva establecido en 2. La verificación de salud se realiza a través de una solicitud HTTP en el puerto 80 con la ruta "/" especificada. ([Código](https://github.com/FranRamosG/pruebatecnica/blob/main/main.tf#L114))

#### 8.2 Creación del Servicio de Backend

Se define el servicio de backend llamado `web-backend-service`. Este servicio utiliza la verificación de estado creada anteriormente. Además, se configuran parámetros como el esquema de balanceo, el puerto, el protocolo (HTTP), la afinidad de sesión y otros detalles relevantes. El servicio de backend está asociado al grupo de instancias creado en secciones anteriores. ([Código](https://github.com/FranRamosG/pruebatecnica/blob/main/main.tf#L129))

#### 8.3 Creación del Mapa de URL

Esta sección establece un mapa de URL llamado `web-map-http`. El mapa de URL vincula el servicio de backend creado anteriormente como servicio predeterminado. ([Código](https://github.com/FranRamosG/pruebatecnica/blob/main/main.tf#L146))

#### 8.4 Creación del Proxy HTTP de destino

Se crea un proxy HTTP de destino llamado `http-lb-proxy`, que utiliza el mapa de URL previamente definido. ([Código](https://github.com/FranRamosG/pruebatecnica/blob/main/main.tf#L152))

#### 8.5 Creación de la Regla de Reenvío Global

Finalmente, se configura una regla de reenvío global llamada `http-content-rule`. Esta regla especifica detalles como el protocolo, el esquema de balanceo, el rango de puertos, el destino (el proxy HTTP de destino) y la dirección IP global asociada. ([Código](https://github.com/FranRamosG/pruebatecnica/blob/main/main.tf#L158))

## Conclusiones

A pesar de mis limitados conocimientos iniciales, el proyecto de implementación en Google Cloud Platform con Terraform me brindó valiosas lecciones. Opté por GCP por su robusta infraestructura, mientras Terraform facilitó la automatización. Aprendí a través de tutoriales y documentación, logrando una instancia de aplicación y un balanceador de carga funcional, aunque la instancia destinada a esto no se completó por restricciones de tiempo. Este proyecto no solo mejoró mis habilidades, sino que también aumentó mi motivación para seguir aprendiendo.
