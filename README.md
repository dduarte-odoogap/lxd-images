<img src="https://www.odoo.com/logo.png" width="250">
<div class="row">
<img src="https://linuxcontainers.org/static/img/containers.png" width="80" class="col px-5">
<img src="https://www.terraform.io/assets/images/logo-hashicorp-3f10732f.svg" width="220" class="col px-5">
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

Next you need to update submodules:

```bash
git submodule update --init --recursive
```

Now you can build it:

```bash
# just run build to build the lxd image
# this will build the community edition, 
# to change to enterprise just replace odoo.yaml by odoo-enterprise.yaml
./build.sh

# terraform delete all containers
terraform destroy -auto-approve

# terraform to recreate all
terraform apply -auto-approve
```
