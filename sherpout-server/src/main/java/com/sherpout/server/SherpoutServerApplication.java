package com.sherpout.server;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication(scanBasePackages = "com.sherpout.server")
public class SherpoutServerApplication {

    public static void main(String[] args) {
        SpringApplication.run(SherpoutServerApplication.class, args);
    }

}
