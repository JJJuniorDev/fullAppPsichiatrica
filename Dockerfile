# Usa un'immagine leggera di OpenJDK
FROM openjdk:17-jdk-slim

# Imposta la directory di lavoro all'interno del container
WORKDIR /app

# Copia il JAR generato dalla tua applicazione
COPY target/app-1.0-SNAPSHOT.jar /app/app.jar

# Definisce il comando per avviare l'applicazione
CMD ["java", "-jar", "/app/app.jar"]
