### Solutions
1. see "task1.yaml"
2. Set namespace first, then get the details
```
kubectl config set-context --current --namespace=ckad
kubectl describe pod nginx
```
3.
```
kubectl run busybox --image=busybox --restart=Never --rm -it -- wget -O /dev/stdout 172.17.0.3:80
```
4.
```
kubectl --namespace=ckad logs nginx
```
5. To generate yaml use / to execute use withoout --dry-run
```
kubectl run nginx --image=nginx --restart=Never --env="DB_URL=postgresql://mydb:5432" --env="DB_USERNAME=admin" --por
t=80 --dry-run=client -o yaml
```

6.
```
kubectl run loop --image=busybox --restart=Never --dry-run=client -o yaml -- bin/sh -c 'for i in 1 2 3 4 5 6 7 8 9 10; do echo "Welcome $i times"; done'
```

8. see "task8.yaml"

9.
```
kubectl describe pod loop | grep Events -C 10
kubectl describe pod loop | grep Status -C 10

```

10.
```
kubectl delete namespace ckad
```