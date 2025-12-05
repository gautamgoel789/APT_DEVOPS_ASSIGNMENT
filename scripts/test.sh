#!/usr/bin/env bash
set -euo pipefail

if [ -z "$1" ]; then
  echo "Usage: ./test.sh <ALB_DNS>"
  exit 1
fi

ALB="$1"

echo " Testing root endpoint..."
curl -v http://$ALB/

echo -e "\n Testing /health endpoint..."
curl -v http://$ALB/health

