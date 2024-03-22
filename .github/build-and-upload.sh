#!/bin/bash

echo "Buidling and pushing rmmarquini/routeasy-graphhopper-docker:latest"
./build.sh --push

TAG=`cd graphhopper; git for-each-ref --sort=committerdate refs/tags | sed -n '$s/.*\///p'`
if docker manifest inspect "rmmarquini/routeasy-graphhopper-docker:${TAG}" >/dev/null; then 
    echo "No need to push existing version: ${TAG}";
else
    echo "Buidling and pushing rmmarquini/routeasy-graphhopper-docker:${TAG}"
    ./build.sh --push "${TAG}"
fi