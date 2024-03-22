# Graphhopper docker provider repository
This repository holds the very basic things in order to make sure there's an updated graphhopper docker image which we use in our production server.
Images can be found here:
https://hub.docker.com/r/rmmarquini/routeasy-graphhopper-docker

I would like to first and foremost thank the [graphhopper](https://www.graphhopper.com/) team for their hard work and amazing product!
They are doing a great job and we are truly happy to help by contributing to thier code base like we had done in the past.
Graphhopper team has decided not to build a docker image and this repository is here to bridge that gap.
This repository is extremely simple, all it does is the following:
1. Every night at 1 AM it builds the latest code using Github actions from the [graphhopper repository](https://github.com/graphhopper/graphhopper) and uploads the image to docker hub with the `latest` tag
2. It checks if there's a new version tag, and if so builds it and upload it as well with the relevant tag
3. Adds a graphhopper.sh file for ease of use

That's all.

Feel free to submit issues or pull requests if you would like to improve the code here

This docker image uses the following default environment setting:
```
JAVA_OPTS: "-Xmx2g -Xms2g"
```

For a quick startup you can run the following command to create the Brazil routing:
```
docker run -itd -v graphhopper --name graphhopper -p 8989:8989 ${DOCKER_HUB_ID}/routeasy-graphhopper-docker:${TAG} --url https://download.geofabrik.de/south-america/brazil-latest.osm.pbf --host 0.0.0.0
```
Then surf to `http://localhost:8989/`

You can also completely override the entry point and use this for example:
```
docker run --entrypoint /bin/bash rmmarquini/routeasy-graphhopper-docker -c "wget https://download.geofabrik.de/south-america/brazil-latest.osm.pbf -O /data/brazil-latest.osm.pbf && java -Ddw.graphhopper.datareader.file=/data/brazil-latest.osm.pbf -Ddw.graphhopper.graph.location=brazil-gh -jar *.jar server config-example.yml"
```

Checkout `graphhopper.sh` for more usage options such as import.

In order to build the docker image locally, please run [`.github/build.sh`](.github/build.sh).
