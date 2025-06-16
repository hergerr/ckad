kubectl logs complex-pod -c init
kubectl exec -it complex-pod -c app -- /bin/sh
kubectl delete complex-pod --force