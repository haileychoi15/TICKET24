package com.spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;

import com.spring.service.InterPayService;

@Component
@Controller
public class PayController {

	@Autowired
	private InterPayService service;
	
	
}
