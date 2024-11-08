FROM ubuntu:latest AS build
RUN apt-get update
RUN apt-get install openjdk-17-jdk -y
WORKDIR /app
COPY . .
RUN chmod +x gradlew
RUN ./gradlew bootJar --no-daemon
RUN ls -l /app/build/libs

FROM openjdk:17-jdk-slim
EXPOSE 8080
COPY --from=build /app/build/libs/RestAPI-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT ["java","-jar","app.jar"]