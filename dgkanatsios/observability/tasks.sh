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
