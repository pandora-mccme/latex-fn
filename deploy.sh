#!/bin/bash
set -e

kubectl -n openfaas port-forward svc/gateway 8080 &
PF_PID=$!
trap "kill $PF_PID" EXIT

until curl -sf http://localhost:8080/healthz > /dev/null 2>&1; do sleep 1; done

kubectl -n openfaas get secret -o yaml basic-auth | yq .data.basic-auth-password | base64 -d | faas-cli login --password-stdin

faas-cli deploy
