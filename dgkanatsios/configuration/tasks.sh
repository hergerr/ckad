# Create a configmap named config with values foo=lala,foo2=lolo
kubectl create configmap config --from-literal=foo=lala --from-literal=foo2=lolo

# Display its values
kubectl get configmap config -o yaml

# Create and display a configmap from a file
kubectl create configmap config-from-file --from-file="configuration/configfile"
kubectl get configmap config-from-file -o yaml

# Create and display a configmap from a .env file
kubectl create configmap config-from-env  --from-env-file=configuration/.envfile
kubectl get configmap config-from-env -o yaml

# Create and display a configmap from a file, giving the key 'special'
# Create the file with echo -e "var3=val3\nvar4=val4" > config4.txt
kubectl create cm configmap4 --from-file=special=config4.txt
kubectl get cm configmap4 -o yaml

# Create a configMap called 'options' with the value var5=val5. Create a new nginx pod that loads the value from variable 'var5' in an env variable called 'option'
kubectl create cm options --from-literal=var5=val5
# task1.yaml

# Create a configMap 'anotherone' with values 'var6=val6', 'var7=val7'. Load this configMap as env variables into a new nginx pod
kubectl create cm anotherone --from-literal=var6=val6 --from-literal=var7=val7
# task2.yaml

# Create a configMap 'cmvolume' with values 'var8=val8', 'var9=val9'. Load this as a volume inside an nginx pod on path '/etc/lala'. Create the pod and 'ls' into the '/etc/lala' directory.
kubectl create cm cmvolume --from-literal=var8=val8 --from-literal=var9=val9
# task3.yaml
kubectl exec -it nginx3 -- bash

# Create the YAML for an nginx pod that runs with the user ID 101. No need to create the pod
kubectl run nginx --image=nginx --dry-run=client -o=yaml | tee dgkanatsios/configuration/task4.yaml
# task4.yaml

# Create the YAML for an nginx pod that has the capabilities "NET_ADMIN", "SYS_TIME" added to its single container
kubectl run nginx --image=nginx --dry-run=client -o=yaml | tee dgkanatsios/configuration/task5.yaml
# task5.yaml

# Create an nginx pod with requests cpu=100m,memory=256Mi and limits cpu=200m,memory=512Mi
kubectl run limitrange --image=nginx --dry-run=client -o=yaml | tee dgkanatsios/configuration/task6.yaml
# task6.yaml

# Create a namespace named limitrange with a LimitRange that limits pod memory to a max of 500Mi and min of 100Mi
kubectl create ns limitrange --dry-run=client -o=yaml | tee dgkanatsios/configuration/task7.yaml 
# task7.yaml

# Describe the namespace limitrange
kubectl describe ns limitrange

# Create an nginx pod that requests 250Mi of memory in the limitrange namespace
# task8.yaml

# Create ResourceQuota in namespace one with hard requests cpu=1, memory=1Gi and hard limits cpu=2, memory=2Gi.
# task9.yaml

# Attempt to create a pod with resource requests cpu=2, memory=3Gi and limits cpu=3, memory=4Gi in namespace one
# task10.yaml
# pods "rejected" is forbidden: exceeded quota

# Create a pod with resource requests cpu=0.5, memory=1Gi and limits cpu=1, memory=2Gi in namespace one
# task11.yaml

# Create a secret called mysecret with the values password=mypass
kubectl create secret generic mysecret --from-literal=passwort=mypass

# Create a secret called mysecret2 that gets key/value from a file
# Create a file called username with the value admin:
# echo -n "admin" > username
kubectl create secret generic mysecret2 --from-file=username

# Get the value of mysecret2
kubectl get secret mysecret2 -o yaml
echo -n YWRtaW4= | base64 -d #

# Create an nginx pod that mounts the secret mysecret2 in a volume on path /etc/foo
# task12.yaml

# Delete the pod you just created and mount the variable 'username' from secret mysecret2 onto a new nginx pod in env variable called 'USERNAME'
# task13.yaml

# Create a Secret named 'ext-service-secret' in the namespace 'secret-ops'. Then, provide the key-value pair API_KEY=LmLHbYhsgWZwNifiqaRorH8T as literal.
kubectl create ns secret-ops
kubectl create secret generic ext-service-secret --from-literal=API_KEY=LmLHbYhsgWZwNifiqaRorH8T -n secret-ops

# Consuming the Secret. Create a Pod named 'consumer' with the image 'nginx' in the namespace 'secret-ops' and consume the Secret as an environment variable. Then, open an interactive shell to the Pod, and print all environment variables.
# task14.yaml
kubectl exec -n=secret-ops -it consumer -- env

# Create a Secret named 'my-secret' of type 'kubernetes.io/ssh-auth' in the namespace 'secret-ops'. Define a single key named 'ssh-privatekey', and point it to the file 'id_rsa' in this directory.
kubectl create secret generic my-secret --type=kubernetes.io/ssh-auth -n=secret-ops --from-file=ssh-privatekey=/home/tymek/Repos/ckad/id_rsa

# Create a Pod named 'consumer' with the image 'nginx' in the namespace 'secret-ops', and consume the Secret as Volume. Mount the Secret as Volume to the path /var/app with read-only access. Open an interactive shell to the Pod, and render the contents of the file.
# task15.yaml
kubectl exec -n=secret-ops -it consumer -- cat /var/app/ssh-privatekey 