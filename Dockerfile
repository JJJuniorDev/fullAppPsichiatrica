# Stage 1: Costruzione del JAR
FROM openjdk:17-jdk-slim AS build

WORKDIR /app

# Installa Maven e copia il codice sorgente
RUN apt-get update && apt-get install -y maven
COPY . .

# Compila il progetto
RUN mvn clean package

# Stage 2: Esegui solo il JAR
FROM openjdk:17-jdk-slim

WORKDIR /app

# Copia solo il JAR dal primo stage
COPY --from=build /app/target/app-1.0-SNAPSHOT.jar app.jar

EXPOSE 8080

# Esegui l'applicazione
CMD ["java", "-jar", "app.jar"]
