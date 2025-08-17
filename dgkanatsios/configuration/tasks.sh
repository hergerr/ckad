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

# Create a configMap 'anotherone' with values 'var6=val6', 'var7=val7'. Load this configMap as env variables into a new nginx pod

# Create a configMap 'cmvolume' with values 'var8=val8', 'var9=val9'. Load this as a volume inside an nginx pod on path '/etc/lala'. Create the pod and 'ls' into the '/etc/lala' directory.
