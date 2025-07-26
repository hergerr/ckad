kubectl create service clusterip myapp --tcp=80:80
kubectl create deployment myapp --image=nginx:1.23.4-alpine --port=80 --replicas=1
kubectl scale --replicas=2 deployment/myapp
kubectl run  temp --image=busybox:1.36.1 -it --restart=Never -it --rm -- wget myapp:80
kubectl create service nodeport myapp --tcp=80
minikube ip / kubectl get nodes && kubectl describe minikube
wget 192.168.49.2:31805