#!/bin/bash

# 1
kubectl run pod-1 --image=nginx --labels tier=frontend,team=artemidis
kubectl run pod-2 --image=nginx --labels tier=backend,team=artemidis
kubectl run pod-3 --image=nginx --labels team=artemidis

# 2
kubectl annotate pod pod-1 deployer=tyfr
kubectl annotate pod pod-3 deployer=tyfr

# 3
kubectl get pods -l 'team in (artemidis, aircontrol)',tier=backend --show-labels

# 4
# see "task4.yaml"
# or
kubectl create deployment server-deployment --image=grand-server:1.4.6 &&
kubectl scale deployment server-deployment --replicas=2

# 5
kubect logs pod ...

# 6
kubectl set image deployment server-deployment grand-server=nginxs
kubectl rollout history deployment server-deployment

# 7
kubectl create cronjob google-ping --schedule="*/2 * * * *" --image=nginx -- /bin/sh -c 'curl google.com'

# 8
kubect logs ...

# 9
# see "task9.yaml"

# 10
# concurencyPolicy: Forbid