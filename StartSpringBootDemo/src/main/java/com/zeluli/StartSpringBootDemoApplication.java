package com.zeluli;
/**
 * spring boot +mybatis(mapper.xml配置)+thymeleaf
 */

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.zeluli.dao")
public class StartSpringBootDemoApplication {

	public static void main(String[] args) {
		SpringApplication.run(StartSpringBootDemoApplication.class, args);
	}
}
