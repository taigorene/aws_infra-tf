variable "aws_access_key" {
  description = "AWS Access Key"
}

variable "aws_secret_key" {
  description = "AWS Secret Key"
}

variable "ssh_key_name" {
  description = "Nome do key pair"
  default     = "ec2_ssh_key"
}

variable "ssh_public_key" {
  description = "Public Key"
}

variable "aws_region" {
  type        = string
  description = "Região onde será criado o cluster"
  default     = "sa-east-1"
}

variable "aws_az1" {
  type        = string
  description = "AZ onde será criado o cluster"
  default     = "sa-east-1a"
}

variable "aws_az2" {
  type        = string
  description = "AZ onde será criado o cluster"
  default     = "sa-east-1b"
}
