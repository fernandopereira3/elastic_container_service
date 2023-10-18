resource "aws_iam_role" "cargo" {
  name = "${var.cargoIAM}_cargo"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = ["ec2.amazonaws.com",
          "ecs-tasks.amazonaws.com"]
        }
      },
    ]
  })
}

# ESTA ROLE PERMITE QUE O ECS (ELASTIC CONTAINER SERVICE) ACESSE O ECR (ELASTIC CONTAINER REPOSITORY)
# 
resource "aws_iam_role_policy" "ecs_ecr" {
  name = "ecs_ecr"
  role = aws_iam_role.cargo.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BathCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "logs:CreateLogsStream",
          "logs:PutLogEvents",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_instance_profile" "profile" {
  name = "${var.cargoIAM}_perfil"
  role = aws_iam_role.cargo.name
}