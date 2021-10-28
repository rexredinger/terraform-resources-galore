# Workspace variables:
# Create them in this order exactly!

# Terraform variables:
# TERRAFORM_ONLY_VAR = 'has-a-value'
# DOUBLED_VAR_TF_CREATED_FIRST = 'tf-value'

# Environment variables:
# ENV_ONLY_VAR = 'has-a-value'
# DOUBLED_VAR_TF_CREATED_FIRST = 'env-value'
# DOUBLED_VAR_ENV_CREATED_FIRST = 'env-value'

# Terraform variable:
# DOUBLED_VAR_ENV_CREATED_FIRST = 'tf-value'

variable "DOUBLED_VAR_TF_CREATED_FIRST" {
  default = "default-value"
}

variable "DOUBLED_VAR_ENV_CREATED_FIRST" {
  default = "default-value"
}

variable "TERRAFORM_ONLY_VAR" {}

resource "null_resource" "check_doubled_var_created_first_as_tf_var" {
  provisioner "local-exec" {
    # expect this to output DOUBLED_VAR_TF_CREATED_FIRST=tf-value, and NOT
    # reflect the environment variable value
    command = "env | grep DOUBLED_VAR_TF_CREATED_FIRST || echo 'doubled var created as tf var first not found'"
  }
  triggers = { random = uuid() }
}

resource "null_resource" "check_doubled_var_created_first_as_env_var" {
  provisioner "local-exec" {
    # expect this to output DOUBLED_VAR_ENV_CREATED_FIRST=env-value, and NOT
    # reflect the terraform variable value
    command = "env | grep DOUBLED_VAR_ENV_CREATED_FIRST || echo 'doubled var created as env var first not found'"
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

output "doubled_variable_tf_created_first" {
  # expect this to output 'tf-value'
  value = var.DOUBLED_VAR_TF_CREATED_FIRST
}

output "doubled_variable_env_created_first" {
  # expect this to output 'default-value'
  value = var.DOUBLED_VAR_ENV_CREATED_FIRST
}

output "terraform_only_var" {
  # expect this to output 'has-a-value'
  value = var.TERRAFORM_ONLY_VAR
}
