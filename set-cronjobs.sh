#!/bin/bash

##### Applying the Jobs #####

# Directory containing the CronJob YAML files
directory="./cronjobs"

# Apply each YAML file in the directory
for file in $directory/*.yaml; do
    echo "Applying CronJob from file: $file"
    oc apply -f $file
done

echo "All CronJobs have been applied from $directory"