variable "aws_user_id" {}

variable "aws_user_token" {}

variable "aws_region" {
  type        = string
  description = "Região onde será criado o cluster"
  default = "sa-east-1"
}

variable "aws_az1" {
  type        = string
  description = "AZ onde será criado o cluster"
  default = "sa-east-1a"
}

variable "aws_az2" {
  type        = string
  description = "AZ onde será criado o cluster"
  default = "sa-east-1b"
}