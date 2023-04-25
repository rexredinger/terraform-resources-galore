provider "tfe" {
  hostname = var.hostname
}

resource "tfe_workspace" "pets" {
  count = var.workspace_count
  organization = var.organization
  name = format("pets_workspace_%s", count.index)
  execution_mode = "1.4.5"
  auto_apply = true
  terraform_version = latest

  vcs_repo {
    identifier = "rexredinger/terraform-resources-galore"
    branch = "pets"
    oauth_token_id = var.oauth_token_id
  }
}

