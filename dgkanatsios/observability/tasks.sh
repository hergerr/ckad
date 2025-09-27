# Create an nginx pod with a liveness probe that just runs the command 'ls'. Save its YAML in pod.yaml. Run it, check its probe status, delete it.
# task1.yaml
kubectl describe pod nginx
kubectl delete pod nginx  --force

# Modify the pod.yaml file so that liveness probe starts kicking in after 5 seconds whereas the interval between probes would be 5 seconds. Run it, check the probe, delete it.
# task2.yaml
kubectl delete pod nginx  --force

# Create an nginx pod (that includes port 80) with an HTTP readinessProbe on path '/' on port 80. Again, run it, check the readinessProbe, delete it.
# task3.yaml
kubectl describe nginx
kubectl delete pod nginx  --force

# Create a busybox pod that runs i=0; while true; do echo "$i: $(date)"; i=$((i+1)); sleep 1; done. Check its logs
kubectl run busybox --dry-run=client -o=yaml  --image=busybox --restart=Never -- /bin/sh -c 'i=0; while true; do echo "$i: $(date)"; i=$((i+1)); sleep 1; done' 
kubectl logs busybox

# Create a busybox pod that runs 'ls /notexist'. Determine if there's an error (of course there is), see it. In the end, delete the pod
kubectl run busybox --image=busybox --command -- /bin/sh -c "ls /notexist"
kubectl logs busybox
kubectl delete pod busybox  --force

# Create a busybox pod that runs 'notexist'. Determine if there's an error (of course there is), see it. In the end, delete the pod forcefully with a 0 grace period
kubectl run busybox --image=busybox --command -- /bin/sh -c "notexist"
kubectl logs busybox
kubectl delete pod busybox  --force

# Get CPU/memory utilization for nodes (metrics-server must be running)
kubectl top nodes