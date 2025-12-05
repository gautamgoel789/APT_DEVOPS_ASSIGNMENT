#!/usr/bin/env bash
set -euo pipefail

echo " One-click deployment starting..."
cd terraform

echo " Initializing Terraform..."
terraform init -upgrade

echo "  Deploying AWS infrastructure..."
terraform apply -auto-approve

echo " Deployment complete!"
echo " Application Load Balancer DNS:"
terraform output alb_dns

