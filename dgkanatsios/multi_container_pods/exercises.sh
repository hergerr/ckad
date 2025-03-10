# Create a Pod with two containers, both with image busybox and command "echo hello; sleep 3600". Connect to the second container and run 'ls'
kubectl run busybox --image=busybox --restart=Never --dry-run=client --output=yaml -- /bin/sh -c 'echo "hello";sleep 3600' 
# task1.yaml
kubectl apply -f dgkanatsios/multi_container_pods/task1.yaml
kubectl exec -it busybox -c busybox2 -- ls


# Create a pod with an nginx container exposed on port 80. Add a busybox init container which downloads a page using 
# "wget -O /work-dir/index.html http://neverssl.com/online". Make a volume of type emptyDir and mount it in both containers. 
# For the nginx container, mount it on "/usr/share/nginx/html" and for the initcontainer, mount it on "/work-dir". 
# When done, get the IP of the created pod and create a busybox pod and run "wget -O- IP
kubectl run nginx --image=nginx --restart=Never --port=80 --dry-run=client -o=yaml
# task2.yaml
kubectl apply -f dgkanatsios/multi_container_pods/task2.yaml
kubectl get pods nginx --output=wide
kubectl run temp --image=busybox --restart=Never -it --rm -- wget -O- 10.0.0.9
