#------------------------------------------------------------
# AMI for Data Sources
#------------------------------------------------------------
##### ECS
data "aws_ami" "amzn_linux2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami*x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"]
}

##### Ubuntu
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}