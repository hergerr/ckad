kubectl describe pod nginx -n=k2 | grep IP
kubectl run temp --image=busybox --restart=Never --rm -it -n=k1 -- wget -T 5 10.0.0.18:80 # failed