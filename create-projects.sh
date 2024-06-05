#!/bin/bash

template_yaml_file="path_to_your_template.yaml"

# Read nodejs.yaml and create projects
while IFS= read -r line; do
    # Extract namespace name
    if [[ "$line" =~ ^\s*name:\ (.*)$ ]]; then
        name="${BASH_REMATCH[1]}"
    fi

    # Extract URL
    if [[ "$line" =~ ^\s*URL:\ (.*)$ ]]; then
        URL="${BASH_REMATCH[1]}"

        # Create project with the extracted name
        oc new-project "$name" --display-name="$name" --description="Project for $name with source code at $URL"

        # Process the template YAML file and create resources in the specified namespace
        oc process -f $template_yaml_file \
        -p APPLICATION_NAME=$name \
        -p PORT="Set your default port" \
        -p SOURCE_REPOSITORY_URL=$URL \
        -p ENV="Specify the environment" \
        -p HOSTNAME_HTTPS="Specify your custom hostname" | oc create -f - -n $name

        # Set image for the deployment
        oc set image-lookup deploy/$name
    fi

done < nodejs.yaml
