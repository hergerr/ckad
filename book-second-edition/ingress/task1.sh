kubectl create deployment web --image=bmuschko/nodejs-hello-world:1.0.0 --replicas=1 --port=3000
kubectl create service clusterip web --tcp=3000:3000
kubectl run temp --image=busybox --restart=Never --rm -it -- wget -O- web:3000
kubectl create ingress web --rule="hello-world.exposed/=web:3000"
# entry in /etc/hosts - loadbalance (minikube) ip mapped to the custom URL
192.168.49.2 hello-world.exposed
curl hello-world.exposed/