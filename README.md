# api-with-R

Writing an API with R

# Deployment

Create a docker image to be pushed to a Google Container Registry of a project.

```bash
docker build -t gcr.io/<PROJECT ID>/r-api:0.0.1 .
docker push gcr.io/<PROJECT ID>/r-api:0.0.1
```

Things to take note:

- Application requires to be exposed to port 8080 (Google Cloud Run)
- R applications are single threaded and hence, can only accept a concurrency of 1
