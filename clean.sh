#!/bin/sh

# destroy containers
terraform destroy -auto-approve
# delete lxd image
lxc image delete odoo-14.0