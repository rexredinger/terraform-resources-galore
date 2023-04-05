provider "tfe" {
  hostname = var.hostname
}

resource "tfe_workspace" "initiald" {
  organization = var.organization
  name = "Initial_D"
}

check "Initial D check" {
  data "tfe_workspace" "ws" {
    name = "Initial_D"
    organization = var.organization
  }
  
  assert {
    condition = data.tfe_workspace.ws.name == "Initial_D
    error_message = "Your Initial_D workspace isn't anymore"
  }
}
