
locals {
  common_tags = {
    project     = var.project
    terraform   = true
    team        = var.team
    environment = var.environment
  }
}

