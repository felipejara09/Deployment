FROM gradle:8.9-jdk17 AS build
WORKDIR /app
COPY . .

# 👇 usa el nombre del proyecto Gradle correcto
RUN gradle --no-daemon :app-service:bootJar -x test -x validateStructure

FROM eclipse-temurin:17-jre
WORKDIR /app
# 👇 copia desde la carpeta física del módulo
COPY --from=build /app/applications/app-service/build/libs/*.jar /app/app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app/app.jar"]
