#! /bin/bash -e

echo "deploying to Kubernetes cluster..."

# set context for Kube deployment
kubectl config use-context useast1.dev.example-kube-cluster.com

# update Helm values.yaml with pipeline values 
ENVIRONMENT=$(echo "$ENVIRONMENT" | awk '{print tolower($0)}')
cd $GIT_REPO_PATH/gitRepo
envsubst < ./chartSample/values-template.yaml > ./chartSample/values.yaml

# deploy to Kubernetes cluster via Helm
echo "deploying via Helm"
helm upgrade --install sample-0.0.1 ./chartSample

# # save State to be used in subsequent jobs or next time this job runs. Pass variable names or files (with path) as parameters
save_state_variables SAMPLE_IMAGE_URL SAMPLE_IMAGE_TAG NGINX_IMAGE_URL NGINX_IMAGE_TAG
save_state_files /build/IN/img-sample-kube/version.json
