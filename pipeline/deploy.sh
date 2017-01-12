#! /bin/bash -e

# source environment variables (these come from shippable.resources.yml when running via Shippable pipeline)
set -a
source ./variables.env
set +a

echo "deploying to Kubernetes cluster..."

# set context for Kube deployment
kubectl config use-context useast1.dev.example-kube-cluster.com

# for each yaml template, replace environment variables with values
for file in pipeline/deployTemplates/*.yaml; do
  TEMPLATE=$file
  DEST=$(echo $(basename $file) | sed 's/-template//')
  envsubst < $TEMPLATE > pipeline/deploySpecs/$DEST
done;

# for each deploySpec, execute deployment to Kube cluster
for file in pipeline/deploySpecs/*.yaml; do
  echo "processing "$file
  # baseFile=${file#*/}
  # baseFileNoExt=${baseFile%.yaml}
  kubectl apply -f $file --record
done;
