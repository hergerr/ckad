kubectl get pods -o wide
kubectl run temp --image=busybox --restart=Never --rm -it -- wget -O- 10.0.0.153