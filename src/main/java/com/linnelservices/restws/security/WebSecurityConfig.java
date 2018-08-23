package com.linnelservices.restws.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.password.PasswordEncoder;

@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {
			
//	@Autowired
//	private UserService userService;
	
//	@Autowired
//	private PasswordEncoder passwordEncoder;
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {

		//@formatter:off
		
		http
			.authorizeRequests()
				.mvcMatchers("/",
							"/about",
							"/register",
							"/confirmregistration",
							"/search",
							"/js/*",
							"/css/*",
							"/img/*").permitAll()
				.mvcMatchers("/addstatus",
							 "/viewstatus",
							 "/deletestatus",
							 "/editstatus").hasRole("ADMIN")
				.mvcMatchers("/profile",
							 "/profile/*",
							 "/edit-profile",
							 "/upload-profile-photo",
							 "/profilePhoto",
							 "/save-interest",
							 "/delete-interest").authenticated()
				.anyRequest().denyAll();
		
		http
			.formLogin()
				.loginPage("/login")
				.defaultSuccessUrl("/")
				.permitAll()
				.and()
			.logout()
				.permitAll();
		
		//@formatter:on
	}

//	@Override
//	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
//		auth.userDetailsService(userService).passwordEncoder(passwordEncoder);
//	}
}
