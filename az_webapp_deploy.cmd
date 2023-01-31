@echo off 

set IMAGE_NAME=openaichatapp
set IMAGE_TAG=openaiflask
set CONTAINER_REGISTRY=screamingelfcontainers
set RESOURCE_GROUP=screamingelfresources
set WEB_APP_NAME=openaichatapp
set APP_SERVICE_PLAN=screamingelfappserviceplan
set APP_DIRECTORY=.

@echo on

echo Building Docker image...
docker build -t %IMAGE_NAME%:%IMAGE_TAG% %APP_DIRECTORY%

echo Logging into Azure Container Registry...
az acr login --name %CONTAINER_REGISTRY%

echo Tagging Docker image for Azure Container Registry...
docker tag %IMAGE_NAME% %CONTAINER_REGISTRY%:%IMAGE_NAME%

echo Pushing Docker image to Azure Container Registry...
docker push %CONTAINER_REGISTRY%:%IMAGE_NAME%

echo Updating Azure App Service with new Docker image...
az webapp config container set --name openaichatapp --resource-group screamingelfresources --docker-custom-image-name openaichatapp:openaiflask --docker-registry-server-url screamingelfcontainers.azurecr.io --docker-registry-server-user screamingelfcontainers --docker-registry-server-password Zphars/tdIiu5iVLNqdYfdIBgvYsM226SuUnZOGQYE+ACRBO+rzP

echo Deployment complete.
