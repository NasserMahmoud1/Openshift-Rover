#!/bin/bash

# Collect all namespaces
for namespace in $(oc get namespaces -o jsonpath='{.items[*].metadata.name}'); do
    echo "My namespace is $namespace"

    # Collect the full build config name per namespace
    full_build_config_name=$(oc get bc -n $namespace -o name)

    # Iterate through each build config in the namespace
    for bc in $full_build_config_name; do
        # Collect base image type per build config
        base_image=$(oc get $bc -n $namespace -o jsonpath='{.spec.strategy.*.from.name}')

        # Collect only build config name
        build_config_name=$(echo $bc | awk -F'/' '{print $2}')

        # Collect the source URL per build config
        source_code_url=$(oc get bc $build_config_name -n $namespace -o jsonpath='{.spec.source.git.uri}')

        # Store and categorize the namespaces as per their type
        if [[ "$base_image" == *"nodejs"* ]]; then
            # Append to nodejs.yaml
            echo "- namespace:" >> nodejs.yaml
            echo "    name: $namespace" >> nodejs.yaml
            echo "    URL: $source_code_url" >> nodejs.yaml
        fi

        if [[ "$base_image" == *"java"* ]]; then
            # Append to java.yaml
            echo "- namespace:" >> java.yaml
            echo "    name: $namespace" >> java.yaml
            echo "    URL: $source_code_url" >> java.yaml
        fi
    done
done
