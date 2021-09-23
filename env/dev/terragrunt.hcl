locals {
    resource_group = "root_rg"
    env = "dev"
}

terraform {
  source = "../../terraform"
}

include {
  path = find_in_parent_folders()
}

inputs = {
    resource_group = "${local.resource_group}"
    env = "${local.env}"
}