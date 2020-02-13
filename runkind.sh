#! /bin/bash 
set -e
set -x

dockerd &

kind create cluster

kubectl get nodes

JSONPATH='{range .items[*]}{@.metadata.name}:{range @.status.conditions[*]}{@.type}={@.status};{end}{end}'; until kubectl get nodes -o jsonpath="$JSONPATH" 2>&1 | grep -q "Ready=True"; do sleep 5; done

kubectl run example-pod -l target=true --image=grafana/grafana

JSONPATH='{range .items[*]}{@.metadata.name}:{range @.status.conditions[*]}{@.type}={@.status};{end}{end}'; until kubectl -ltarget=true get pods -o jsonpath="$JSONPATH" 2>&1 | grep -q "Ready=True"; do sleep 5;echo "--------> waiting for example-pod pod to be Ready"; kubectl get pods; done

kubectl get pods | grep example-pod | awk '{print $1}' | xargs kubectl logs

kind delete cluster
