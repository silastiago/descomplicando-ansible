resource "aws_instance" "web" {
  # ...

  provisioner "local-exec" {
    command = "ansible-playbook -i ../ansible/inventario ../ansible/playbook.yml"
  }
}