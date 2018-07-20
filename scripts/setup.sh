#!/bin/sh

echo "--------- starting setup ---------"
echo "this installation has been tested in minishift only"
echo "please use 'docker pull openshift/jenkins-2-centos7' for faster deployment"
echo "please use 'docker pull openshift/mysql-55-centos7' for faster deployment"

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

echo "installing jenkins"
oc new-app openshift/jenkins-2-centos7
echo "exposing jenkins"
oc expose svc/jenkins-2-centos7

echo "installing mysql which will be available at IP: 172.30.0.30"
oc new-app -f "https://raw.githubusercontent.com/ruddra/openshift-django/master/.openshift/templates/mysql-build.yaml"

echo "loading pipeline into cicd project"
oc new-app -f "https://raw.githubusercontent.com/ruddra/openshift-django/master/.openshift/pipelines/openshift-pipeline.yaml"

echo "now go to console>cicd>builds>pipelines and click on start pipeline"

echo "--------- ending setup ---------"