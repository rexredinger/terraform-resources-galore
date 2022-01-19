variable "amount" {
  type = number
  default = 1
}

resource "random_id" "random" {
  count = var.amount
  
  keepers = {
    uuid = "${uuid()}"
  }

  byte_length = 8
}

output "random" {  
   value = random_id.random.*
}
