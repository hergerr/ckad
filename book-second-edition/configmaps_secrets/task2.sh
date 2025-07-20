kubectl create secret generic db-credentials --from-literal=db-password=passwd
kubectl exec -it backend -- env | grep DB