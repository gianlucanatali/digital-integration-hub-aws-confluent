#!/bin/bash

echo "--- Starting up containers---"
sudo docker-compose -f /demo/docker-compose.yml --env-file /tmp/environment-variable.env up -d

echo "--- Wait 120 seconds for containers to start up---"
tot=120
for i in {1..120}; do
    sleep 1
    countdown="$(($tot - $i))"
    printf "\r $countdown"

done

echo "--- Start up containers complete---"