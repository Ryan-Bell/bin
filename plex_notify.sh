#!/bin/sh
# Summary: This script is used by plexpy to relay plex notifications to a python listener
# Summary: plexpy is run in a docker container and this allows the info to be displayed on host

echo "Sending the following data to listener"
args="$@"
curl -d "$args" 172.17.0.1:2080
