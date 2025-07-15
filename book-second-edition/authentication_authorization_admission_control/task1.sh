# https://kubernetes.io/docs/tasks/tls/certificate-issue-client-csr/
kubectl config set-context mary-context --cluster=minikube --user=mary
kubectl config get-contexts
kubectl config use-context mary-context
# creating of a new pod not allowed:
# Error from server (Forbidden): pods is forbidden: User "mary" cannot create resource "pods" in API group "" in the namespace "default"