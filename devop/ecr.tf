#### ECR Elastic Container Registry Repository
resource "aws_ecr_repository" "repositorio" {
  name = var.nome_repositorio
}