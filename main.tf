terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.15.0"
    }
  }
}


provider "docker" {
  registry_auth {
    address = "registry.hub.docker.com"
  }
}


data "docker_registry_image" "debian_bullseye" {
  name = "debian:bullseye"
}


resource "docker_image" "base_image" {
   name = "${data.docker_registry_image.debian_bullseye.name}"
}


resource "docker_image" "debian_bullseye_plus_ssh" {
  name = resource.docker_image.base_image.name
  build {
    path = "docker"
    dockerfile = "Dockerfile"
    tag = ["webserver_base_os"]
  }
  force_remove = true
  keep_locally = false
}


resource "docker_container" "web_server" {
   name = "web_server"
   image = docker_image.debian_bullseye_plus_ssh.latest
   attach = false
   tty = true
   ports {
     internal = 22
     external = 2222
     protocol = "tcp"
   }
   ports {
     internal = 80
     external = 8080
     protocol = "tcp"
   }
}
