# Create busybox pod with two containers, each one will have the image busybox and will run the 'sleep 3600' command. 
# Make both containers mount an emptyDir at '/etc/foo'. Connect to the second busybox, 
# write the first column of '/etc/passwd' file to '/etc/foo/passwd'. Connect to the first busybox and write '/etc/foo/passwd' file to standard output. Delete pod.
kubectl run busybox --image=busybox --command --dry-run=client -o=yaml  -- /bin/sh -c "sleep 3600" | tee dgkanatsios/state/task1.yaml
kubectl exec -it busybox -c busybox-2 -- sh
# inside the second container
head -n 1 /etc/passwd > /etc/foo/passwd
kubectl exec -it busybox -c busybox-1 -- sh
ls /etc/foo/passwd
kubectl delete pod --force busybox

# Create a PersistentVolume of 10Gi, called 'myvolume'. Make it have accessMode of 'ReadWriteOnce' and 'ReadWriteMany',
# storageClassName 'normal', mounted on hostPath '/etc/foo'. Save it on pv.yaml, add it to the cluster. 
# Show the PersistentVolumes that exist on the cluster
# task2.yaml
kubectl apply -f dgkanatsios/state/task2.yaml
kubectl get pv

# Create a PersistentVolumeClaim for this PersistentVolume, called 'mypvc', a request of 4Gi and an accessMode 
# of ReadWriteOnce, with the storageClassName of normal, and save it on pvc.yaml. Create it on the cluster. 
# Show the PersistentVolumeClaims of the cluster. Show the PersistentVolumes of the cluster
# task3.yaml
kubectl get pvc

# Create a busybox pod with command 'sleep 3600', save it on pod.yaml. Mount the PersistentVolumeClaim to
#  '/etc/foo'. Connect to the 'busybox' pod, and copy the '/etc/passwd' file to '/etc/foo/passwd'
kubectl run busybox --image=busybox --command --dry-run=client -o=yaml -- /bin/sh -c "sleep 3600" | tee dgkanatsios/state/task4.yaml 
# task4.yaml
kubectl exec -it busybox -- sh
cp /etc/passwd /etc/foo/

# `Create a second pod which is identical with the one you just created (you can easily do it by changing the
# 'name' property on pod.yaml). Connect to it and verify that '/etc/foo' contains the 'passwd' file. Delete 
# pods to cleanup. Note: If you can't see the file from the second pod, can you figure out why? What would you do to fix that?
# task5.yaml
kubectl exec -it busybox-2 -- sh
ls /etc/foo/
kubectl delete pod --force busybox busybox-2 
kubectl delete pvc --force mypvc
kubectl delete pv --force myvolume

# Create a busybox pod with 'sleep 3600' as arguments. Copy '/etc/passwd' from the pod to your local folder
kubectl run busybox --image=busybox --command -- /bin/sh -c "sleep 3600"
kubectl cp default/busybox:/etc/passwd ./passwd