#! /bin/sh -e

# location of source files referenced in this script
GIT_REPO="/build/IN/repo-sample-kube/gitRepo/"

# assign parameters passed into this script
JOB=$1
SCRIPT_REPO=$2
PARAMS_RESOURCE=$3
INTEGRATION=$4
IMAGE=$5

# source functions used in this script
# functions to prepare inputs for environment
for f in $GIT_REPO/pipeline/inputs/* ; do
  source $f ;
done
# functions to install required tools
for f in $GIT_REPO/pipeline/install/* ; do
  source $f ;
done

# install shell tools required
install_ShellTools

# process inputs into environment
# get_previous_statefile $JOB
# get_params $PARAMS_RESOURCE
# get_integration $INTEGRATION
get_image $IMAGE

# install required CLIs
install_AwsCli
install_KubectlCli
