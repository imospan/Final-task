resource "aws_security_group" "jenkins_sg" {
  name        = "sg_jenkins_server"
  description = "Allow traffic through needed ports"
  tags        = var.tags

  dynamic "ingress" {
    for_each = var.allow_ports
    content {
      description = "Inbound rules opening ports 443, 80, 22, 8080"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
