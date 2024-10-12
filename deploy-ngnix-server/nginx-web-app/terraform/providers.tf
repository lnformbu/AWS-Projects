terraform {
  required_version = ">= 1.7.0"
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {
  host = "npipe:////.//pipe//docker_engine"
}