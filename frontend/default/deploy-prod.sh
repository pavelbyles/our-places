export PROJECT_ID=our-places-prod

gcloud --quiet components update
gcloud --quiet config set project $PROJECT_ID

gcloud --quiet app deploy
