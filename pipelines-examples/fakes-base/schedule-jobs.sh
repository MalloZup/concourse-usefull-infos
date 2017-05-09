#! /bin/bash

# this will save target
if [ -z "$1" ]; then
  echo "give a server were to post the jobs/pipelines"
  exit 1
fi
fly -t lite login -c http://$1:8080/

# schedule a paused pipeline
fly -t lite set-pipeline -p hello-world -c hello.yml 
fly -t lite set-pipeline -p hello-world2 -c hello2.yml 
fly -t lite set-pipeline -p hello-world-time -c time-pipe.yml
fly -t lite set-pipeline -p pipe -c fakepipeline.yml
#fly -t lite unpause-pipeline -p hello-world
#fly -t lite unpause-pipeline -p hello-world-time
