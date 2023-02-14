
output "jenkins_public_ip" {
  description = "Public IP of a Jenkins server"
  value       = "http://${module.aws.jenkins_public_ip}:8080"
}

output "jenkins_ssh_connection_string" {
  description = "The SSH command to connect to the Jenkins EC2"
  value       = module.aws.ssh_connection_string
}

output "feature_public_ip" {
  description = "Public IP of a feature server"
  value       = "http://${module.aws.feature_public_ip}"
}

output "main_public_ip" {
  description = "Public IP of a main server"
  value       = "http://${module.aws.main_public_ip}"
}