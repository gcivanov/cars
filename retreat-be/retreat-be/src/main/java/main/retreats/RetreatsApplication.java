package main.retreats;

import main.retreats.config.exception.ApiExceptionHandler;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Import;

@SpringBootApplication
public class RetreatsApplication {

	public static void main(String[] args) {
		SpringApplication.run(RetreatsApplication.class, args);
	}

}
