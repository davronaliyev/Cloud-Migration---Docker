

#   Login:  docker login useast.jfrog.lexisnexisrisk.com
#   Build:  docker image build -t myapp:1.0 .
#   Tag:    docker tag myapp:1.0 useast.jfrog.lexisnexisrisk.com/asd-docker-dev-local/myapp:1.0
#   Push:   docker push useast.jfrog.lexisnexisrisk.com/asd-docker-dev-local/myapp:1.0
#   Pull:   docker pull useast.jfrog.lexisnexisrisk.com/asd-docker-dev-local/myapp:1.0
#   Run:    docker run -d -p 80:80 useast.jfrog.lexisnexisrisk.com/asd-docker-dev-local/myapp:1.0

#   docker pull rsgsdet/java-app:0.0.1
#   docker tag rsgsdet/java-app:0.0.1 useast.jfrog.lexisnexisrisk.com/asd-docker-dev-local/java-app
#   docker push useast.jfrog.lexisnexisrisk.com/asd-docker-dev-local/java-app
#   docker run -d -p 5000:5000 useast.jfrog.lexisnexisrisk.com/asd-docker-dev-local/java-app

FROM python:alpine AS base
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt

# Run tests to validate app
FROM node:12-alpine AS app-base
RUN apk add --no-cache python g++ make
WORKDIR /app
COPY app/package.json app/yarn.lock ./
RUN yarn install
COPY app/spec ./spec
COPY app/src ./src
RUN yarn test

# Clear out the node_modules and create the zip
FROM app-base AS app-zip-creator
RUN rm -rf node_modules && \
    apk add zip && \
    zip -r /app.zip /app

# Dev-ready container - actual files will be mounted in
FROM base AS dev
CMD ["mkdocs", "serve", "-a", "0.0.0.0:8000"]

# Do the actual build of the mkdocs site
FROM base AS build
COPY . .
RUN mkdocs build

# Extract the static content from the build
# and use a nginx image to serve the content
FROM nginx:alpine
COPY --from=app-zip-creator /app.zip /usr/share/nginx/html/assets/app.zip
COPY --from=build /app/site /usr/share/nginx/html
