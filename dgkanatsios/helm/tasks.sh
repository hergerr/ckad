# Creating a basic Helm chart
helm create example

# Running a Helm chart
helm install <name> <chart>

# Find pending Helm deployments on all namespaces
helm list --all-namespaces

# Uninstall a Helm release
helm uninstall <name>

# Upgrading a Helm chart
helm upgrade <name> <chart>

# Using Helm repo
helm repo add <repo-name> <url>

# Download a Helm chart from a repository
helm pull <chart>

# Add the Bitnami repo at https://charts.bitnami.com/bitnami to Helm
helm repo add bitnami https://charts.bitnami.com/bitnami

# Install the bitnami/node chart setting the number of replicas to 5
helm install my-node bitnami/node --set replicaCount=5