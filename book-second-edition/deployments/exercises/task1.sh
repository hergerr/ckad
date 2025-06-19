kubectl get deployments
kubectl annotate deployment nginx kubernetes.io/change-cause="Pick up patch version"
kubectl rollout history deployment/nginx
kubectl rollout undo deployment/nginx --to-revision=1
kubectl describe deployment nginx