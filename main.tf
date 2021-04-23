resource "random_id" "random" {
  count = 9999
  name = "random_${uuid()}"

  keepers = {
    uuid = "${uuid()}"
  }

  byte_length = 8
}

output "random" {  
   value = random_id.random.*
}
