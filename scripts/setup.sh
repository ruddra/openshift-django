#!/bin/sh

echo "--------- starting setup ---------"

echo "login as developer"
oc login -u developer -p 123

echo "creating projects cicd, dev and stage"

oc new-project dev   --display-name="Dev"
oc new-project stage --display-name="Stage"
oc  new-project cicd --display-name="CI/CD"

echo "adding permission for jenkins to manipulate dev and stage"
oc policy add-role-to-user edit system:serviceaccount:cicd:jenkins -n dev
oc policy add-role-to-user edit system:serviceaccount:cicd:jenkins -n stage

echo "using project cicd"
oc project cicd

echo "loading pipeline into cicd project"
oc new-app -f https://raw.githubusercontent.com/ruddra/openshift-django/master/.openshift/pipelines/openshift-pipeline.yaml

echo "now go to console>cicd>builds>pipelines and click on start pipeline"

echo "--------- ending setup ---------"