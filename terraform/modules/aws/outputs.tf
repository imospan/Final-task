output "jenkins_public_ip" {
  description = "Public IP of a Jenkins server"
  value       = aws_instance.jenkins.public_ip
}

output "ssh_connection_string" {
  description = "The SSH command to connect to EC2"
  value       = "ssh -i /c/FinalTask/${var.local_file_filename} ubuntu@${aws_instance.jenkins.public_ip}"
}

output "feature_public_ip" {
  description = "Public IP of a feature server"
  value       = aws_instance.feature.public_ip
}

output "main_public_ip" {
  description = "Public IP of a main server"
  value       = aws_instance.main.public_ip
}