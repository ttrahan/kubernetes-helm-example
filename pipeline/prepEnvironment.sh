#! /bin/sh -e

# As an example, the following environment variables are automatically injected
# into the job environment by Shippable based on the Inputs to the
# 'kube-deploy-test-sample' runSh job:

if [[ -z ${PARAMSTESTKUBE_PARAMS_ENVIRONMENT} ]]; then
  export ENVIRONMENT=$PARAMSTESTKUBE_PARAMS_ENVIRONMENT
  export SAMPLE_PORT=$PARAMSSAMPLETESTKUBE_PARAMS_PORT
  export SAMPLE_GITREPO=$REPOSAMPLEKUBE_PATH
  export SAMPLE_IMAGE_URL=$IMGSAMPLEKUBE_POINTER_SOURCENAME
  export SAMPLE_IMAGE_TAG=$IMGSAMPLEKUBE_VERSION_VERSIONNAME
  export SAMPLE_MEMORY=$IMGOPTSSAMPLEKUBETEST_VERSION_MEMORY
  export SAMPLE_CPU= $IMGOPTSSAMPLEKUBETEST_VERSION_CPUSHARES

elif [[ -z ${PARAMSPRODKUBE_PARAMS_ENVIRONMENT} ]]; then
  export ENVIRONMENT=$PARAMSPRODKUBE_PARAMS_ENVIRONMENT
  export SAMPLE_PORT=$PARAMSSAMPLEPRODKUBE_PARAMS_PORT
  # export SAMPLE_IMAGE_URL= {loaded from previous state below}
  # export SAMPLE_IMAGE_TAG= {loaded from previous state below}
  export SAMPLE_MEMORY=$IMGOPTSSAMPLEKUBEPROD_VERSION_MEMORY
  export SAMPLE_CPU= $IMGOPTSSAMPLEKUBEPROD_VERSION_CPUSHARES
fi

# source functions used in this script
for f in $REPOSAMPLEKUBE_PATH/gitRepo/pipeline/scriptFunctions/*.* ; do
  source $f ;
done

# install shell tools required
install_ShellTools

# install required CLIs
install_AwsCli
install_KubectlCli

# load previous state
# load_state_variables
