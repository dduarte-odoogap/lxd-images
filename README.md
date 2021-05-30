
<div class="row">
<img src="https://www.odoo.com/logo.png" width="200" class="column">
<img src="https://linuxcontainers.org/static/img/containers.png" width="150" class="column">
<img src="https://www.terraform.io/assets/images/logo-hashicorp-3f10732f.svg" width="150" class="column">
</div>

# Odoo image for 14.0 based in Ubuntu 20.04 LTS Focal

This image is intended to be isolated from the postgresql container/machine.
I'm using terraform to spin an ubuntu:20.04 container and installing postgresql.

# Build instructions

First install distrobuilder and terraform:

```bash
# install distrobuilder
sudo snap install distrobuilder --classic
# install terraform
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
```

Next you need to edit 14.0/odoo.yaml and point source folders to where you have them on your repo:
(I could clone them in a script just it's slow and this is WIP)

```yaml
- path: /opt/odoo/14.0
  generator: copy
  source: /home/dd/git/odoo/14.0

- path: /opt/odoo/oe14.0
  generator: copy
  source: /home/dd/git/oe/14.0
```


Now you can build it:

```bash
# just run build to build the lxd image
./build.sh

# terraform delete all containers
terraform destroy -auto-approve

# terraform to recreate all
terraform apply -auto-approve
```
