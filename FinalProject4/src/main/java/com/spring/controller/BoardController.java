package com.spring.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.common.FileManager;
import com.spring.model.FaqVO;
import com.spring.service.InterBoardService;

@Controller
public class BoardController {
	
	@Autowired	// Type 에 따라 알아서 스프링컨테이너가 Bean 을 주입해준다.
	private InterBoardService service;


	// ===== #150. 파일업로드 및 다운로드를 해주는 FileManager 클래스 의존객체 주입하기(DI: Dependency Injection) =====
	@Autowired	// Type 에 따라 알아서 스프링컨테이너가 Bean 을 주입해준다.
	private FileManager fileManager;
	
	@RequestMapping(value = "/qna.action", produces="text/plain;charset=UTF-8", method = RequestMethod.GET)
	public String qna() {
		
		return "qna/qna.tiles1";
	}
	
	// FAQ 
	@ResponseBody
	@RequestMapping(value = "/faq.action", produces="text/plain;charset=UTF-8")
//	@RequestMapping(value = "/faq.action", produces="text/plain;charset=UTF-8", method = RequestMethod.GET)
	public String qna(HttpServletRequest request) {
		
		String category = request.getParameter("category");
		String searchWord = request.getParameter("searchWord");
		
		System.out.println(category +"category");
		System.out.println(searchWord +"searchWord");
		
	// 	if(category == "0") {
		if(category.equals("0")) {
			category = "";
		}
		
		if(searchWord == null || searchWord.trim().isEmpty()) {
			searchWord = ""; 
		}
		
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("category", category);
		paraMap.put("searchWord", searchWord);
		
		
		List<FaqVO> faqList = service.faqList(paraMap);
		
		JSONArray jsonArr = new JSONArray();

		for(FaqVO faqvo : faqList) {
			JSONObject jsonObj = new JSONObject();
			// jsonObj 객체에 결과물 testvo 을 넣고(put)
			//	jsonObj.put("testvo", testvo); // 그런데 이렇게 하면 안된다.
			//	그냥 객체만 들어가므로, 뷰단에서 키값으로 no, name, writeday 를 설정했으므
			//	jsonObj.put 으로 키값과 밸류값을 넣어줘야 한다.
			jsonObj.put("category", faqvo.getFaq_cate_name());
			jsonObj.put("fk_userid", faqvo.getFk_userid());
			jsonObj.put("content", faqvo.getContent());
			jsonObj.put("subject", faqvo.getSubject());
			jsonObj.put("status", faqvo.getStatus());
			jsonObj.put("regDate", faqvo.getRegDate());


			jsonArr.put(jsonObj);
		}

		
		return jsonArr.toString();
		
		
	}
	
	
	
}
