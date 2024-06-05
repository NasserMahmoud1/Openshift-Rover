#!/bin/bash

##### Exporting the files #####

# Loop through all namespaces
for namespace in $(oc get namespaces | awk '{print $1}')
do
    # Loop through all deployments in the namespace
 echo "---- Namespace is $namespace ---------" 
    oc get secret/application-ocp -n $namespace -o yaml > "$namespace.yaml"
 
done