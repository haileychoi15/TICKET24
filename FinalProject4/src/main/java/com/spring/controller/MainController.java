package com.spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.service.InterPayService;

@Component
@Controller
public class MainController {
	
	@Autowired
	private InterPayService service;
	
	// == YES24 메인페이지 == //
	@RequestMapping(value="/yes24.action")
	public ModelAndView index(ModelAndView mav) {
		mav.setViewName("main/main.tiles1");
		return mav;
	}

}
