#!/bin/bash
 
# Get a list of all namespaces
namespaces=$(oc get namespaces | awk '{print $1}')
 
# Loop through each namespace and apply the NetworkPolicy
for namespace in $namespaces
do
    # Define the NetworkPolicy YAML content with a unique name
    read -r -d '' NETWORK_POLICY <<EOF
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-ingress-from-$namespace
spec:
  podSelector: {}
  ingress:
  - from:
    - namespaceSelector:
        matchLabels:
          network.openshift.io/policy-group: ingress
EOF
 
    echo "Applying NetworkPolicy to namespace: $namespace"
    echo "$NETWORK_POLICY" | oc apply -f - -n "$namespace"
done