#! /bin/sh -e

# assign Shippable variables for use in scripts
export ENVIRONMENT=$PARAMSSAMPLETESTKUBE_PARAMS_ENVIRONMENT
export PORT=$PARAMSSAMPLETESTKUBE_PARAMS_PORT
export GIT_REPO=$REPOSAMPLEKUBE_PATH
export DOCKER_REPOSITORY_SAMPLE=$IMGSAMPLEKUBE_POINTER_SOURCENAME
export TAG_SAMPLE=$IMGSAMPLEKUBE_VERSION_VERSIONNAME
export MEMORY=$IMGOPTSSAMPLEKUBETEST_VERSION_MEMORY
export CPU=$IMGOPTSSAMPLEKUBETEST_VERSION_CPUSHARES

# # location of source files referenced in this script
# GIT_REPO="/build/IN/repo-sample-kube/gitRepo/"

# # assign parameters passed into this script
# JOB=$1
# SCRIPT_REPO=$2
# PARAMS_RESOURCE=$3
# INTEGRATION=$4
# IMAGE=$5 # will come from either image resource or predecessor deploy job
# OPTIONS=$6

# source functions used in this script
for f in $GIT_REPO/pipeline/scriptFunctions/*.* ; do
  source $f ;
done

# install shell tools required
install_ShellTools

# # process inputs into environment
# get_previous_statefile $JOB
# get_params $PARAMS_RESOURCE
# get_integration $INTEGRATION
# get_image $IMAGE
# get_docker_options $OPTIONS

# install required CLIs
install_AwsCli
install_KubectlCli
