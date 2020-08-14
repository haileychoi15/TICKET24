package com.spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.spring.common.FileManager;
import com.spring.service.InterQnaService;

@Controller
public class QnaController {
	
	@Autowired
	private InterQnaService service;

	@Autowired
	private FileManager fileManager;

	
}
