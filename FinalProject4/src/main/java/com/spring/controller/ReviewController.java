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

import com.spring.model.ReviewVO;
import com.spring.service.InterReviewService;

@Controller
public class ReviewController {
	
	@Autowired	// Type 에 따라 알아서 스프링컨테이너가 Bean 을 주입해준다.
	private InterReviewService service;

	// 리뷰등록하기
	@ResponseBody
	@RequestMapping(value="/addReview.action", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
	public String addReview(HttpServletRequest request, ReviewVO rvo) {	
		
		String fk_userid = request.getParameter("fk_userid");
		String name = request.getParameter("name");
		String content = request.getParameter("content");
		String star = request.getParameter("star");
		String parentProdId = request.getParameter("parentProdId");
		

		System.out.println(rvo.getFk_userid());
		System.out.println(rvo.getName());
		System.out.println(rvo.getContent());
		System.out.println(rvo.getStar());
		System.out.println(rvo.getParentProdId());
		
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("fk_userid", rvo.getFk_userid());
		paraMap.put("name", rvo.getName());
		paraMap.put("content", rvo.getContent());
		paraMap.put("star", rvo.getStar());
		paraMap.put("parentProdId", rvo.getParentProdId());
		
		int n = service.addReview(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	
}
