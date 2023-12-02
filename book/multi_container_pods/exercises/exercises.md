### Solutions
1. see "task1.yaml"
2. kubectl apply -f ...
3. kubectl logs complex-pod -c setup
4. kubectl exec complex-pod -c app -it -- /bin/sh && ls
5. kubectl delete pod complex-pod --grace-period=0 --force
6. 7. 8. see "task6.yaml"
9. kubectl apply -f ... && kubectl logs data-exchange -c sidecar | tail
10. kubectl delete pod data-exchange --grace-period=0 --force