#!/bin/bash

echo "Enter the ExB version you are using in the docker-compose:"
read version

echo "Starting container: dspriggs/arcgis-exb:$version"
docker run --name arcgis-exb-copy -d dspriggs/arcgis-exb:$version

echo "Copying ExB client from container to local client..."
docker cp arcgis-exb-copy:/home/node/ArcGISExperienceBuilder/client ./

echo "Stopping container..."
docker stop arcgis-exb-copy
docker rm arcgis-exb-copy
