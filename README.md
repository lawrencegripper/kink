# Warning

This is a point in time sample and won't be actively maintained, it serves as an example only. Be warned this uses a `privileged` so the normal security warnings apply. 

# What does it do?

This shows how to start a [KIND]() cluster as a pod inside an existing Kubernetes cluster. To do this is uses Docker in Docker, as such it should be used with caution and may not work for all use cases. 

# Using it

`kubectl apply -f pod.yaml` will fire up the example using my image and create a cluster in a pod. 

To customize use:

> Note: set the `DOCKER_USER` and `IMAGE_NAME` values to point to your container repo. For example `DOCKER_USER=lawrencegripper IMAGE_NAME=kink make deploy` 

- `make build` to build docker image
- `make terminal` to test locally 
- `make push` to push image to dockerhub
- `make deploy` to do all of these then deploy into k8s

# What does it do?

`make deploy` will 

- Create a `kind-pod` pod in your cluster
- Inside that pod a `kind` cluster will be created
- Mongo will be started in the newly created `kind` cluster
- Logs of all of this will be outputted back to you via the hosting `pod`

The image the `pod` uses to run is in [Dockerfile](./Dockerfile), it's [pod definition is in ./pod.yaml](./pod.yaml) and the script it runs in start is [runkind.sh](./runkind.sh)