#! /bin/bash

docker build . -t docker.io/andreatp/keycloak-operator:test

SHA=$(docker push docker.io/andreatp/keycloak-operator:test | grep digest | sed 's/.*digest\: //' | sed 's/ size.*//')

echo "New SHA is $SHA"

cat deploy/operator.yaml | sed "s|          image: quay.io/keycloak/keycloak-operator:main|          image: docker.io/andreatp/keycloak-operator@$SHA|" | kubectl apply -n myproject -f -
