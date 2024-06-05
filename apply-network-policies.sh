#!/bin/bash

##### Apply the network policy #####

# Loop through all namespaces
for namespace in $(oc get namespaces | awk '{print $1}')
do
    # Loop through all deployments in the namespace
 echo "---- Namespace is $namespace ---------" 
 oc apply -f "$namespace.yaml"
done