export PROJECT_ID=our-places-prod

gcloud --quiet config set project $PROJECT_ID

./gradlew clean build
#mvn clean package

./gradlew endpointsOpenApiDocs
#mvn endpoints-framework:openApiDocs

gcloud --quiet endpoints services deploy target/openapi-docs/openapi.json

./gradlew appengineDeploy
#mvn appengine:deploy
