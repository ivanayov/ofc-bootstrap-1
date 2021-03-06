#!/bin/bash

GOOS=$(go env GOOS)
GOARCH=$(go env GOARCH)

release=$(curl -sI https://github.com/bitnami-labs/sealed-secrets/releases/latest | grep Location | awk -F"/" '{ printf "%s", $NF }' | tr -d '\r')
#release=$(curl --silent "https://api.github.com/repos/bitnami-labs/sealed-secrets/releases/latest" | sed -n 's/.*"tag_name": *"\([^"]*\)".*/\1/p')

echo "SealedSecrets release: $release"

kubectl create -f https://github.com/bitnami-labs/sealed-secrets/releases/download/$release/sealedsecret-crd.yaml

kubectl apply -f https://github.com/bitnami-labs/sealed-secrets/releases/download/$release/controller.yaml
