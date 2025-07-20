# create configmap
kubectl create configmap app-config --from-file=/home/tymek/programs/devops/ckad/book-second-edition/ckad-study-guide/app-a/ch19/configmap/application.yaml
kubectl exec backend -- cat /etc/config/application.yaml