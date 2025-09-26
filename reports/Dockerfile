
FROM gradle:8.9-jdk17 AS build
WORKDIR /app
COPY . .
RUN gradle --no-daemon :app-service:bootJar -x test -x validateStructure

FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/applications/app-service/build/libs/*.jar /app/app.jar
EXPOSE 8082
ENTRYPOINT ["java","-jar","/app/app.jar"]

