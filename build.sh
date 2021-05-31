#!/bin/sh

# build lxd image
sudo distrobuilder build-lxd 14.0/odoo.yaml
# sudo distrobuilder build-lxd 14.0/odoo-enterprise.yaml

# import image to lxd
lxc image import lxd.tar.xz rootfs.squashfs --alias odoo-14.0
terraform apply -auto-approve
