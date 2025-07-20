
#EKS FARGATE IAM Roles and Policies
# This module creates the necessary IAM roles and policies for an EKS cluster and Fargate
resource "aws_iam_role" "eks_cluster" {
  name = "${var.eks_short_project_name}-cluster-role"
  assume_role_policy = data.aws_iam_policy_document.eks_assume_role.json
  tags = var.tags
}

data "aws_iam_policy_document" "eks_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "eks_cluster_AmazonEKSClusterPolicy" {
  role       = aws_iam_role.eks_cluster.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role" "fargate_pod_execution" {
  name = "${var.eks_short_project_name}-pod-execution-role"
  assume_role_policy = data.aws_iam_policy_document.fargate_pod_assume_role.json
  tags      = var.tags
}

data "aws_iam_policy_document" "fargate_pod_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["eks-fargate-pods.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "fargate_pod_AmazonEKSFargatePodExecutionRolePolicy" {
  role       = aws_iam_role.fargate_pod_execution.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "fargate_pod_AmazonEC2ContainerRegistryReadOnly" {
  role       = aws_iam_role.fargate_pod_execution.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}