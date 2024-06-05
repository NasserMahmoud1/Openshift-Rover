#!/bin/bash

#### Disable the cron jobs ####

oc get cronjob -n mscronjob-uat -o name | xargs -l oc patch -n mscronjob-uat -p '{"spec": {"concurrencyPolicy": "Forbid"}}'
oc get cronjob -n mscronjob-uat -o name | xargs -l oc patch -n mscronjob-uat -p '{"spec": {"suspend": true}}'

#### Enable the cron jobs ####

oc get cronjob -n mscronjob-uat -o name | xargs -l oc patch -n mscronjob-uat -p '{"spec": {"concurrencyPolicy": "Replace"}}'
oc get cronjob -n mscronjob-uat -o name | xargs -l oc patch -n mscronjob-uat -p '{"spec": {"suspend": false}}'