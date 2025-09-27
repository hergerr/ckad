# Create a pod with image nginx called nginx and expose its port 80
kubectl run nginx --image=nginx --port=80 --expose

# Confirm that ClusterIP has been created. Also check endpoints
kubectl get svc
kubectl get endpoints

# Get service's ClusterIP, create a temp busybox pod and 'hit' that IP with wget
kubectl run busybox --image=busybox --restart=Never --rm -it -- wget 10.99.97.245:80

# Convert the ClusterIP to NodePort for the same service and find the NodePort port. Hit service using Node's IP. Delete the service and the pod at the end.
kubectl edit svc nginx

# Create a deployment called foo using image 'dgkanatsios/simpleapp' (a simple server that returns hostname) and 3 replicas.
# Label it as 'app=foo'. Declare that containers in this pod will accept traffic on port 8080 (do NOT create a service yet)
kubectl create deployment foo --image=dgkanatsios/simpleapp --replicas=3 --port=8080 --dry-run=client -o=yaml | tee dgkanatsios/services/task1.yaml
kubectl apply -f dgkanatsios/services/task1.yaml 

# Get the pod IPs. Create a temp busybox pod and try hitting them on port 8080
kubectl get pods -o wide
kubectl run busybox --image=busybox --restart=Never --rm -it -- wget -O- 10.244.0.71:8080

# Create a service that exposes the deployment on port 6262. Verify its existence, check the endpoints
kubectl create service clusterip foo --tcp=6262:8080
kubectl get svc
kubectl get endpoints

# Create a temp busybox pod and connect via wget to foo service. Verify that each time there's a different hostname returned. Delete deployment and services to cleanup the cluster
kubectl run busybox --image=busybox --restart=Never --rm -it -- wget -O- 10.104.167.189:6262
kubectl delete deployment foo --force
kubectl delete svc foo --force