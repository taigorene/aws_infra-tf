output "ec2_ip" {
  value       = aws_instance.ec2_instance.public_ip
  description = "IP para acesso para o servidor"
}
