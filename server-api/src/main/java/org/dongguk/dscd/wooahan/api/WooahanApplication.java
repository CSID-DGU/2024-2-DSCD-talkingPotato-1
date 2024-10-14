package org.dongguk.dscd.wooahan.api;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableAsync;

@EnableAsync
@SpringBootApplication
public class WooahanApplication {

	public static void main(String[] args) {
		SpringApplication.run(WooahanApplication.class, args);
	}

}
