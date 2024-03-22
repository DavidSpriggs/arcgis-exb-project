#!/bin/bash

echo "Enter the app number you want to export:"
read appnum

echo "Enter the clientID you want to use in the app (leave blank for none):"
read clientId

echo "Enter the filename to save as (leave off .zip):"
read filename

docker exec -e NODE_ENV=production arcgis-exb node -e "require('./server/src/middlewares/dev/apps/app-download.js').zipApp('$appnum', 'app.zip', '$clientId')"
docker cp arcgis-exb:/home/node/ArcGISExperienceBuilder/app.zip ./$filename.zip
docker exec arcgis-exb rm -f app.zip
