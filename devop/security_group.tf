# GRUPO DE SEGURANCA PARA LOAD BALANCE 
resource "aws_security_group" "aplication_lb" {
  name        = "aplication_lb"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_security_group_rule" "aplication_lb_entrada" {
  type              = "ingress"
  from_port         = 8000
  to_port           = 8000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
#   ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = "aws_security_group.aplication_lb.id"
}

resource "aws_security_group_rule" "aplication_lb_saida" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
#   ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = "aws_security_group.aplication_lb.id"
}


##### GRUPO DE SEGURANCA PARA REDE PRIVADA 
resource "aws_security_group" "aplication_privade" {
  name        = "aplication_privade"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_security_group_rule" "aplication_privade_entrada" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  source_security_group_id = aws_security_group.aplication_lb.id
#   este campo permite a entrada de somente protocolos dentro do Load Balance, quem esta dentro da rede privada nao pode ter acesso a 
#   rede prublica, logo o abencoado esta preso no LB. Eu sei é chato mas faz assim que da bom
  security_group_id = "aws_security_group.aplication_privade.id"
}

resource "aws_security_group_rule" "aplication_privade_saida" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
#   ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = "aws_security_group.aplication_privade.id"
}