#!/bin/bash
 
##### Apply the files #####

# Loop through all namespaces
for namespace in $(oc get namespaces | awk '{print $1}')
do
    # Construct the path to the YAML file for the namespace
    yaml_file="${namespace}.yaml"
 
    # Check if the YAML file exists
    if [ -f "$yaml_file" ]; then
        echo "---- Namespace is $namespace --------- + $yaml_file"
         oc apply -f "$yaml_file" -n $namespace
    else
        echo "Error: YAML file $yaml_file not found for namespace $namespace"
    fi
done