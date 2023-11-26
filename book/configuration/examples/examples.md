### Examples
1. ConfigMaps
```
# literal
kubectl create configmap db-config1 --from-literal=db=staging
# env file
kubectl create configmap db-config2 --from-env-file=/tmp/example
# file or directory
kubectl create configmap db-config3 --from-file=/tmp

```
2. Secrets
```
# literal
kubectl create secret generic db-creds1 --from-literal=pwd=xxx
# env file
kubectl create secret generic db-creds2 --from-env-file=/tmp/secret.env
# file / directory
kubectl create secret generic db-creds3 --from-file=/tmp/example

```