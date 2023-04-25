provider "tfe" {
  hostname = var.hostname
}

resource "tfe_workspace" "pets" {
  count = var.workspace_count
  organization = var.organization
  name = format("pets_workspace_%s", count.index)
  execution_mode = "remote"
  auto_apply = true
  terraform_version = "latest"

  vcs_repo {
    identifier = "rexredinger/tfpets"
    branch = "main"
    github_app_installation_id = var.github_app_installation_id
  }
}

