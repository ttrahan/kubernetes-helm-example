#! /bin/bash -e

echo "deploying to Kubernetes cluster..."

# set context for Kube deployment
kubectl config use-context useast1.dev.example-kube-cluster.com

# update Helm values.yaml with pipeline values 
ENVIRONMENT=$(echo "$ENVIRONMENT" | awk '{print tolower($0)}')
envsubst < $GIT_REPO_PATH/chartSample/values-template.yaml > $GIT_REPO_PATH/chartSample/values.yaml

# for each deploySpec, execute deployment to Kube cluster
echo "processing "$file
helm install ./chartSample

# # save State to be used in subsequent jobs or next time this job runs. Pass variable names or files (with path) as parameters
save_state_variables SAMPLE_IMAGE_URL SAMPLE_IMAGE_TAG NGINX_IMAGE_URL NGINX_IMAGE_TAG
save_state_files /build/IN/img-sample-kube/version.json
