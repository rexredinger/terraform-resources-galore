resource "random_id" "random" {
  count = 99

  keepers = {
    uuid = "${uuid()}"
  }

  byte_length = 8
}
