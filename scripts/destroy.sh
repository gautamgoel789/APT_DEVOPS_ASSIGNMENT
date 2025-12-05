#!/usr/bin/env bash
set -euo pipefail

echo " Destroying AWS infrastructure..."
cd terraform

# Ensure state is not corrupted
rm -rf .terraform
terraform init -upgrade

terraform destroy -auto-approve

echo " Removing local Terraform state..."
rm -f terraform.tfstate terraform.tfstate.backup .terraform.lock.hcl

echo " All resources destroyed successfully!"
