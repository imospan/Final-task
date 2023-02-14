variable "instance_type" {
  default = "t2.micro"
}

variable "ami" {
  description = "AWS image version"
  default     = "ami-0a6b2839d44d781b2"
}

variable "allow_ports" {
  type    = list(any)
  default = ["443", "80", "22", "8080"]

}

variable "tags" {
  default = {
    "Built by Terraform" = "True"
    "Owner"              = "mosya"
  }
}

variable "aws_instance_user_data" {
  description = "script to install Jenkins in Docker container"
  default     = "docker_jenkins.sh"
}

variable "aws_instance_key_name" {
  default     = "tf-key"
  description = "Created public key which adds on AWS"
}

variable "aws_key_pair_key_name" {
  default     = "tf-key"
  description = "Created key pair."
}

variable "tls_private_key_algorithm" {
  default = "RSA"
}

variable "tls_private_key_rsa_bits" {
  default = 4096
}

variable "local_file_filename" {
  default     = "tfkey"
  description = "File with private key."
}
