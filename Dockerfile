FROM maven:3.9.2-eclipse-temurin-17-focal AS build

WORKDIR /app

COPY . /app

ARG PATCH_VERSION

RUN mvn clean package -f pom.xml -Dversion=$PATCH_VERSION

FROM openjdk:17.0.2-jdk-slim-buster AS run

WORKDIR /target

ARG PATCH_VERSION

ENV PAT_VER=$PATCH_VERSION

COPY --from=build /app/target/my-app-1.0.${PATCH_VERSION}.jar /

CMD ["sh", "-c", "java -jar /my-app-1.0.${PAT_VER}.jar"]
