output "ami_id_amzn_linux2" {
  value = data.aws_ami.amzn_linux2.id
}

output "ami_id_ubuntu" {
  value = data.aws_ami.ubuntu.id
}