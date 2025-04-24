variable "instance-info" {
  type = object({
    name              = string
    size              = string
    ami               = string
    subnet_id         = string
    security_group_id = string
    key_name          = string
    associate_pub_ip  = bool
    user_data         = bool
    user_data_script  = string
  })
}