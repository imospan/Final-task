
resource "aws_instance" "jenkins" {
  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  key_name               = var.aws_instance_key_name
  user_data              = file(var.aws_instance_user_data)
  tags = merge({ Name = "Jenkins-server" }, var.tags)
 }

resource "aws_instance" "feature" {
  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  key_name               = var.aws_instance_key_name
 # user_data              = file(var.aws_instance_user_data)
  tags = merge({ Name = "Feature-server" }, var.tags)
 }

resource "aws_instance" "main" {
  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  key_name               = var.aws_instance_key_name
 # user_data              = file(var.aws_instance_user_data)
  tags = merge({ Name = "Main-server" }, var.tags)
 }