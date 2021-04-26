resource "random_id" "random" {
  count = 900

  keepers = {
    uuid = "${uuid()}"
  }

  byte_length = 8
}

output "random" {  
   value = random_id.random.*
}
