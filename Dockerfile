# Usa OpenJDK 17
FROM openjdk:17-jdk-slim

# Installa Maven
RUN apt-get update && apt-get install -y maven

WORKDIR /app

# Copia il codice sorgente
COPY . .

# Compila il progetto con Maven (senza dipendere dalla tua macchina)
RUN mvn clean package

# Secondo stage: usa solo il JAR
FROM openjdk:17-jdk-slim

EXPOSE 8080

# Comando per eseguire l'applicazione
CMD ["java", "-jar", "/app/app.jar", "/app/target/app-1.0-SNAPSHOT.jar"]