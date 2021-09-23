remote_state {
  backend = "azurerm"
  config = {
        key = "${path_relative_to_include()}/terraform.tfstate"
        resource_group_name = "root_rg"
        storage_account_name = "tfstatedef"
        container_name = "statecontainer"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}
