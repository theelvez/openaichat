@echo off

set IMAGE_NAME=openaichatapp:openaiflask
set CONTAINER_REGISTRY=screamingelfcontainers.azurecr.io
set RESOURCE_GROUP=screamingelfresources
set WEB_APP_NAME=openaichatapp
set APP_SERVICE_PLAN=screamingelfappserviceplan

echo Logging in to Azure Container Registry...
az acr login --name %CONTAINER_REGISTRY%

echo Tagging image...
docker tag %IMAGE_NAME% %CONTAINER_REGISTRY%/%IMAGE_NAME%

echo Pushing image to Azure Container Registry...
docker push %CONTAINER_REGISTRY%/%IMAGE_NAME%

echo Creating web app in Azure...
az webapp create --resource-group %RESOURCE_GROUP% --plan %APP_SERVICE_PLAN% --name %WEB_APP_NAME% --deployment-container-image-name %CONTAINER_REGISTRY%/%IMAGE_NAME%

echo Deployment complete!
pause
