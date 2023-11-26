### Solutions
1. simple bash operations
2.
```
kubectl create secret generic ext-service-secret --from-file=./config
```
3. skip
4. task4.yaml
5. task5.yaml
6. 
```
kubectl exec -it nginx -- env
```
7. task7.yaml. It could not be redefined on the pod level. Container level has precedence. What is more capability is system property, which makes sense only on container level
8. and 9.
```
kubectl create namespace project-firebird
kubectl create -f task8.yaml --namespace=project-firebird
kubectl create secret generic first --from-literal=lol=omg --namespace=project-firebird
```
10. 
```

kubectl create serviceaccount monitoring
# does not work
kubectl run nginx --image=nginx --restart=Never --serviceaccount=monitoring
kubectl exec -it nginx -- /bin/sh
cat /var/run/secrets/kubernetes.io/servivceaccount/token

```