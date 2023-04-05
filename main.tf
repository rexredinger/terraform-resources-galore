provider "tfe" {
  hostname = var.hostname
}

resource "tfe_workspace" "initiald" {
  organization = var.organization
  name = "Initial_D"
}

check "Initial_D_check" {
  data "tfe_workspace" "ws" {
    name = "Initial_D"
    organization = var.organization
  }
  
  assert {
    condition = data.tfe_workspace.ws.name == "Initial_D"
    error_message = "Your Initial_D workspace isn't anymore"
  }
}

check "time_thing" {
  
  assert {
    condition = timecmp(timestamp(), timestamp()) > 0
    error_message = "wut?"
  }
}
