#!/bin/bash

containerId=$(docker ps -qf "name=arcgis-exb")

if [ ! "$containerId" = "" ]; then
    mkdir -p ./exb/widgets/node_modules/@types
    docker cp $containerId:/home/node/ArcGISExperienceBuilder/client/jimu-arcgis ./exb/widgets/node_modules/@types
    docker cp $containerId:/home/node/ArcGISExperienceBuilder/client/jimu-core ./exb/widgets/node_modules/@types
    docker cp $containerId:/home/node/ArcGISExperienceBuilder/client/jimu-for-builder ./exb/widgets/node_modules/@types
    docker cp $containerId:/home/node/ArcGISExperienceBuilder/client/jimu-for-test ./exb/widgets/node_modules/@types
    docker cp $containerId:/home/node/ArcGISExperienceBuilder/client/jimu-icons ./exb/widgets/node_modules/@types
    docker cp $containerId:/home/node/ArcGISExperienceBuilder/client/jimu-layouts ./exb/widgets/node_modules/@types
    docker cp $containerId:/home/node/ArcGISExperienceBuilder/client/jimu-theme ./exb/widgets/node_modules/@types
    docker cp $containerId:/home/node/ArcGISExperienceBuilder/client/jimu-ui ./exb/widgets/node_modules/@types
else
    echo "Container not found. Make sure your arcgis-exb is running with 'docker compose up -d'"
fi
