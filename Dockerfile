# Usa un'immagine con Maven per costruire l'app
FROM maven:3.8.6-openjdk-17 AS build

WORKDIR /app

# Copia i file del progetto
COPY pom.xml .
COPY src/ ./src/

# Compila il progetto con Maven (senza dipendere dalla tua macchina)
RUN mvn clean package

# Secondo stage: usa solo il JAR
FROM openjdk:17-jdk-slim

EXPOSE 8080

# Copia il JAR generato nello stage precedente
COPY --from=build /app/target/app-1.0-SNAPSHOT.jar /app/app.jar

# Comando per eseguire l'applicazione
CMD ["java", "-jar", "/app/app.jar"]