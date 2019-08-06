resource "tls_private_key" "ssh" {
  algorithm = "RSA"
}

resource "ibm_compute_ssh_key" "temp_public_key" {
  label      = "Temp Public Key"
  public_key = "${tls_private_key.ssh.public_key_openssh}"
}

resource "ibm_compute_vm_instance" "softlayer_virtual_guest" {
  hostname                 = "${var.hostname}"
  os_reference_code        = "CENTOS_7_64"
  domain                   = "ed.blog.br"
  datacenter               = "wdc01"
  network_speed            = 10
  hourly_billing           = true
  private_network_only     = false
  cores                    = 2
  memory                   = 2048
  disks                    = [25]
  dedicated_acct_host_only = false
  local_disk               = false
  ssh_key_ids              = ["${ibm_compute_ssh_key.temp_public_key.id}"]

  # Specify the ssh connection
  connection {
    user        = "root"
    private_key = "${tls_private_key.ssh.private_key_pem}"
    host        = "${self.ipv4_address}"
  }

  provisioner "remote-exec" {
    inline = [
      "echo \"root:${var.password}\" | chpasswd",
    ]
  }
}

output "The IP address of your server is:" {
  value = "${ibm_compute_vm_instance.softlayer_virtual_guest.ipv4_address}"
}