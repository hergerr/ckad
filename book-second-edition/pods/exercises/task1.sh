# 1.(Optional) Generate config
kubectl run nginx --image nginx:1.17.10 --port 80 --namespace ckad --dry-run client -o yaml | tee ex1.yaml
# Create a namespace
kubectl create ns ckad
# run concatainer
kubectl run nginx --image nginx:1.17.10 --port 80 --namespace ckad 
# details
kubectl describe pod nginx -n ckad | grep IP
# temporary container executing wget to nginx pod
ubectl run busyboxx --image=busybox --rm -it --restart=Never -- wget 10.244.0.7:80
# logs of nginx container in nginx pod
kubectl logs nginx -n ckad
# env variables re-creation of the pod is necessary
kubectl remove nginx -n ckad
kubectl run nginx --image nginx:1.17.10 --port 80 --namespace ckad --env DB_URL=postgresql://mydbL5432 --env DB_USERNAME=admin 
# opening a shell
kubectl exec nginx -n ckad -it -- /bin/sh