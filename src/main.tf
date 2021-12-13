terraform {
 required_providers {
   ibm = {
     source  = "localdomain/provider/ibm"
     version = "1.10.0"
   }
 }
}

resource "tls_private_key" "ssh" {
  algorithm = "RSA"
}

resource "ibm_compute_ssh_key" "temp_public_key" {
  label      = "Temp Public Key"
  public_key = "${tls_private_key.ssh.public_key_openssh}"
}

# Create a new virtual guest using image "Debian"
resource "ibm_compute_vm_instance" "debian_small_virtual_guest" {
  hostname                 = "${var.hostname}"
  os_reference_code        = "DEBIAN_9_64"
  domain                   = "ed.blog.br"
  datacenter               = "wdc01"
  network_speed            = 10
  hourly_billing           = true
  private_network_only     = false
  cores                    = 1
  memory                   = 1024
  disks                    = [25, 10, 20]
  user_metadata            = "{\"value\":\"newvalue\"}"
  dedicated_acct_host_only = false
  local_disk               = false
  ssh_key_ids              = ["${ibm_compute_ssh_key.temp_public_key.id}"]
  private_security_group_ids  = ["1066361","1066367","1066369"]
  

 # Specify the ssh connection
  connection {
    user        = "root"
    private_key = "${tls_private_key.ssh.private_key_pem}"
    host        = "${self.ipv4_address}"
  }

  provisioner "remote-exec" {
    inline = [
      "echo \"root:${var.password}\" | chpasswd",
      "apt-get update",
      "apt-get install python ansible git -y",
      "echo \"[apache]\" >> /etc/ansible/hosts",
      "echo $(/sbin/ip -o -4 addr list eth1 | awk '{print $4}' | cut -d/ -f1) >> /etc/ansible/hosts",
      "git clone https://github.com/eduardorj/ansible-playbooks.git",
      "ansible-playbook ./ansible-playbooks/apache.yaml --connection=local",
    ]
  }


}

output "vm_ip" {
  value = "Public : ${ibm_compute_vm_instance.debian_small_virtual_guest.ipv4_address}"
}