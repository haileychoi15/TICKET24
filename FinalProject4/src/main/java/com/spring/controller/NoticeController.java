package com.spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.spring.common.FileManager;
import com.spring.service.InterNoticeService;

@Controller

public class NoticeController {
	
	@Autowired
	private InterNoticeService service;

	@Autowired
	private FileManager fileManager;
	
	
}
