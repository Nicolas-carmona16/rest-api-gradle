FROM gradle:7.0-jdk17 AS build

WORKDIR /app
COPY . .

RUN gradle bootJar --no-daemon

FROM openjdk:17-jdk-slim
EXPOSE 8080
COPY --from=build /app/build/libs/RestAPI-0.0.1-SNAPSHOT.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]
