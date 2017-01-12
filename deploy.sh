#! /bin/bash -e

# source environment variables (these come from shippable.resources.yml when running via Shippable pipeline)
# set -a
# source ./variables.env
# set +a

# for each yaml template, replace environment variables with values
for file in deploy/deployTemplates/*.yaml; do
  TEMPLATE=$file
  DEST=$(echo $(basename $file) | sed 's/-template//')
  envsubst < $TEMPLATE > deploy/deploySpecs/$DEST
done;

# for each deploySpec, execute deployment to Kube cluster
for file in deploy/deploySpecs/*.yaml; do
  echo "processing "$file
  # baseFile=${file#*/}
  # baseFileNoExt=${baseFile%.yaml}
  kubectl apply -f $file --record
done;
