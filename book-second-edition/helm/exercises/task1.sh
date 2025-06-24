helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update prometheus-community
helm search repo prometheus-community
helm install test prometheus-community/kube-prometheus-stack
kubectl get service prometheus-operated
kubectl port-forward service/prometheus-operated 8080:9090
helm uninstall test