# Usa OpenJDK 17
FROM openjdk:17-jdk-slim AS build

# Installa Maven
RUN apt-get update && apt-get install -y maven

WORKDIR /app

# Copia il parent POM in una directory separata
COPY ../pom.xml /app/parent-pom.xml 

# Copia tutto il codice sorgente della cartella app/
COPY . .

# Installa il parent POM prima di buildare l'app
RUN mvn -f /app/parent-pom.xml clean install 

# Compila l'app
RUN mvn clean package

# Secondo stage: usa solo il JAR
FROM openjdk:17-jdk-slim

EXPOSE 8080

# Copia il JAR generato dallo stage precedente
COPY --from=build /app/target/app-1.0-SNAPSHOT.jar /app/app.jar

# Comando per eseguire l'applicazione
CMD ["java", "-jar", "/app/app.jar"]
