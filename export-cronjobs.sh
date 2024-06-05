#!/bin/bash

##### Exporting the Jobs #####

# Namespace to export CronJobs from
namespace="my-namespace"

# Directory to save exported CronJobs
output_dir="./cronjobs"

# Create output directory if it doesn't exist
mkdir -p $output_dir

# Get all CronJob names in the namespace
cronjobs=$(oc get cronjob -n $namespace -o jsonpath='{.items[*].metadata.name}')

# Loop through each CronJob and export it
for cronjob in $cronjobs; do
    echo "Exporting CronJob: $cronjob"
    oc get cronjob $cronjob -n $namespace -o yaml > $output_dir/$cronjob.yaml
done

echo "All CronJobs have been exported to $output_dir"