#! /bin/bash -e

# install Helm CLI 
install_HelmCli() {
  echo -n "installing Helm CLI..."

  # install Helm
  curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > get_helm.sh
  chmod 700 get_helm.sh
  ./get_helm.sh

  # initialize Helm (must follow kubectl installation)
  helm init

  if [[ ! $(which helm) ]]; then
    if [[ $(aws help) ]]; then
      echo "Helm CLI installed successfully"
    fi
  fi
}
