# Create a CustomResourceDefinition manifest file for an Operator with the following specifications :
# Name : operators.stable.example.com
# Group : stable.example.com
# Schema: <email: string><name: string><age: integer>
# Scope: Namespaced
# Names: <plural: operators><singular: operator><shortNames: op>
# Kind: Operator
# task1.yaml

# Create the CRD resource in the K8S API
kubectl apply -f task1.yaml

# Create custom object from the CRD
# Name : operator-sample
# Kind: Operator
# Spec:
# email: operator-sample@stable.example.com
# name: operator sample
# age: 30
# task2.yaml

# Listing operator
kubectl get operators