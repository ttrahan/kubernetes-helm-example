#! /bin/sh -e

$pwd

# source inputs ('IN:'s from shippable.jobs.yml) to job
for f in /build/IN/repo-sample-kube/gitRepo/pipeline/inputs/* ; do
  source $f ;
done
# input parameters
JOB=$1
SCRIPT_REPO=$2
PARAMS_RESOURCE=$3
INTEGRATION=$4
# execute
get_previous_statefile $JOB
get_params $PARAMS_RESOURCE
get_integration $INTEGRATION

# install linux tools
. install/installGlobal.sh

# install AWS CLI
. install/installAwsCli.sh

# install Kubectl CLI
. install/installKubeCli.sh

# # install all dependencies required to execute deployment
# # DISTRO=alpine
# DISTRO=ubuntu
# if [ $DISTRO == ubuntu ]; then
#   TOOL="sudo apt-get"
#   INSTALL_CMD="apt-get install"
# elif [ $DISTRO == alpine ]; then
#   TOOL="apk"
#   INSTALL_CMD="apk add"
# else
#   echo "Linux distro not supported"
#   # exit
# fi
# # update the package index and install linux tools
# $TOOL update
# $INSTALL_CMD gettext curl sudo bash jq unzip
#
# # # environment variables (use after 1/21/2016 release)
# # export AWS_ACCESS_KEY_ID=$INTAWS_INTEGRATION_AWS_ACCESS_KEY_ID
# # export AWS_SECRET_ACCESS_KEY=$INTAWS_INTEGRATION_AWS_SECRET_ACCESS_KEY
#
# # install AWS CLI
# # install Python and PIP if not installed
# if [[ ! $(which python) ]]; then
#   sudo $INSTALL_CMD python
#   curl -O https://bootstrap.pypa.io/get-pip.py
#   sudo python get-pip.py
# fi
# # install AWS CLI
# if [[ ! $(which aws) ]]; then
#   sudo $(which pip) install awscli
#   if [[ $(aws help) ]]; then
#     echo "AWS CLI installed successfully"
#   fi
# fi
#
# # add Kube config
# if [[ ! -d ~/.aws ]]; then
#   mkdir ~/.kube
# fi
#
# # copy shared credentials from S3 bucket to job node
# aws s3 cp s3://clusters.example-kube-cluster.com/config ~/.kube/config
#
# # install Kubernetes CLI
# if [[ ! $(which kubectl) ]]; then
#   curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
#   chmod +x ./kubectl
#   sudo mv ./kubectl /usr/local/bin/kubectl
# fi
