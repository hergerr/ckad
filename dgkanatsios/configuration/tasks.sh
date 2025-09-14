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
