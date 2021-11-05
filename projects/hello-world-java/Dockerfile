# Build a JAR File
FROM maven:3.6.3-jdk-8-slim AS stage1
WORKDIR /home/app
COPY . /home/app/
RUN mvn -f /home/app/pom.xml clean package

# Create an Image
FROM openjdk:8-jdk-alpine
EXPOSE 5000
COPY --from=stage1 /home/app/target/hello-world-java.jar hello-world-java.jar
ENTRYPOINT ["sh", "-c", "java -jar /hello-world-java.jar"]


#   docker build -t hello-world-java:1.0 .

#   Login:  docker login useast.jfrog.lexisnexisrisk.com
#   Build:  docker image build -t hello-world-java:1.0 .
#   Tag:    docker tag hello-world-java:1.0 useast.jfrog.lexisnexisrisk.com/asd-docker-dev-local/hello-world-java:1.0
#   Push:   docker push useast.jfrog.lexisnexisrisk.com/asd-docker-dev-local/hello-world-java:1.0