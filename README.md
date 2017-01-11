[![Run Status](https://api.shippable.com/projects/56e93b119d043da07bdda580/badge?branch=master)](https://app.shippable.com/projects/56e93b119d043da07bdda580)

A simple Node.js application with tests. Different branches demonstrate different use cases, as follows:

**master:**
This branch changes frequently for demos, as needed, but typically shows:
  * CI run that builds and pushes a Docker image to a Docker registry (Docker Hub, Quay.io, Amazon ECR, Google Container Registry, etc.)
  * Auto-generate an updated deployment manifest
  * Auto-deploy to a Test environment (e.g. Amazon ECS, Docker Datacenter, Triton, etc.)
  * Manual trigger to create a release candidate for Prod environment
  * Manual deploy to Prod environment

**amazon-ecs:**
* CI run that builds and pushes a Docker image to Amazon EC/2 Container Registry (ECR)
* Auto-generate an updated deployment manifest
* Auto-deploy to a Test environment in Amazon EC/2 Container Service (ECS)   
  * Deployed containers will automatically register listeners with AWS Application Load Balancer
* Manual trigger to create a release candidate for Prod environment
* Manual deploy to Prod environment in Amazon ECS   
  * Deployed containers will automatically register listeners with AWS Application Load Balancer

**gke:**
* CI run that builds and pushes a Docker image to Google Container Registry
* Auto-generate an updated deployment manifest
* Auto-deploy to a Test environment in Google Container Engine (GKE)
* Manual trigger to create a release candidate for Prod environment
* Manual deploy to Prod environment in GKE

**triton:**  
* CI run that builds and pushes a Docker image to Docker Hub
* Note that the app uses the Container Pilot pattern with Consul for Service Discovery
* Auto-generate an updated deployment manifest
* Auto-deploy to a Test environment in Joyent Triton
* Manual trigger to create a release candidate for Prod environment
* Manual deploy to Prod environment in Joyent Triton
