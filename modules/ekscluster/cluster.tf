resource "aws_eks_cluster" "example" {

  name     = var.cluster_name
  version = "1.17"
  role_arn = aws_iam_role.example.arn

  enabled_cluster_log_types = ["api", "audit"]

  vpc_config {
    #subnet_ids = ["subnet-0d5b520624cd88396", "subnet-073bad99a23c8e4e6", "subnet-093faa5c770ff13af"]
    subnet_ids = var.subnet_ids
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.example-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.example-AmazonEKSServicePolicy,
    aws_cloudwatch_log_group.example
  ]
}

output "endpoint" {
  value = aws_eks_cluster.example.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.example.certificate_authority[0].data
}