kubectl run pod-1 --image=nginx:1.25.1 -l tier=frontend,team=artemidis --annotations 'deployer=tyfr'
kubectl run pod-2 --image=nginx:1.25.1 -l tier=backend,team=artemidis
kubectl run pod-3 --image=nginx:1.25.1 -l tier=backend,team=artemidis --annotations 'deployer=tyfr'
kubectl get pods --show-labels
kubectl get pods  -l 'team in (artemidis,aircontrol), tier==backend'

# adding labels to an existing pod
kubectl run pod-1 --image=nginx:1.25.1
kubectl label pods pod-1 tier=frontend
kubectl label pods pod-1 team=artemidis
kubectl annotate pods pod-1 deployer=tyfr