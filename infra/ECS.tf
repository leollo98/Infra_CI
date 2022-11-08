module "ecs" {
  source = "terraform-aws-modules/ecs/aws"

  cluster_name       = var.ambiante
  fargate_capacity_providers = {
    FARGATE = {
      default_capacity_provider_strategy = {
        weight = 100
      }
    }
  }
}

resource "aws_ecs_task_definition" "Go-API" {
  family                   = "Go-API"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.cargo.arn
  container_definitions = jsonencode(
    [
      {
        "name"      = "homolog"
        "image"     = var.imagem
        "cpu"       = 256
        "memory"    = 512
        "essential" = true
        "portMappings" = [
          {
            "containerPort" = 8000
            "hostPort"      = 8000
          }
        ]
        "environment"= [
          {
            "name"  = "HOST"
            "value" = tostring(aws_db_instance.default.address)
          },
          {
            "name"  = "DBPORT"
            "value" = tostring(aws_db_instance.default.port)
          },
          {
            "name"  = "USER"
            "value" = tostring(aws_db_instance.default.username)
          },
          {
            "name"  = "PASSWORD"
            "value" = "rootroot"
          },
          {
            "name"  = "DBNAME"
            "value" = "root"
          },
          {
            "name"  = "PORT"
            "value" = "8000"
          }
        ]
      }
    ]
  )
}


resource "aws_ecs_service" "Go-API" {
  name            = "Go-API"
  cluster         = module.ecs.cluster_id
  task_definition = aws_ecs_task_definition.Go-API.arn
  desired_count   = 1
  load_balancer {
    target_group_arn = aws_lb_target_group.alvo.arn
    container_name   = "homolog"
    container_port   = 8000
  }

  network_configuration {
      subnets = module.vpc.private_subnets
      security_groups = [aws_security_group.privado.id]
      assign_public_ip = true
  }

  capacity_provider_strategy {
      capacity_provider = "FARGATE"
      weight = 1 #100/100
  }
}
