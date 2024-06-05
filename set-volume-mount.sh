#!/bin/bash
 
##### Volume will be set according to namespace #####

# Loop through all namespaces
for namespace in $(oc get namespaces | awk '{print $1}')
do
    # Loop through all deployments in the namespace
        echo "---- Namespace is $namespace ---------"
    for deployment in $(oc get deployments -n $namespace -o jsonpath='{.items[*].metadata.name}')
    do
  oc set volume deployment/$deployment -n $namespace --add --name='application-ocp' --type=secret --secret-name='application-ocp' --mount-path='Set the path to your mount'
 
    done
done