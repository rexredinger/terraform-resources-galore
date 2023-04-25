provider "tfe" {
  hostname = var.hostname
}

data "tfe_workspace" "parent" {
  name = var.parent_workspace
  organization = var.organization
}

resource "random_shuffle" "tf_version" {
  input = ["1.2.4", "1.3.1", "1.4.5", "latest"]
}

resource "tfe_workspace" "pets" {
  count = var.workspace_count
  organization = var.organization
  name = format("pets_workspace_%s", count.index)
  execution_mode = "agent"
  auto_apply = true
  terraform_version = random_shuffle.tf_version.result[0]

  vcs_repo {
    identifier = tfe_workspace.parent.vcs_repo.identifier
    branch = "pets"
    oauth_token_id = tfe_workspace.parent.vcs_repo.oauth_token_id
  }
}

