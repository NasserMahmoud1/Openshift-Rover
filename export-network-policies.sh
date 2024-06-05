#!/bin/bash

##### Collect the network policies against each namespace and store it in a yaml file ##### 

# Loop through all namespaces
for namespace in $(oc get namespaces | awk '{print $1}')
do
    # Loop through all deployments in the namespace
 echo "---- Namespace is $namespace ---------" 
 oc get NetworkPolicy -n $namespace -o yaml > "$namespace.yaml"
 
#Some key names got changed in OCP 3.11, the apiVersion become networking.k8s.io/v1 , and the ingress namespace match label become kubernetes.io/metadata.name
 sed -i 's@apiVersion: extensions/v1beta1@networking.k8s.io/v1@g' $namespace.yaml
 sed -i 's@          name:@              kubernetes.io/metadata.name:@g' $namespace.yaml

done