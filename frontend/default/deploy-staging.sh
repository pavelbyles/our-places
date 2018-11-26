export PROJECT_ID=our-places-staging

gcloud --quiet components update
gcloud --quiet config set project $PROJECT_ID

gcloud --quiet app deploy
