# Workspace variables:

# Terraform variables:
# DOUBLED_VAR = 'terraform-value'
# TERRAFORM_ONLY_VAR = 'has-a-value'

# Environment variables:
# DOUBLED_VAR = 'environment-value'
# ENV_ONLY_VAR = 'has-a-value'

variable "DOUBLED_VAR" {}

variable "TERRAFORM_ONLY_VAR" {}


resource "null_resource" "check_doubled_var" {
  provisioner "local-exec" {
    # expect this to output DOUBLED_VAR=terraform-value, and NOT
	# reflect the environment variable value
    command = "env | grep DOUBLED_VAR || echo 'doubled var not found'"
  }
  triggers = { random = uuid() }
}

resource "null_resource" "check_terraform_var" {
  provisioner "local-exec" {
  	# expect this to output TERRAFORM_ONLY_VAR=has-a-value
    command = "env | grep TERRAFORM_ONLY_VAR || echo 'tf var not found as env var'"
  }
  triggers = { random = uuid() }
}

resource "null_resource" "check_env_only_var" {
  provisioner "local-exec" {
    # expect this to output ENV_ONLY_VAR=has-a-value
    command = "env | grep ENV_ONLY_VAR || echo 'env-only var not found'"
  }
  triggers = { random = uuid() }
}

output "doubled_variable" {
  # expect this to output 'terraform-value'
  value = var.DOUBLED_VAR
}

output "terraform_only_var" {
  # expect this to output 'has-a-value'
  value = var.TERRAFORM_ONLY_VAR
}
