kubectl apply -n stress-test -f stress-test/
kubectl top pod stress-1
kubectl top pod stress-2
kubectl top pod stress-3
# or
kubectl top pods