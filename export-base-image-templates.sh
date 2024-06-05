#!/bin/bash

# Namespace to export templates from
namespace="my-namespace"

# Directory to save exported templates
output_dir="./templates"

# Create output directory if it doesn't exist
mkdir -p $output_dir

# Get all template names in the namespace
templates=$(oc get templates -n $namespace -o jsonpath='{.items[*].metadata.name}')

# Loop through each template and export it
for template in $templates; do
    echo "Exporting template: $template"
    oc get template $template -n $namespace -o yaml > $output_dir/$template.yaml
done

echo "All templates have been exported to $output_dir"