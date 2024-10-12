resource "docker_image" "nginx" {
  name         = "nginx"
  keep_locally = false
}

# Start a container
resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "tutorial"

  ports {
    internal = 80
    external = 8000
  }
}