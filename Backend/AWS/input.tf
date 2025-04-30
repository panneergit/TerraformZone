variable "primary_region" {
  type    = string
  default = "us-east-1"
}

variable "key_name" {
  type    = string
  default = "id_rsa"
}

variable "security_group_name" {
  type    = string
  default = "openall"
}

variable "az" {
  type    = string
  default = "us-east-1a"
}

variable "instance_size" {
  type    = string
  default = "t2.micro"
}

variable "Key_path" {
  type = string
  #default = "~/.ssh/id_rsa"
  default = "id_rsa.pem"
}
