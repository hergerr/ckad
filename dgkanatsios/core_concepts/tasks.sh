# Create a namespace called 'mynamespace' and a pod with image nginx called nginx on this namespace
kubectl create namespace mynamespace
kubectl run nginx --image=nginx -n=mynamespace

# Create the pod that was just described using YAML
kubectl run nginx --image=nginx -n=mynamespace --dry-run=client -o=yaml

# Create a busybox pod (using kubectl command) that runs the command "env". Run it and see the output
kubectl run busybox --image=busybox --restart=Never -it --rm -- env

# Create a busybox pod (using YAML) that runs the command "env". Run it and see the output
kubectl run busybox --image=busybox --restart=Never --dry-run=client -o=yaml -- env
kubectl logs busybox

# Get the YAML for a new namespace called 'myns' without creating it
kubectl create ns myns --dry-run=server -o=yaml

# Create the YAML for a new ResourceQuota called 'myrq' with hard limits of 1 CPU, 1G memory and 2 pods without creating it
kubectl create quota myrq --hard=cpu=1,memory=1G,pods=2 --dry-run=client -o=yaml

# Get pods on all namespaces
kubectl get pods --all-namespaces

# Create a pod with image nginx called nginx and expose traffic on port 80
kubectl run nginx --image=nginx --port=80

# Change pod's image to nginx:1.24.0. Observe that the container will be restarted as soon as the image gets pulled
kubectl edit pod nginx

# Get nginx pod's ip created in previous step, use a temp busybox image to wget its '/'
kubectl run tmp --rm -it --image=busybox --restart=Never -- wget 10.0.0.38:80/

# Get pod's YAML
kubectl get pod nginx -o=yaml

# Get information about the pod, including details about potential issues (e.g. pod hasn't started)
kubectl describe pod nginx

# Get pod logs
kubectl logs nginx

# If pod crashed and restarted, get logs about the previous instance
kubectl logs -p nginx

# Execute a simple shell on the nginx pod
kubectl exec -it nginx -- sh

# Create a busybox pod that echoes 'hello world' and then exits
kubectl run busybox --image=busybox --rm -it --restart=Never -- echo "hello world"

# Do the same, but have the pod deleted automatically when it's completed
kubectl run busybox --image=busybox --rm -it --restart=Never -- echo "hello world"

# Create an nginx pod and set an env value as 'var1=val1'. Check the env value existence within the pod
kubectl run nginx --image=nginx --env=var1=val1
kubectl exec nginx -- env | grep var