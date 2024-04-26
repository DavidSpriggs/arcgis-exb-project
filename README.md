# arcgis-exb Project Template
ArcGIS Experience Builder development made simple with Docker.

# Background
This template is designed to become the top level structure to any new ArcGIS Experience builder project. It allows you to develop widgets, themes, and apps, without having to install Experience builder locally. This simplifies development and allows teams to work together without issues and only commit to source control the assets being built.

# Setup
You need to have docker or docker desktop installed to use this tooling. On windows, I recommend using an Ubuntu WSL image with docker installed.

To start, clone the repo to a location where you will be doing development for your project (docker must be installed). Clone the repo with your own project name. Replace `My-Project-Name` with your own project name:
```shell
git clone git@github.com:DavidSpriggs/arcgis-exb-project.git My-Project-Name
```
Next, `cd` into your project folder and delete the hidden `.git` directory.
```shell
rm -rf .git
```
This will delete the git history and unlink the repo from its original parent.

Next, initialize the folder as a new git repo for you to develop in:
```shell
git init
```

The docker compose file is defaulted to use the current version of Experience Builder `1.14`. If you need an older version, edit line 4 to reflect the version you need. To see the available prebuilt versions, visit [docker hub](https://hub.docker.com/r/dspriggs/arcgis-exb/tags).

You are now ready to make commits and push them to your source control when ready.

## Copy the client
Before you can begin, you need to pull the ExB client from the container to your local disk. This will give you full typings on all ExB objects. 

Note which version of the ExB you are using in the docker compose file. The docker compose file is defaulted to use the current version of Experience Builder `1.14`. If you need an older version, edit line 4 to reflect the version you need. To see the available prebuilt versions, visit [docker hub](https://hub.docker.com/r/dspriggs/arcgis-exb/tags).

To pull the client from the container run:
```shell
sh ./get-exb-client.sh
```
This will ask you which version of ExB you are using, (look on line 4 of docker compose, currently `1.14`). After entering a value, it will start a temporary container, copy the client, then shutdown the container. 

You are now ready to start developing.

## Start-up and usage
Before launching Experience Builder, edit the `server/public/signin-info.json` file to point to your portal and app. You can create a new app here: https://developers.arcgis.com/applications/
```javascript
[
  {
    "portalUrl": "https://myportal.maps.arcgis.com",
    "clientId": "my_client_id",
    "supportsOAuth": true,
    "isWebTier": false
  }
]
```


To start using your new project, start up the docker compose file. 

In the same directory as the `docker-compose.yml` file run:
```shell
docker compose up -d
```
This will download the images and run them in your docker environment.

You can now add your custom themes and widgets the the `client/your-extensions/themes` and `client/your-extensions/widgets` folders for development. 

To start using the ArcGIS Experience builder, visit: https://localhost and sign in. Make sure to add `https://localhost` to your apps allowed redirect urls.

Note: adding new folders or files requires you to restart Experience Builder before it will see them. To restart Experience Builder, open portainer at https://localhost:9443 and restart the arcgis-exb container.

## Export an app
Exporting an app from the ExB UI will not embed your `clientID` in the app. To export an app that includes your `clientID`, use the `export-exb-app.sh` script. Follow the prompts.
```shell
sh ./export-exb-app.sh
```
# Upgrade ExB version
To upgrade or change version of ExB you are using in your project do the following:
1. Commit and push the project so that everything is saved/backed up.
2. Delete everything in the `client` folder EXCEPT the `your-extensions` folder. This folder contains your custom widgets/themes and is the only folder that is tracked in git.
3. Open the `docker-compose.yml` file and change the `arcgis-exb` image tag to the version you want. `1.14` for example.
4. Run the `get-exb-client.sh` script and enter the ExB version you want to copy into your client folder. `1.14` for example.
5. Run the `docker compose up -d` command. You are now on a new version of ExB.

# Portainer
Portainer allows you to manage the containers in the docker compose configuration. To open portainer, visit: https://localhost:9443 you will need to create a user and password the first time. With portainer you can easily restart the arcgis-exb container and view its logs.