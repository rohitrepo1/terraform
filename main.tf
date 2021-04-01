terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}

provider "docker" {}

resource "docker_image" "nodered_image" {
  name = "nodered/node-red:latest"
}

resource "random_string" "random" {
  length = 4
  special = false
  upper = false
}

resource "random_string" "random2" {
  length = 4
  special = false
  upper = false
}

resource "docker_container" "node_container" {
  name  = join("-",["nodered", random_string.random.result])
  image = docker_image.nodered_image.latest
  ports {
    internal = 1880
    #external = 1880

  }
}
  resource "docker_container" "node_container2" {
  name  = join("-",["nodered2", random_string.random2.result])
  image = docker_image.nodered_image.latest
  ports {
    internal = 1880
   #external = 1880

  }
}

output "IP_Address" {
    value = join(":", [docker_container.node_container.ip_address, docker_container.node_container.ports[0].external])
    description = "the ip_address and external port  of the container"
}

output "container_name" {
    value = docker_container.node_container.name
    description = "the name of the container"
}

output "ip_address2" {
  value = join (":", [docker_container.node_container2.ip_address, docker_container.node_container2.ports[0].external])
  description = "the ip_address and external port of second container"
}

output "container_name2" {
    value = docker_container.node_container2.name
    description = "the name of the container"
}
