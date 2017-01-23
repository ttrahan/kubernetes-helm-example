#! /bin/sh -e

# assign Shippable variables for use in scripts
export ENVIRONMENT=$PARAMSSAMPLETESTKUBE_PARAMS_ENVIRONMENT
export PORT=$PARAMSSAMPLETESTKUBE_PARAMS_PORT
export GIT_REPO=$REPOSAMPLEKUBE_PATH
export DOCKER_REPOSITORY_SAMPLE=$IMGSAMPLEKUBE_POINTER_SOURCENAME
export TAG_SAMPLE=$IMGSAMPLEKUBE_VERSION_VERSIONNAME
export MEMORY=$IMGOPTSSAMPLEKUBETEST_VERSION_MEMORY
export CPU=$IMGOPTSSAMPLEKUBETEST_VERSION_CPUSHARES

# source functions used in this script
for f in $GIT_REPO/pipeline/scriptFunctions/*.* ; do
  source $f ;
done

# install shell tools required
install_ShellTools

# install required CLIs
install_AwsCli
install_KubectlCli
