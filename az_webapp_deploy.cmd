@echo off

set IMAGE_NAME=openaichatapp:openaiflask
set CONTAINER_REGISTRY=screamingelfcontainers.azurecr.io
set RESOURCE_GROUP=screamingelfresources
set WEB_APP_NAME=openaichatapp
set APP_SERVICE_PLAN=screamingelfappserviceplan

echo Building Docker image...
docker build -t %IMAGE_NAME% %APP_DIRECTORY%

echo Logging into Azure Container Registry...
az acr login --name %CONTAINER_REGISTRY%

echo Tagging Docker image for Azure Container Registry...
docker tag %IMAGE_NAME% %CONTAINER_REGISTRY%/%IMAGE_NAME%

echo Pushing Docker image to Azure Container Registry...
docker push %CONTAINER_REGISTRY%/%IMAGE_NAME%

echo Updating Azure App Service with new Docker image...
az webapp config container set --name %WEB_APP_NAME% --resource-group %RESOURCE_GROUP% --docker-custom-image-name %CONTAINER_REGISTRY%/%IMAGE_NAME% --docker-registry-server-url https://%CONTAINER_REGISTRY%.azurecr.io --service-plan %APP_SERVICE_PLAN%

echo Deployment complete.
