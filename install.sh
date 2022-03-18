#! /bin/bash
# Quick script from those instructions: https://www.keycloak.org/docs/latest/server_installation/index.html#_install_by_command

kubectl apply -f deploy/crds/ || true
kubectl create namespace myproject || true

kubectl apply -f deploy/role.yaml -n myproject || true
kubectl apply -f deploy/role_binding.yaml -n myproject || true
kubectl apply -f deploy/service_account.yaml -n myproject || true

kubectl apply -f deploy/operator.yaml -n myproject || true
