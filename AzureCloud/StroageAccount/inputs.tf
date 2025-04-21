variable "resgrp" {
  type = object({
    name     = string
    location = string
  })
  description = "Resource Group"
  default = {
    name     = "demo-resgroup"
    location = "centralindia"
  }
}

variable "stagacct" {
  type = object({
    name                     = string
    account_tier             = string
    account_replication_type = string
  })
  description = "Stroage Account"
  default = {
    name                     = "demostrgacctz"
    account_tier             = "Standard"
    account_replication_type = "GRS"
  }
}

variable "tags" {
  type = object({
    Env       = string
    CreatedBy = string
  })
  description = "This is tag info"
  default = {
    Env       = "DEV"
    CreatedBy = "Terraform"
  }
}