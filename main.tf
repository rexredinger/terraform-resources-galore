provider "tfe" {
  hostname = var.hostname
}

data "tfe_workspace" "parent" {
  name = var.parent_workspace
  organization = var.organization
}

resource "tfe_workspace" "initiald" {
  count = var.workspace_count
  organization = var.organization
  name = format("workspace_%s", count.index)
  execution_mode = "agent"

  vcs_repo {
    identifier = tfe_workspace.parent.vcs_repo.identifier
    branch = (count.index%2 == 0) ? "pets" : "numbers"
    oauth_token_id = tfe_workspace.parent.vcs_repo.oauth_token_id
  }
}

