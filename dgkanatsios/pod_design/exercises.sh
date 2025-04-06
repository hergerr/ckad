# Create 3 pods with names nginx1,nginx2,nginx3. All of them should have the label app=v1
kubectl run nginx1 --image=nginx --restart=Never -l=app=v1
kubectl run nginx2 --image=nginx --restart=Never -l=app=v1
kubectl run nginx3 --image=nginx --restart=Never -l=app=v1

# Show all labels of the pods
kubectl describe pod nginx1 | grep Labels
kubectl describe pod nginx2 | grep Labels
kubectl describe pod nginx3 | grep Labels

# or
kubectl get po --show-labels

# Change the labels of pod 'nginx2' to be app=v2
kubectl label --overwrite pods nginx2 app=v2

# Get the label 'app' for the pods (show a column with APP labels)
kubectl get pods -L app

# Get only the 'app=v2' pods
kubectl get pods -l app=v2

# Add a new label tier=web to all pods having 'app=v2' or 'app=v1' labels
kubectl label pods -l 'app in (v1, v2)' tier=web

# Remove the 'app' label from the pods we created before
kubectl label pods -l 'app in (v1, v2)' app-

# or
kubectl label po nginx{1..3} app-

# Annotate pods nginx1, nginx2, nginx3 with "description='my description'" value
kubectl annotate pods nginx{1..3} description='my description'

# Check the annotations for pod nginx1
kubectl describe pod nginx1 | grep Anno
# or
kubectl annotate pod nginx1 --list

# Remove the annotations for these three pods
kubectl annotate pods nginx{1..3} description-

# Remove these pods to have a clean state in your cluster
kubectl delete pods nginx{1..3}

# https://dinushad92.medium.com/kubernetes-pod-placement-strategies-2612a5fa01f8

# Create a pod that will be deployed to a Node that has the label 'accelerator=nvidia-tesla-p100'
kubectl label node minikube accelerator=nvidia-tesla-p100
# see "task1.yaml"

# Taint a node with key tier and value frontend with the effect NoSchedule. Then, create a pod that tolerates this taint.
kubectl taint node minikube tier=frontend:NoSchedule
# see "task2.yaml"

# Create a pod that will be placed on node controlplane. Use nodeSelector and tolerations.
# TODO: why use tolerations?

# Create a deployment with image nginx:1.18.0, called nginx, having 2 replicas, defining port 80 as the port that this container exposes (don't create a service for this deployment)
kubectl create deployment nginx --image=nginx:1.18.0 --dry-run=client -o yaml | tee task3.yaml
# see task3.yaml

# View the YAML of this deployment
kubectl get pod nginx-67dfd6c8f9-lns82 -o yaml

# Check how the deployment rollout is going
kubectl rollout status deploy nginx

# Update the nginx image to nginx:1.19.8
# update deployment file
kubectl apply -f dgkanatsios/pod_design/task3.yaml
# or
kubectl set image deploy nginx nginx=nginx:1.18.0
# or
kubectl edit deploy nginx

# Check the rollout history and confirm that the replicas are OK
kubectl rollout status deploy nginx
kubectl get deploy nginx
kubectl get rs 
kubectl get po

# Undo the latest rollout and verify that new pods have the old image (nginx:1.18.0)
kubectl rollout history deployment nginx
kubectl describe deployment nginx
kubectl rollout undo deployment/nginx
kubectl describe deployment nginx

# Do an on purpose update of the deployment with a wrong image nginx:1.91
kubectl set image deploy nginx nginx=nginx:1.91

# Verify that something's wrong with the rollout
kubectl rollout status deploy nginx
# or
kubectl get po

# Return the deployment to the second revision (number 2) and verify the image is nginx:1.19.8
kubectl describe deployment nginx
kubectl rollout history deployment nginx
kubectl rollout undo deployment/nginx --to-revision=2
kubectl describe deployment nginx

# kubectl get po
kubectl rollout history deployment/nginx --revision=4

# Scale the deployment to 5 replicas
kubectl edit deploy nginx
# or
kubectl scale deploy nginx --replicas=5
kubectl describe deploy nginx

# Autoscale the deployment, pods between 5 and 10, targetting CPU utilization at 80%
kubectl autoscale deployment nginx --min=5 --max=10 --cpu-percent=80
kubectl get hpa nginx

# Pause the rollout of the deployment
kubectl rollout pause deployment/nginx

# Update the image to nginx:1.19.9 and check that there's nothing going on, since we paused the rollout
kubectl set image deploy nginx nginx=nginx:1.19.9
kubectl rollout history deploy nginx 

# Resume the rollout and check that the nginx:1.19.9 image has been applied
kubectl rollout resume deployment/nginx
kubectl rollout history deploy nginx 

# Delete the deployment and the horizontal pod autoscaler you created
kubectl delete deploy nginx --force
kubectl delete hpa nginx --force

# Implement canary deployment by running two instances of nginx marked as version=v1 and version=v2 so that the load is balanced at 75%-25% ratio
# see task4.yaml
# to test: kubectl run -it --rm --restart=Never busybox --image=gcr.io/google-containers/busybox -- /bin/sh -c 'while sleep 1; do wget -qO- my-app-svc; done'

# Create a job named pi with image perl:5.34 that runs the command with arguments "perl -Mbignum=bpi -wle 'print bpi(2000)'"
kubectl create job pi --image=perl:5.34 -- perl -Mbignum=bpi -wle 'print bpi(2000)'

# Wait till it's done, get the output
kubectl get po
kubectl logs pi-txcwv

# Create a job with the image busybox that executes the command 'echo hello;sleep 30;echo world'
kubectl create job busybox --image=busybox -- /bin/sh -c "echo hello;sleep 30;echo world"

# Follow the logs for the pod (you'll wait for 30 seconds)
kubect get pods
kubectl logs -f=true busybox-2p8dl

# See the status of the job, describe it and see the logs
kubectl get jobs
kubectl describe job busybox
kubectl logs job/busybox

# Delete the job
kubectl delete job busybox

# Create a job but ensure that it will be automatically terminated by kubernetes if it takes more than 30 seconds to execute
kubectl create job busybox --image=busybox  --dry-run=client -o=yaml -- /bin/sh -c "sleep 100"
# task5.yaml

# Create the same job, but make it run 5 parallel times
kubectl create job busybox --image=busybox  --dry-run=client -o=yaml -- /bin/sh -c "while :; echo lol; sleep 5"
# task6.yaml

# Create a cron job with image busybox that runs on a schedule of "*/1 * * * *" and writes 'date; echo Hello from the Kubernetes cluster' to standard output
kubectl create cronjob busybox --image=busybox --schedule='*/1 * * * *' -- /bin/sh -c 'date; echo Hello from the Kubernetes cluster'

# See its logs and delete it
kubectl get pods
kubectl logs busybox-28472904-jh8qz
kubectl delete cronjob busybox

# Create the same cron job again, and watch the status. Once it ran, check which job ran by the created cron job. Check the log, and delete the cron job
kubectl create cronjob busybox --image=busybox --schedule='*/1 * * * *' -- /bin/sh -c 'date; echo Hello from the Kubernetes cluster'
kubectl get cronjobs -w
kubectl get pods
kubectl logs busybox-28472911-v7tpd
kubectl delete cronjob busybox

# Create a cron job with image busybox that runs every minute and writes 'date; echo Hello from the Kubernetes cluster'
# to standard output. The cron job should be terminated if it takes more than 17 seconds to start 
# execution after its scheduled time (i.e. the job missed its scheduled time).
