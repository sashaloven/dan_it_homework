

resource "aws_instance" "public-instance" {
  count                        = 2
  ami                          = "ami-0084a47cc718c111a"
  instance_type                = "t2.micro"
  subnet_id                    = aws_subnet.lov_public_subnet_1.id
  associate_public_ip_address  = true
  key_name                     = "lovyniuk-key"
  vpc_security_group_ids = [aws_security_group.lov_sg_ssh.id]
   tags = {
    Name = "public-instance-${count.index + 1}"
  }
}


output "public_ips" {
  value = aws_instance.public-instance.*.public_ip
}

resource "null_resource" "generate_inventory" {
  provisioner "local-exec" {
    command = <<EOT
      echo "[web]" > ../ansible/ansible_inventory
      echo "${join("\n", aws_instance.public-instance.*.public_ip)}" >> ../ansible/ansible_inventory
    EOT
  }

  depends_on = [aws_instance.public-instance]
}
