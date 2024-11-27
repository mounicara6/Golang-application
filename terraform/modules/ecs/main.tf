resource "aws_ecs_cluster" "main" {
  name = "ipfs-cluster"
}

resource "aws_ecs_task_definition" "app" {
  family = "ipfs-task"
  container_definitions = jsonencode([
    {
      name      = "ipfs-app",
      image     = "${var.ecr_repository_url}:latest",
      memory    = 512,
      cpu       = 256,
      essential = true,
      portMappings = [
        {
          containerPort = 8080
          hostPort      = 8080
        }
      ]
    }
  ])
}
