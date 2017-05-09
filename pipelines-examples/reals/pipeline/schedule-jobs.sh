#! /bin/bash

fly -t lite login -c http://janacek.arch.suse.de:8080/

# schedule a paused pipeline
fly -t lite set-pipeline -p cucumber -c gitpipe.yml
fly -t lite unpause-pipeline -p cucumber
#fly -t lite unpause-pipeline -p hello-world-time
