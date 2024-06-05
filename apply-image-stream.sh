#!/bin/bash

##### Update the image details in the deployment config of each namespace#####

    # Get a list of projects in OpenShift
    PROJECTS=$(oc get projects -o=jsonpath='{range .items[*]}{.metadata.name}{"\n"}{end}')
 
    # Loop through each project
    for PROJECT in $PROJECTS; do
        # Check if the deployment exists in the project
        oc get deployment $DEPLOYMENT -n $PROJECT &> /dev/null
        if [ $? -eq 0 ]; then
            # Set the image for the deployment
            oc set image deployment/$DEPLOYMENT_IMG -n $PROJECT $DEPLOYMENT=$IMAGE -n $PROJECT
            echo "Updated image for $DEPLOYMENT in project $PROJECT"
        else
            echo "Deployment $DEPLOYMENT not found in project $PROJECT"
        fi
    done