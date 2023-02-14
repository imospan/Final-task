resource "aws_key_pair" "tf-key" {
  key_name   = var.aws_key_pair_key_name
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
  algorithm = var.tls_private_key_algorithm
  rsa_bits  = var.tls_private_key_rsa_bits
}

resource "local_file" "tf-key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = var.local_file_filename
}