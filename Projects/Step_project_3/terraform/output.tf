# Create ../ansible/inventory file with [jenkins_master]and[jenkins_worker] ip both ec2 instances

output "public_ips" {
  description = "Public IP addresses of the EC2 instances"
  value       = [
    aws_instance.public-instance-1.public_ip,
    aws_instance.public-instance-2.public_ip
  ]
}

resource "null_resource" "generate_inventory" {
  provisioner "local-exec" {
    command = <<EOT
      echo "[jenkins_master]" > ../ansible/inventory.ini
      echo "${aws_instance.public-instance-1.public_ip} ansible_host=${aws_instance.public-instance-1.public_ip} ansible_user=${var.ansible_user} ansible_private_key_file=${var.ansible_private_key_file}" >> ../ansible/inventory.ini
      echo "[jenkins_worker]" >> ../ansible/inventory.ini
    echo "${aws_instance.public-instance-2.public_ip} ansible_host=${aws_instance.public-instance-2.public_ip} ansible_user=${var.ansible_user} ansible_private_key_file=${var.ansible_private_key_file}" >> ../ansible/inventory.ini
    EOT
  }

  depends_on = [
    aws_instance.public-instance-1,
    aws_instance.public-instance-2
  ]
}
