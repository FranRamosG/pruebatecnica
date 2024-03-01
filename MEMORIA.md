# Memoria Infraestructura App/Balanceador
---

## Índice
- [Introducción](#introducción)
- [Descripción](#descripción)
- [Herramientas utilizadas](#herramientas-utilizadas)
- [Proceso](#proceso)
- [Implementación](#implementación)
- [Resultado](#resultado)

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

Recordar de explicar lo de las claves secretas

## Resultado

a
