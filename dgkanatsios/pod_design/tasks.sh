# Create 3 pods with names nginx1,nginx2,nginx3. All of them should have the label app=v1
kubectl run nginx1 --image=nginx -l=app=v1
kubectl run nginx2 --image=nginx -l=app=v1
kubectl run nginx3 --image=nginx -l=app=v1

# Show all labels of the pods 
kubectl get pods --show-labels

# Change the labels of pod 'nginx2' to be app=v2
kubectl edit pod nginx2

# Get the label 'app' for the pods (show a column with APP labels)
kubectl get pods -L app

# Get only the 'app=v2' pods
kubectl get pods -l=app=v2

# Get 'app=v2' and not 'tier=frontend' pods
kubectl get pods -l 'app in (v2), tier notin (frontend)'

# Add a new label tier=web to all pods having 'app=v2' or 'app=v1' labels
kubectl label pods -l='app in (v1, v2)' tier=web

# Add an annotation 'owner: marketing' to all pods having 'app=v2' label
kubectl annotate pod -l=app=v1 owner=marketing

# Remove the 'app' label from the pods we created before
kubectl label pods -l=app app-

# Annotate pods nginx1, nginx2, nginx3 with "description='my description'" value
kubectl annotate pods nginx1 nginx2 nginx3 description='my description'

# Check the annotations for pod nginx1
kubectl describe pod nginx1

# Remove the annotations for these three pods
kubectl annotate pods nginx1 nginx2 nginx3 description-

# Remove these pods to have a clean state in your cluster
kubectl delete pod --force nginx{1..3}

# Create a pod that will be deployed to a Node that has the label 'accelerator=nvidia-tesla-p100'
# task1.yaml

# Taint a node with key tier and value frontend with the effect NoSchedule. Then, create a pod that tolerates this taint.
kubectl taint node node1 tier=frontend:NoSchedule
# task2.yaml

# Create a deployment with image nginx:1.18.0, called nginx, having 2 replicas, defining port 80 as the port that this container exposes (don't create a service for this deployment)
kubectl create deployment nginx --image=nginx:1.18.0 --replicas=2 --port=80

# View the YAML of this deployment
kubectl get deployment nginx -o=yaml

# View the YAML of the replica set that was created by this deployment
kubectl get rs nginx-5bfb4b8bd8 -o=yaml

# Get the YAML for one of the pods
kubectl get pod nginx-5bfb4b8bd8-7mkbg -o=yaml

# Check how the deployment rollout is going
kubectl rollout status deployment nginx

# Update the nginx image to nginx:1.19.8
kubectl set image deployment/nginx nginx=nginx:1.19.8

# Check the rollout history and confirm that the replicas are OK
kubectl rollout history deployment nginx
kubectl get deploy nginx
kubectl get rs 
kubectl get po

# Undo the latest rollout and verify that new pods have the old image (nginx:1.18.0)
kubectl rollout undo deployment/nginx
kubectl get deployment nginx -o yaml

# Do an on-purpose update of the deployment with a wrong image nginx:1.91
kubectl set image deployment/nginx nginx=nginx:1.91

# Verify that something's wrong with the rollout
kubectl get rs
kubectl describe rs nginx-7cbf998b8c
kubectl describe pods nginx-7cbf998b8c-5n2c8

# Return the deployment to the second revision (number 2) and verify the image is nginx:1.19.8
kubectl rollout undo deployment/nginx --to-revision=2
kubectl get deployment nginx -o yaml

# Check the details of the fourth revision (number 4)
kubectl rollout history deploy/nginx --revision=4

# Scale the deployment to 5 replicas
kubectl scale deployment/nginx --replicas=5

# Autoscale the deployment, pods between 5 and 10, targeting CPU utilization at 80%
kubectl autoscale deploy nginx --min=5 --max=10 --cpu-percent=80

# Pause the rollout of the deployment
kubectl rollout pause deploy/nginx
kubectl describe pod nginx-dff4889d9-6wnhh

# Resume the rollout and check that the nginx:1.19.9 image has been applied
kubectl rollout resume deploy/nginx
kubectl rollout history deploy nginx # new revision
kubectl describe pod nginx-7746668c6-xhclv | grep Image

# Delete the deployment and the horizontal pod autoscaler you created
kubectl delete hpa nginx --force

# Implement canary deployment by running two instances of nginx marked as version=v1 and version=v2 so that the load is balanced at 75%-25% ratio
# task3.yaml
# for testing
kubectl run -it --rm --restart=Never busybox --image=busybox -- /bin/sh -c 'while sleep 1; do wget -qO- nginx-service; done'

# Create a job named pi with image perl:5.34 that runs the command with arguments "perl -Mbignum=bpi -wle 'print bpi(2000)'"
kubectl create job perl-job --image=perl:5.34 -- perl -Mbignum=bpi -wle 'print bpi(2000)' 

# Wait till it's done, get the output
kubectl logs perl-job-mszpd

# Create a job with the image busybox that executes the command 'echo hello;sleep 30;echo world'
kubectl create job busybox-job --image=busybox -- '/bin/sh' '-c' 'echo hello;sleep 30;echo world'

# Follow the logs for the pod (you'll wait for 30 seconds)
kubectl logs -f busybox-job-6rsng

# See the status of the job, describe it and see the logs
kubectl get jobs
kubectl describe job busybox-job
kubectl logs job/busybox-job

# Delete the job
kubectl delete job busybox-job

# Create the same job, make it run 5 times, one after the other. Verify its status and delete it
# task4.yaml

# Create the same job, but make it run 5 parallel times
# task5.yaml

# Create a job but ensure that it will be automatically terminated by kubernetes if it takes more than 30 seconds to execute
# task6.yaml

# Create a cron job with image busybox that runs on a schedule of "*/1 * * * *" and writes 'date; echo Hello from the Kubernetes cluster' to standard output
kubectl create cronjob cj-busybox --image=busybox --schedule='*/1 * * * *' -- '/bin/sh' '-c' 'date; echo Hello from the Kubernetes cluster'

# See its logs and delete it
kubectl logs cj-busybox-29237249-tqhzb
kubectl delete cronjob cj-busybox

# Create the same cron job again, and watch the status. Once it ran, check which job ran by the created cron job. Check the log, and delete the cron job
kubectl get cj
kubectl get jobs --watch
kubectl get po --show-labels
kubectl delete cronjob cj-busybox

# Create a cron job with image busybox that runs every minute and writes 'date; echo Hello from the Kubernetes cluster' to standard output. The cron job should be terminated if it takes more than 17 seconds to start execution after its scheduled time (i.e. the job missed its scheduled time).
# task7.yaml

# Create a cron job with image busybox that runs every minute and writes 'date; echo Hello from the Kubernetes cluster' to standard output. The cron job should be terminated if it successfully starts but takes more than 12 seconds to complete execution.
# task8.yaml

# Create a job from cronjob.
kubectl create job --from=cronjob/cj-busybox example-job
