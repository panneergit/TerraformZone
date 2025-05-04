module "nw_load_balancer" {
  source = "github.com/panneergit/TerraformZone//AWSCloud/Modules/nlb"

  load_balancer = {
    name            = "preschool-lb"
    lb_type         = "network"
    internal        = false
    subnets         = data.aws_subnets.subnets.ids
    security_groups = data.aws_security_groups.security.ids
  }

  target_group = {
    name   = "preschool-tg"
    vpc_id = data.aws_vpc.vpc.id
  }

  depends_on = [
    data.aws_vpc.vpc,
    data.aws_security_groups.security
  ]
}

module "autoscaling_group" {
  source = "github.com/panneergit/TerraformZone//AWSCloud/Modules/asg"

  lunch_template = {
    name                   = "preschool-lt",
    image_id               = data.aws_ami.ubuntu.id
    instance_type          = "t2.micro"
    key_name               = "id_rsa"
    user_data              = true
    user_data_script       = "install.sh"
    vpc_security_group_ids = data.aws_security_groups.security.ids
  }

  autoscaling_group = {
    desired_capacity     = 1
    min_size             = 1
    max_size             = 1
    subnets              = data.aws_subnets.subnets.ids
    lb_target_group_arns = module.nw_load_balancer.target_group_arns
  }

  depends_on = [
    data.aws_vpc.vpc,
    data.aws_security_groups.security,
    module.nw_load_balancer
  ]
}