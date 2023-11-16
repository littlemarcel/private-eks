#!/usr/bin/env bash

CLUSTER_NAME=$1

if [ -z "${CLUSTER_NAME}" ]; then
  echo "Cluster name is missing"
  echo "./create-cluster.sh <cluster-name>"
  exit 1
fi

cd terraform/demo-cluster
terraform workspace select -or-create "$CLUSTER_NAME"
terraform init
terraform apply -auto-approve
