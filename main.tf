resource "null_resource" "sleep1" {
  provisioner "local-exec" {
    command = "sleep 5m"
  }
  triggers = {
    always = uuid()
  }
}

resource "null_resource" "sleep2" {
  provisioner "local-exec" {
    command = "sleep 5m"
  }
  triggers = {
    always = uuid()
  }
  depends_on = [
    null_resource.sleep1
  ]
}

resource "null_resource" "sleep3" {
  provisioner "local-exec" {
    command = "sleep 5m"
  }
  triggers = {
    always = uuid()
  }
  depends_on = [
    null_resource.sleep2
  ]
}
