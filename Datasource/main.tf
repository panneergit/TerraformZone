# data "aws_ami" "awsami" {
#   most_recent = true
#   filter {
#     name   = "name"
#     values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
#   }
#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }
# }

# output "ami" {
#   value = data.aws_ami.awsami.id
# }

// AWS Key Pair
data "aws_key_pair" "example" {
  key_name           = "id_rsa"
  include_public_key = true

  filter {
    name   = "tag:Name"
    values = ["My New Key Pair"]
  }
}

output "fingerprint" {
  value = data.aws_key_pair.example.fingerprint
}

output "name" {
  value = data.aws_key_pair.example.key_name
}

output "id" {
  value = data.aws_key_pair.example.id
}

// VPC
data "aws_vpc" "awsvpc" {
  filter {
    name   = "tag:Name"
    values = ["Default VPC"]
  }
}

// Security Group
variable "secgroup_name" {
  type        = string
  description = "This security group name"
  default     = "openall"
}
data "aws_security_groups" "security" {
  // name = var.secgroup_name
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.awsvpc.id]
  }
}
output "aws_security_group_out" {
  value = data.aws_security_groups.security
}


// AWS AMI
# data "aws_ami" "ubuntu" {
#   // owners = ["125866748812"]
#   // owners      = ["self"]
#   // most_recent = true
  
#   filter {
#     name   = "name"
#     values = ["amzn2-ami-hvm-*-x86_64-gp2"] # Filter for specific AMI names
#   }

#   filter {
#     name   = "architecture"
#     values = ["x86_64"] # Filter for specific architectures
#   }

#   filter {
#     name   = "platform"
#     values = ["linux"] # Filter for Linux AMIs
#   }

#   filter {
#     name   = "root-device-type"
#     values = ["ebs"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }
# }

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
output "aws_ami_out" {
  value = data.aws_ami.ubuntu
}