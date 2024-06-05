#!/bin/bash
 
# Loop through all namespaces
for namespace in $(oc get namespaces | awk '{print $1}')
do
    # Loop through all deployments in the namespace
 echo "---- Namespace is $namespace ---------" 
    for deployment in $(oc get deployments -n $namespace -o jsonpath='{.items[*].metadata.name}')
    do
        # Loop through all containers in the deployment
  echo "---- Deployment is $deployment ---------" 
        for container in $(oc get deployment $deployment -n $namespace -o jsonpath='{.spec.template.spec.containers[*].name}')
        do
   echo "---- Container is $container ---------" 
            # Set resources for each container
            oc set resources deployment/$deployment -n $namespace --containers=$container --requests=memory='Set the value according to the usage E.g. 500Mi',cpu='Set the value according to the usage E.g. 200m'
   echo "---- Set Resources for $deployment in $namespace ---------" 
        done
    done
done