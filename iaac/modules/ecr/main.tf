resource "aws_ecr_repository" "ecr_repo" {
  name                 = "${var.project}-${var.ecr_name}"
  image_tag_mutability = var.image_tag_mutability
  force_delete         = var.force_delete

  encryption_configuration {
    encryption_type = var.enc_type
  }
  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  tags = {
    name  = "${var.project}-${var.ecr_name}"
    Owner = var.owner
  }
}
resource "aws_ecr_lifecycle_policy" "ecr_repo_lifecycle" {
  repository = aws_ecr_repository.ecr_repo.name
  policy     = <<EOF
  {
    "rules": [
        {
            "rulePriority": 1,
            "description": "Expire images older than 30 days",
            "selection": {
                "tagStatus": "untagged",
                "countType": "sinceImagePushed",
                "countUnit": "days",
                "countNumber": 30
            },
            "action": {
                "type": "expire"
            }
        }
    ]
  }
EOF
}


