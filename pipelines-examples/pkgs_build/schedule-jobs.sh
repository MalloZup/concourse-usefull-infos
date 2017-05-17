#! /bin/bash

fly -t lite login -c http://localhost:8080/

# schedule a paused pipeline
fly -t lite set-pipeline -p pkg -c pipegen.yml
