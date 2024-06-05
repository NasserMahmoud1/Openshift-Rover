#!/bin/bash

##### Collect environment variables which are a pair of key and vaule, then you can set them in the new cluster #####

for namespace in $(oc get namespaces | awk '{print $1}')

do
 
Deployment=$(oc get dc -n $namespace -o jsonpath='{.items[*].metadata.name}' | awk '{print $1}')
 
# Source variables for the specified deployment configuration

source_vars=$(oc -n $namespace get dc $Deployment -o jsonpath='{range .spec.template.spec.containers[0].env[*]}{.name}{"="}{.value}{"\n"}{end}')
 
# Process each environment variable

while IFS=$'\t' read -r name_and_value; do

    # Print the extracted environment variable

    echo "$name_and_value" >> "$namespace.yaml"

    # Uncomment the line below to apply the environment variable

    #oc -n your-destination-project set env deploymentconfig/your-deploymentconfig "$name_and_value"

done <<< "$source_vars"
 
done