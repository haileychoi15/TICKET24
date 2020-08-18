package com.spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.common.FileManager;
import com.spring.service.InterAdminService;

@Controller
public class AdminController {
	
	@Autowired
	private InterAdminService service;

	@Autowired
	private FileManager fileManager;
	
	
	// 고객센터 페이지로 이동
	@RequestMapping(value = "/adminMain.action", produces="text/plain;charset=UTF-8", method = RequestMethod.GET)
	public String adminMain() {
		
		return "admin/main.tiles1";
	}
	
}
