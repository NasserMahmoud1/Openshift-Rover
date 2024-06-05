#!/bin/bash

##### Collect image details in the deployment config #####
 
# Loop through all namespaces
for namespace in $(oc get namespaces | awk '{print $1}')
do
    # Loop through all deployments in the namespace
    echo "---- Namespace is $namespace ---------"
    for deployment in $(oc get dc -n $namespace -o jsonpath='{.items[*].metadata.name}')
    do
        # Get the images and append each to the images.txt file
        for image in $(oc get dc $deployment -n $namespace -o jsonpath='{.spec.template.spec.containers[*].image}')
        do
            echo "$image" >> images.txt
        done
    done
done