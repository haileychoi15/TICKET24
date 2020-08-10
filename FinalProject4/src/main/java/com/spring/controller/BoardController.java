package com.spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.common.FileManager;
import com.spring.service.InterBoardService;

@Controller
public class BoardController {
	
	@Autowired	// Type 에 따라 알아서 스프링컨테이너가 Bean 을 주입해준다.
	private InterBoardService service;


	// ===== #150. 파일업로드 및 다운로드를 해주는 FileManager 클래스 의존객체 주입하기(DI: Dependency Injection) =====
	@Autowired	// Type 에 따라 알아서 스프링컨테이너가 Bean 을 주입해준다.
	private FileManager fileManager;

	@RequestMapping(value = "/qna.action", method = RequestMethod.GET)
	public String qna() {
		
		return "qna/qna.tiles1";
	}
	
	
}
