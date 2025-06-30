kubectl logs date-recorder
# interacting with distroless container
kubectl debug  -it date-recorder --image=busybox
# no file is present, likely stuck in while loop
# suggestion - change filepath to /tmp/startup-marker.txt