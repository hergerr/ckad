kubectl get pv
kubectl exec -i -t logs-pvc-pod -- sh
kubectl exec -i logs-pvc-pod -- ls /var/log/nginx/