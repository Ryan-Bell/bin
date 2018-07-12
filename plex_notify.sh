#!/bin/bash
echo "Sending the following data to listener"
args="$@"
curl -d "$args" 172.17.0.1:2080
