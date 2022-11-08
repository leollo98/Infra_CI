resource "aws_security_group" "alb" {
  name        = "alb_ECS"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_security_group_rule" "tcp_alb" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"] #0.0.0.0 - 255.255.255.255
  security_group_id = aws_security_group.alb.id
}

resource "aws_security_group_rule" "saida_alb" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"] #0.0.0.0 - 255.255.255.255
  security_group_id = aws_security_group.alb.id
}
  
resource "aws_security_group" "db" {
  name        = "db_ECS"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_security_group_rule" "tcp_db" {
  type              = "ingress"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"] #0.0.0.0 - 255.255.255.255
  security_group_id = aws_security_group.db.id
}

resource "aws_security_group_rule" "saida_db" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"] #0.0.0.0 - 255.255.255.255
  security_group_id = aws_security_group.db.id
}

resource "aws_security_group" "privado" {
  name        = "privado_ECS"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_security_group_rule" "entrada_ECS" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  source_security_group_id = aws_security_group.alb.id
  security_group_id = aws_security_group.privado.id
}

resource "aws_security_group_rule" "saida_ECS" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"] #0.0.0.0 - 255.255.255.255
  security_group_id = aws_security_group.privado.id
}
