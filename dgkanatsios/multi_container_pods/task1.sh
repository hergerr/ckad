# Create a Pod with two containers, both with image busybox and command "echo hello; sleep 3600". Connect to the second container and run 'ls'
kubectl run busybox --image=busybox --dry-run=client -o=yaml --command -- /bin/sh -c "echo hello; sleep 3600" | tee multi_container_pods/task1.yaml
kubectl exec busybox -c busybox2 -- ls