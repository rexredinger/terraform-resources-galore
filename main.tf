terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
  }
}

provider "random" {
}

resource "random_pet" "pet" {
  count = 4
}

output "critter" {
  value = random_pet.pet.*
}
