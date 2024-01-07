# 1
# task1.yaml

# 2
# task1.yaml

# 3
kubectl exec -it two-containers-pod -c first -- /bin/sh
mkdir data
vi ...

# 4
kubectl exec -it two-containers-pod -c second -- /bin/sh
cat /etc/b/data/hello.txt

# 5
# task5.yaml
kubectl get persistentvolume logs-pv

# 6
# task6.yaml
kubectl get pv

# 7
# task7.yaml

# 8
kubectl exec -it pod-consuming-pvc -- /bin/sh
touch /var/log/nginx/my-nginx.log

# 9
kubectl delete pod pod-consuming-pvc
kubectl apply -f book/state_persistance/exercises/task7.yaml
kubectl exec -it pod-consuming-pvc -- ls /var/log/nginx/

