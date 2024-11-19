output "instance_ip" {
  description = "The public IP of the created instance"
  value       = aws_instance.nginx_instance.public_ip
}