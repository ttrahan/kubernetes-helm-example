#! /bin/sh -e

# As an example, the following environment variables are automatically injected
# into the job environment by Shippable based on the Inputs to the
# 'kube-deploy-test-sample' runSh job:

if [[ ! -z ${PARAMSTESTKUBE_PARAMS_ENVIRONMENT} ]]; then
  export GIT_REPO_PATH=$REPOSAMPLEKUBE_PATH/gitRepo
  export ENVIRONMENT=$PARAMSTESTKUBE_PARAMS_ENVIRONMENT
  export SAMPLE_PORT=$PARAMSSAMPLETESTKUBE_PARAMS_PORT
  export SAMPLE_MEMORY=$IMGOPTSSAMPLEKUBETEST_VERSION_MEMORY
  export SAMPLE_CPU=$IMGOPTSSAMPLEKUBETEST_VERSION_CPUSHARES
  export SAMPLE_IMAGE_URL=$IMGSAMPLEKUBE_POINTER_SOURCENAME
  export SAMPLE_IMAGE_TAG=$IMGSAMPLEKUBE_VERSION_VERSIONNAME
  export NGINX_IMAGE_URL=$IMGNGINXKUBE_POINTER_SOURCENAME
  export NGINX_IMAGE_TAG=$IMGNGINXKUBE_VERSION_VERSIONNAME

elif [[ ! -z ${PARAMSPRODKUBE_PARAMS_ENVIRONMENT} ]]; then
  export GIT_REPO_PATH=$REPOSAMPLEKUBE_PATH/gitRepo
  export ENVIRONMENT=$PARAMSPRODKUBE_PARAMS_ENVIRONMENT
  export SAMPLE_PORT=$PARAMSSAMPLEPRODKUBE_PARAMS_PORT
  export SAMPLE_MEMORY=$IMGOPTSSAMPLEKUBEPROD_VERSION_MEMORY
  export SAMPLE_CPU=$IMGOPTSSAMPLEKUBEPROD_VERSION_CPUSHARES
  # export SAMPLE_IMAGE_URL= {loaded from previous state of prior job}
  # export SAMPLE_IMAGE_TAG= {loaded from previous state of prior job}
  # export NGINX_IMAGE_URL= {loaded from previous state of prior job}
  # export NGINX_IMAGE_TAG= {loaded from previous state of prior job}
fi

# source functions used in this script
for f in $GIT_REPO_PATH/pipeline/scriptFunctions/*.* ; do
  source $f ;
done

# install shell tools required
install_ShellTools

# install required CLIs
install_AwsCli
install_KubectlCli

# load previous state
load_state_variables
