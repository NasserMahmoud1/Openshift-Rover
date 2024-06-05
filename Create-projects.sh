#!/bin/bash

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
    fi
done < nodejs.yaml
