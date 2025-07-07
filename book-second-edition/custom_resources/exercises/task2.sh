kubectl describe crds backups.example.com
kubectl apply -f custom_resources/exercises/task2_obj.yaml 
kubectl get backups
kubectl describe backup nginx-backup