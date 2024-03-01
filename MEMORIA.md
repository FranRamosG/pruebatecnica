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

Si embargo trás esto solo se quedaron dos instancias por separado sin saber como hacer para que el funcionase el balanceador de cargas, por lo cual me puse a buscar por internet  formas de crear un balanceador de cargas y terminé encontrando una pequeña guía de como crear un balanceador de cargas en la página oficical de GCP que utlicé como base para crear la infraestructura:

[![image](https://github.com/FranRamosG/pruebatecnica/assets/131311475/8f595844-cfd5-4db1-9153-00e9f3db43b0)](https://cloud.google.com/iap/docs/load-balancer-howto?hl=es-419#terraform_2)

Aún así el balanceador de cargas que se quedó no es una instanca.

Buscando una forma que la nstancia hiciese de balanceador de cargas se me echó el tiempo encima y no pude avanzar más en el proyecto quedando:

 - Una instancia aplicación `app-instance`con apache instalado (previo a la instalación del wordpress) a la que se puede acceder desde su dirección IP.
 - Un balanceador de cargas que puede acceder al contenido de la instancia aplicación a traves de su dirección IP.
 - Una instancia `bal-instance`que no terminé de montar como balanceador

## Implementación

Recordar de explicar lo de las claves secretas

## Resultado

a
