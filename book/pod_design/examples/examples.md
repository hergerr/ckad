1. kubectl create job counter --image=nginx -- /bin/sh -c 'counter=0; while [ $counter -lt 3 ]; do counter=$((counter+1)); echo $counter; sleep 3; done;'
2. kubectl create cronjob current-data --schedule="* * * * *" --image=nginx -- /bin/sh -c 'echo "Current date: $(date)"'
