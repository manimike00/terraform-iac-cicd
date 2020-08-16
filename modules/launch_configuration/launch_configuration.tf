# -----------------------------------------------------------------------------------
# IAM Resources
# -----------------------------------------------------------------------------------
data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "${var.app_name}-ec2-role"
  path = "/"
  role = aws_iam_role.ec2_role.name
}
resource "aws_iam_role" "ec2_role" {
  name               = "${var.app_name}-ec2-role"
  path               = "/"
  description        = "Role assigned to EC2 Instance"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json
}
resource "aws_iam_role_policy_attachment" "managed_policies" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = var.managed_policies
}

resource "aws_launch_configuration" "as_conf" {
  name_prefix           = var.name_prefix
  image_id              = var.image_id
  instance_type         = var.instance_type
  iam_instance_profile  = var.iam_instance_profile
}