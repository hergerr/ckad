kubectl run pod-4 --image=nginx:1.25.1 -l=app.kubernetes.io/name=F5-nginx,app.kubernetes.io/managed-by=helm
kubectl describe pod pod-4
kubectl get pods --show-labels