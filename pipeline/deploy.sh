#! /bin/bash -e

# source environment variables (these come from shippable.resources.yml when running via Shippable pipeline)
# set -a
# source ./variables.env
# set +a

echo "deploying to Kubernetes cluster..."

# set context for Kube deployment
kubectl config use-context useast1.dev.example-kube-cluster.com

# for each yaml template, replace environment variables with values
for file in $GIT_REPO/pipeline/deployTemplates/*.yaml; do
  TEMPLATE=$file
  echo 'docker_repo_2 - '$DOCKER_REPOSITORY
  echo 'docker_tag_2 - '$TAG
  DEST=$(echo $(basename $file) | sed 's/-template//')
  envsubst < $TEMPLATE > $GIT_REPO/pipeline/deploySpecs/$DEST
  cat $GIT_REPO/pipeline/deploySpecs/$DEST
done;

# # for each deploySpec, execute deployment to Kube cluster
# # specific to the environment
# ENVIRONMENT=$(echo "$ENVIRONMENT" | awk '{print tolower($0)}')
# for file in $GIT_REPO/pipeline/deploySpecs/*.yaml; do
#   echo "processing "$file
#   baseFile=${file##*/}
#   deploymentName=${baseFile%.yaml}-$ENVIRONMENT
#   kubectl apply -f $file --record
#   STATUS=""
#   while [[ "$STATUS" != *"successfully rolled out"* ]]; do
#     STATUS=$(kubectl rollout status deployments $deploymentName)
#     echo -e $STATUS\n
#     sleep 1
#   done
# done;
