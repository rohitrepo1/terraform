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

resource "docker_container" "node_container" {
  name  = "nodered"
  image = docker_image.nodered_image.latest
  ports {
    internal = 1880
    external = 1880

  }
}