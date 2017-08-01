package com.by;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.context.web.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Import;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;

import com.by.utils.UpYun;

@SpringBootApplication
@Import(value = { com.by.RepositoryApplication.class, com.by.ModelApplication.class })
public class Application extends SpringBootServletInitializer {
	public static void main(String[] args) {
		SpringApplication.run(Application.class, args);
	}

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
		return application.sources(Application.class);
	}

	@Bean
	public UpYun upYun() {
		UpYun yun = new UpYun("cchdev", "carl", "Joymap88");
		yun.setDebug(true);
		return yun;
	}

	@Bean
	public ShaPasswordEncoder encoder() {
		return new ShaPasswordEncoder(256);
	}
}
