variable "web-instances" {
  type = list(object({
    name             = string
    ami              = string
    size             = string
    key_name         = string
    associate_pub_ip = bool
    user_data        = bool
    user_data_script = string
  }))
  description = "This is EC2 instance creation list"
  default = [
    {
      name             = "Web Server-1"
      ami              = "ami-084568db4383264d4"
      size             = "t2.micro"
      key_name         = "id_rsa"
      associate_pub_ip = true
      user_data        = true
      user_data_script = "install.sh"
    },
    {
      name             = "Web Server-2"
      ami              = "ami-084568db4383264d4"
      size             = "t2.micro"
      key_name         = "id_rsa"
      associate_pub_ip = true
      user_data        = true
      user_data_script = "install.sh"
    }
  ]
}

variable "db-instances" {
  type = list(object({
    name             = string
    ami              = string
    size             = string
    key_name         = string
    associate_pub_ip = bool
    user_data        = bool
    user_data_script = string
  }))
  description = "This is EC2 instance creation list"
  default = [
    {
      name             = "DB Server-1"
      ami              = "ami-084568db4383264d4"
      size             = "t2.micro"
      key_name         = "id_rsa"
      associate_pub_ip = false
      user_data        = false
      user_data_script = "install.sh"
    }
  ]
}