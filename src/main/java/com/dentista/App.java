package com.dentista;

/**
 * Hello world!
 *
 */
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.mongodb.repository.config.EnableMongoRepositories;


@SpringBootApplication
@ComponentScan(basePackages = {
    "com.dentista", // Per prendere App.java e tutto il progetto
    "microservices.gestionedentista-appuntamento", // Per appuntamenti
    "microservices.pazienti", // Per pazienti
    "microservices.sicurezza", // Per sicurezza
    "config", // Per configurazioni generali
    "Repository", 
    "Services",
    "Controller",
    "Model",
    "Helpers",
    "KafkaConfig",
    "DTO",
    "Security",
    "Filters",
    "Utils"
})
@EnableMongoRepositories(basePackages = {
	    "Repository",
	    "microservices.gestionedentista-appuntamento.Repository",
	    "microservices.pazienti.Repository",
	    "microservices.sicurezza.Repository"
	})
public class App {
    public static void main(String[] args) {
        SpringApplication.run(App.class, args);
    }
}