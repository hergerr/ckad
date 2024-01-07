#!/bin/bash

# 1
kubectl run frontend --image=nginx --restart=Never --port=80 -l tier=frontend,app=ngnix

# 2
kubectl run backend --image=nginx --restart=Never --port=80 -l tier=backend,app=nginx

# 3
# task3.yaml

# 4
kubectl get service
kubectl run test --rm -it --image=busybox --restart=Never  -- /bin/sh
wget --spider --timeout=1 10.106.146.63:9000
# it does not select any pod. labels are not matching

# 5
# change labels to tier: backend app: nginx
# repeat the steps from #4

# 6
# task6.yaml
minikube ip
wget --spider --timeout=1 192.168.49.2:30000

# 7
# task7.yaml
