# Usa OpenJDK 17
FROM openjdk:17-jdk-slim AS build

# Installa Maven
RUN apt-get update && apt-get install -y maven

WORKDIR /app

# Copia tutta la cartella backend-main per preservare la struttura
COPY ../backend-main /app/backend-main

# Spostati nella cartella principale e installa il parent POM
WORKDIR /app/backend-main
RUN mvn clean install 

# Spostati nella cartella dell'app e compila
WORKDIR /app/backend-main/app
RUN mvn clean package

# Secondo stage: usa solo il JAR
FROM openjdk:17-jdk-slim

EXPOSE 8080

# Copia il JAR generato dallo stage precedente
COPY --from=build /app/backend-main/app/target/app-1.0-SNAPSHOT.jar /app/app.jar

# Comando per eseguire l'applicazione
CMD ["java", "-jar", "/app/app.jar"]
