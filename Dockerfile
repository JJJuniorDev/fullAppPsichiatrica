# Usa OpenJDK 17
FROM openjdk:17-jdk-slim AS build

# Installa Maven
RUN apt-get update && apt-get install -y maven

WORKDIR /app

# Copia il codice sorgente
COPY . .

# Installa il parent POM prima di buildare l'app
RUN mvn -f backend-main/pom.xml clean install 

# Compila l'app
RUN mvn -f app/pom.xml clean package

# Secondo stage: usa solo il JAR
FROM openjdk:17-jdk-slim

EXPOSE 8080

# Copia il JAR generato dallo stage precedente
COPY --from=build /app/app/target/app-1.0-SNAPSHOT.jar /app/app.jar

# Comando per eseguire l'applicazione
CMD ["java", "-jar", "/app/app.jar"]
