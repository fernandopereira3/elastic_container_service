terraform {
  backend "s3" {
    bucket = "ecsfernando"
    key = "servidores/producao/terraform.tfstate"
    region = "us-west-2"
  }
}