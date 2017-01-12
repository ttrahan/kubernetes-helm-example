#! /bin/bash -e

echo "installing kubectl CLI..."

# adjust for distro and export variables via .bash_profile for new shells
if [ $DISTRO == ubuntu ]; then
  export TOOL="sudo apt-get"
  export INSTALL_CMD="apt-get install"
elif [ $DISTRO == alpine ]; then
  export TOOL="apk"
  export INSTALL_CMD="apk add"
else
  echo "Linux distro not supported"
  # exit
fi

# add Kube config
if [[ ! -d ~/.aws ]]; then
  mkdir ~/.kube
fi

# copy shared credentials from S3 bucket to job node
aws s3 cp s3://clusters.example-kube-cluster.com/config ~/.kube/config

# install Kubernetes CLI
if [[ ! $(which kubectl) ]]; then
  curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
  chmod +x ./kubectl
  sudo mv ./kubectl /usr/local/bin/kubectl
fi
