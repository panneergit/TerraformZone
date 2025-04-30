vpc-info = {
    name = "QA VPC"
    cidr = "10.10.0.0/16"

    private-subnet = [{
    name = "db-1"
    cidr = "10.10.0.0/24"
    az   = "us-east-1a"
    }, {
    name = "db-2"
    cidr = "10.10.1.0/24"
    az   = "us-east-1b"
  }]

  public-subnet = [{
    name = "Web-1"
    cidr = "10.10.2.0/24"
    az   = "us-east-1a"
    }, {
    name = "web-2"
    cidr = "10.10.3.0/24"
    az   = "us-east-1b"
  }]
  }