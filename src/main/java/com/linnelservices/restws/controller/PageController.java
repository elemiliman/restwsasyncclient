package com.linnelservices.restws.controller;

import java.util.concurrent.ExecutionException;
import java.util.concurrent.Future;

import javax.ws.rs.BadRequestException;
import javax.ws.rs.client.AsyncInvoker;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.Entity;
import javax.ws.rs.client.Invocation.Builder;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.linnelservices.restws.entity.ChecksList;


@RestController
public class PageController {
	
	private static final String PATIENTS = "/checks";
	private static final String PATIENT_SERVICE_URL = "http://localhost:8080/restwsasync/services/checkprocessingservice";
	private static final Log log = LogFactory.getLog(PageController.class);
	
	//Get Single Patient
	Client client = ClientBuilder.newClient();
	WebTarget target = client.target(PATIENT_SERVICE_URL).path(PATIENTS);
	AsyncInvoker invoker = target.request().async();
	
	
	@RequestMapping("/")
	ModelAndView home(ModelAndView modelAndView){
				
		modelAndView.setViewName("app.homepage");
		
		Future<Boolean> response = invoker.post(Entity.entity(new ChecksList(), MediaType.APPLICATION_XML), Boolean.class);
		
		log.info("================================================");
		try {
			log.info(response.get());
		} catch (InterruptedException e) {
			e.printStackTrace();
		} catch (ExecutionException e) {
			if(e.getCause() instanceof BadRequestException){
				BadRequestException bre = (BadRequestException)e.getCause();
				log.info("Please send a valid list of checks");
			}
		}
		log.info("================================================");
				
		return modelAndView;
	}
}
