DOCKER_USER?=lawrencegripper
IMAGE_NAME?=kink

build:
	docker build -t ${DOCKER_USER}/${IMAGE_NAME}:latest .

run: build
	docker run --privileged -v /sys/fs/cgroup:/sys/fs/cgroup -v /lib/modules:/lib/modules -it ${DOCKER_USER}/${IMAGE_NAME}:latest 

push: build
	docker push ${DOCKER_USER}/${IMAGE_NAME}:latest

terminal: build
	docker run -it --privileged --entrypoint /bin/bash ${DOCKER_USER}/${IMAGE_NAME}:latest

clear:
	kubectl delete pod kind-pod || true

deploy: push clear
	kubectl apply -f ./pod.yaml
	# todo fix up to use smarts to wait for the pod to start
	sleep 20
	kubectl logs -f kind-pod
	kubectl delete pod kind-pod