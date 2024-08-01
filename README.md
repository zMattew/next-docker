# next-docker: Nextjs repo clone, build and run 
Multi stage docker file for cloning your next app (private repo), build the image and deploy it with compose 
Run your nextjs app every where handling the whole process needed to have an optimized production application every where.
## Clone
Clone your private repository specifying its name and using your user account name and a generated token from [here](https://github.com/settings/apps)

## Build
Build the production optimzed version of your nextjs app  using the .env file  in the same folder of the Dockerfile
- Docker build :
````
docker build next-app ./ --build-args GIT_TOKEN=token --build-args GIT_USER=user --build-args REPO=repo-name
````
clone new version from git using --no-cache flag
````
docker build next-app ./ --no-cache --build-args GIT_TOKEN=token --build-args GIT_USER=user --build-args REPO=repo-name 
````
- Docker compose:
you need to write the requried arguments as showed in the docker-compose file
````
docker compose build
docker compose up 
````
make sure to build the new image for getting the new version from git repo
````
docker compose build --no-cache
docker compose up --build //use cached image
````

## Run
Once you've ready the new image builded you can use your own configuration to run the next app with docker compose.
If you just are using this file you can run all the step needed with just one command  
````
docker compose up
````
you can add the needed services in the docker compose file and run with it or use Kubernets to orchestrate the next app with other component 
This imply more configurations from yourself.
