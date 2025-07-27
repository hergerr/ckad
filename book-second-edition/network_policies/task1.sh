kubectl describe pod -n=internal backend | grep IP
kubectl run temp --image=busybox -n=end-user --restart=Never -it --rm -- wget -T 5 10.0.0.146
# conntect to frontend pod
kubectl exec -it frontend -n=end-user -- sh
wget -T 5 10.0.0.146 # works
wget -T 5 10.244.2.44  # does not work
kubectl delete netpol --force -n=end-user app-stack
wget -T 5 10.244.2.44  # works
