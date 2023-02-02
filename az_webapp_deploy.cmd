REM Login to Azure using the Azure CLI
az login

REM Push Docker image to Azure Container Registry
docker login screamingelfcontainers.azurecr.io -u screamingelfcontainers -p Zphars/tdIiu5iVLNqdYfdIBgvYsM226SuUnZOGQYE+ACRBO+rzP
docker tag openaichat screamingelfcontainers.azurecr.io/openaichat:v1
docker push screamingelfcontainers.azurecr.io/openaichat:v1

REM Update Azure App Service Web App with the new Docker image
az webapp config container set --name openaichatapp --resource-group screamingelfresources --docker-custom-image-name screamingelfcontainers.azurecr.io/openaichat:v1
az webapp config appsettings set --name openaichatapp --resource-group screamingelfresources --settings WEBSITES_PORT=80

REM Restart the Azure App Service Web App
az webapp restart --name openaichatapp --resource-group screamingelfresources
