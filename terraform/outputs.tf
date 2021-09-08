### The Ansible inventory file
resource "local_file" "AnsibleInventory" {
 content = templatefile("../ansible/inventory.tmpl",
 {
  k8s-master-dns = aws_instance.k8s-master[0].public_dns,
  k8s-worker-dns = aws_instance.k8s-worker.*.public_dns
 }
 )
 filename = "../ansible/inventory"
}
