#! /bin/sh -e

# set path to the Git repo that holds the scripts
# path injected automatically by Shippable based on gitRepo resource as Input
export GIT_REPO_PATH=$REPOSAMPLEKUBEHELM_PATH

# source functions used in this script
for f in $GIT_REPO_PATH/gitRepo/pipeline/scriptFunctions/*.* ; do
  source $f ;
done

# install shell tools required
install_ShellTools

# install required CLIs
install_AwsCli
install_KubectlCli
install_HelmCli

# Leverage the environment variables that were automatically injected
# into the job environment by Shippable (i.e named as Inputs to the
# runSh jobs in shippable.job.yml:

if [[ ! -z ${PARAMSTESTKUBEHELM_PARAMS_ENVIRONMENT} ]]; then
  echo "preparing TEST environment variables..."
  export ENVIRONMENT=$PARAMSTESTKUBEHELM_PARAMS_ENVIRONMENT
  export SAMPLE_PORT=$PARAMSSAMPLETESTKUBEHELM_PARAMS_PORT
  export SAMPLE_MEMORY=$IMGOPTSSAMPLEKUBEHELMTEST_MEMORY
  export SAMPLE_CPU=$IMGOPTSSAMPLEKUBEHELMTEST_CPUSHARES
  export SAMPLE_IMAGE_URL=$IMGSAMPLEKUBEHELM_SOURCENAME
  export SAMPLE_IMAGE_TAG=$IMGSAMPLEKUBEHELM_VERSIONNAME
  export SAMPLE_REPLICAS=$REPLICASSAMPLEKUBEHELMTEST_COUNT
  export NGINX_IMAGE_URL=$IMGNGINX_SOURCENAME
  export NGINX_IMAGE_TAG=$IMGNGINX_VERSIONNAME

  elif [[ ! -z ${PARAMSPRODKUBEHELM_PARAMS_ENVIRONMENT} ]]; then
    echo "preparing PROD environment variables..."
    export INCOMING_STATE_PATH=$KUBEHELMDEPLOYTESTSAMPLE_PATH/runSh
    load_incoming_state_variables # load incoming state from prior job
    export ENVIRONMENT=$PARAMSPRODKUBEHELM_PARAMS_ENVIRONMENT
    export SAMPLE_PORT=$PARAMSSAMPLEPRODKUBEHELM_PARAMS_PORT
    export SAMPLE_MEMORY=$IMGOPTSSAMPLEKUBEHELMPROD_VERSIONMEMORY
    export SAMPLE_CPU=$IMGOPTSSAMPLEKUBEHELMPROD_VERSIONCPUSHARES
    export SAMPLE_REPLICAS=$REPLICASSAMPLEKUBEHELMPROD_VERSIONCOUNT
    export SAMPLE_IMAGE_URL=$SAMPLE_IMAGE_URL_PREVIOUS
    export SAMPLE_IMAGE_TAG=$SAMPLE_IMAGE_TAG_PREVIOUS
    export NGINX_IMAGE_URL=$NGINX_IMAGE_URL_PREVIOUS
    export NGINX_IMAGE_TAG=$NGINX_IMAGE_TAG_PREVIOUS

  else echo "no environment variables loaded"
fi
