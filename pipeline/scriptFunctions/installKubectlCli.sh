#! /bin/bash

# install Kubectl CLI
install_KubectlCli() {
  echo -n "installing kubectl CLI..."

  # add Kube config
  if [[ ! -d ~/.kube ]]; then
    mkdir ~/.kube
  fi
  echo -n "directory created..."

  # Write credentials to ~/.kube/config
  if [[ -z $INTKUBE_INTEGRATION_MASTERKUBECONFIGCONTENT ]]; then
    # from Shippable Kubernetes account integration named as input to job
    echo "kube config created from shippable integration"
    echo "$INTKUBE_INTEGRATION_MASTERKUBECONFIGCONTENT" > ~/.kube/config
  else
    # from S3 bucket
    aws s3 cp s3://clusters.example-kube-cluster.com/config ~/.kube/config
  fi

  # install Kubernetes CLI
  if [[ ! $(which kubectl) ]]; then
    curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
    chmod +x ./kubectl
    sudo mv ./kubectl /usr/local/bin/kubectl
    if [[ $(kubectl help) ]]; then
      echo "kubectl CLI installed successfully"
    fi
  fi
}
