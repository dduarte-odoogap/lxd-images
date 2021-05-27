
terraform {
  required_providers {
    lxd = {
      source  = "terraform-lxd/lxd"
      version = "1.5.0"
    }
  }
}

resource "lxd_container" "pg" {
  name             = "pg"
  image            = "ubuntu:20.04"
  ephemeral        = false
  profiles         = ["default"]
  wait_for_network = true

  provisioner "local-exec" {
    command = "lxc exec ${self.name} -- /bin/bash -c 'apt update && apt upgrade -y && apt install -y postgresql'"
  }

  provisioner "local-exec" {
    command = <<-EOT
    lxc file push pg/create-user.sql ${self.name}/tmp/
    lxc exec ${self.name} -- /bin/bash -c 'su - postgres -c "psql < /tmp/create-user.sql "'
    lxc exec ${self.name} -- /bin/bash -c 'service postgresql restart'
    EOT
  }
}

resource "lxd_container" "odoo-14" {
  name             = "odoo-14"
  image            = "odoo-14.0"
  ephemeral        = false
  profiles         = ["default"]
  wait_for_network = true
  depends_on = [lxd_container.pg]

  provisioner "local-exec" {
    command = <<-EOT
    lxc exec ${self.name} -- /bin/bash -c 'service odoo-server stop'
    lxc exec ${self.name} -- /bin/bash -c 'apt update && apt upgrade -y'
    lxc exec ${self.name} -- /bin/bash -c 'su - odoo -s /bin/bash -c "/opt/odoo/14.0/odoo-bin -c /opt/odoo/odoo-server.conf --no-http --stop-after-init --max-cron-threads 0 -i base"'
    lxc exec ${self.name} -- /bin/bash -c 'service odoo-server start'
    EOT
  }
}
