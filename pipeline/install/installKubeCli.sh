#! /bin/bash -e

echo "installing kubectl CLI..."

# add Kube config
- mkdir ~/.kube
- aws s3 cp s3://clusters.example-kube-cluster.com/config ~/.kube/config

# install Kubernetes CLI
if [[ ! $(which kubectl) ]]; then
  curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
  chmod +x ./kubectl
  sudo mv ./kubectl /usr/local/bin/kubectl
fi
