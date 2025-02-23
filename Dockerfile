FROM maven:3.9.2-eclipse-temurin-17-focal AS build
#FROM maven:3.9.2-openjdk-17-slim AS build

WORKDIR /app

COPY . /app

RUN mvn clean package -f pom.xml

FROM openjdk:17.0.2-jdk-slim-buster AS run

WORKDIR /target

ARG PATCH_VERSION=$GITHUB_RUN_NUMBER

COPY --from=build /app/target /target

RUN echo $PATCH_VERSION

ENTRYPOINT ["java", "-jar", "/target/my-app-1.0.$PATCH_VERSION.jar"]
#java -jar /target/my-app
