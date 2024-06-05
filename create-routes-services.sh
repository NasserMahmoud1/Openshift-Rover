#!/bin/bash

# Get namespaces, skipping the header line
for namespace in $(oc get namespaces -o jsonpath='{.items[*].metadata.name}')
do
    # Get the service names in the namespace
    for serviceName in $(oc get svc -n $namespace -o jsonpath='{range .items[*]}{.metadata.name}{"\n"}{end}')
    do
        echo "Exposing $serviceName from namespace $namespace"
        
        # Set the hostname variable with the correct syntax
        hostname="${namespace}.my-cluster.com"
        
        # Expose the service with the specified hostname
        oc expose service/$serviceName -n $namespace --hostname=$hostname --name=${serviceName}-ms-dev
        
        # Create an edge route for the service
        oc create route edge --service=$serviceName -n $namespace --hostname=$hostname ${serviceName}-ms-dev
    done
done