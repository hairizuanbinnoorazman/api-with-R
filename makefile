APP_NAME?="r-api"
TOPIC_NAME?="r-api"
SUB_NAME?="r-api"
SERVICE_URL=$$(gcloud beta run services describe r-api --region=asia-northeast1 --platform=managed | yq r - status.url)
DATA=$$(printf '{"test_value": "testing this api"}' | base64)

# The following commands are for handling when the application is to be paired with Google Pubsub
# Before running this command, ensure that PROJECT_ID environment variable is set
pubsub-prep:
	gcloud beta run services add-iam-policy-binding $(APP_NAME) \
   		--member=serviceAccount:cloud-run-pubsub-invoker@${PROJECT_ID}.iam.gserviceaccount.com \
		--region=asia-northeast1 \
   		--role=roles/run.invoker
	gcloud pubsub topics create $(TOPIC_NAME)
	gcloud beta pubsub subscriptions create $(SUB_NAME) --topic $(TOPIC_NAME) \
		--ack-deadline 300 \
		--push-endpoint=$(SERVICE_URL) \
		--push-auth-service-account=cloud-run-pubsub-invoker@${PROJECT_ID}.iam.gserviceaccount.com

sendmsg:
	gcloud pubsub topics publish $(TOPIC_NAME) --message '{"test_value": "testing this api"}'

sampledata:
	printf $(DATA)

local-http:
	curl localhost:9000 -X POST -H "Content-Type: application/json" -d '{"message": {"data": "'"${DATA}"'"}}'

build-docker:
	docker build -t gcr.io/${PROJECT_ID}/${APP_NAME}:0.0.3 .