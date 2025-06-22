kubectl run tester --image=alpine/curl:3.14 --rm -it -- sh
curl 10.100.195.245:80

# more correct
kubectl run tester --image=alpine/curl:3.14 --rm --restart=Never -it -- curl -I 10.100.195.245:80