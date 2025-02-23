FROM maven:3.9.2-eclipse-temurin-17-focal AS build
#FROM maven:3.9.2-openjdk-17-slim AS build

WORKDIR /app

COPY . /app

ARG PATCH_VERSION

RUN mvn clean package -f pom.xml -Dversion=$PATCH_VERSION

RUN ls target

FROM openjdk:17.0.2-jdk-slim-buster AS run

WORKDIR /target

ARG PATCH_VERSION

COPY --from=build /app/target/my-app-1.0.${PATCH_VERSION}.jar /

RUN echo $PATCH_VERSION

#ENTRYPOINT ["/bin/sh", "-c", "java -jar /target/my-app-1.0.*.jar"]
CMD ["sh", "-c", "java -jar /my-app-1.0.${PATCH_VERSION}.jar"]
#java -jar /target/my-app
