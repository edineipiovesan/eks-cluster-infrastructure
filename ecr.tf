resource "aws_ecr_repository" "ecr" {
  name                 = var.ecr_repository_name
  image_tag_mutability = "IMMUTABLE"
  force_delete         = true

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "kms"
    kms_key         = aws_kms_key.eks.arn
  }

  tags = var.default_tags
}