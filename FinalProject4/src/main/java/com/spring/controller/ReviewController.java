package com.spring.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.model.MemberVO;
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
	
	
	// 해당 상품에 달린 리뷰목록 가져오기
	@ResponseBody
	@RequestMapping(value="/reviewList.action", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
	public String reviewList(HttpServletRequest request, ReviewVO reviewvo) {	
		
		String page = request.getParameter("page");
		
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("fk_userid", reviewvo.getFk_userid());
		paraMap.put("parentProdId", reviewvo.getParentProdId());
		
		if(page == null) {
			page = "1"; // 디폴트 1페이지
	    }
	   
	    int sizePerPage = 5;	// 페이지당 5개씩 보여준다.
		
	    int startRno = ((Integer.parseInt(page) - 1 ) * sizePerPage) + 1;
	    int endRno = startRno + sizePerPage - 1; 
		
	    paraMap.put("startRno", String.valueOf(startRno));
	    paraMap.put("endRno", String.valueOf(endRno));
	
		
		List<ReviewVO> reviewList = service.reviewList(paraMap); // 리뷰목록 불러오기
		
		List<HashMap<String, String>> reviewLikecntList = service.reviewLikecntList(paraMap); // 공연에 달린 리뷰의 추천수 
		
		/*
		for(int i=0; i<reviewLikecntList.size(); i++) {
			reviewLikecntList.get(i).get("reviewlikecnt");
			reviewLikecntList.get(i).get("fk_parentReviewId");
		}
		*/
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		List<String> reviewLikeList = new ArrayList<String>();
		
		if(loginuser != null) {
			paraMap.put("loginuserid", loginuser.getUserid()); 
		//	reviewLikeList = service.reviewLikeList(paraMap); 
			reviewLikeList = service.reviewLikeList(paraMap); // 로그인한 유저의 해당 공연에 대한 리뷰추천 목록
			// 1, 2, 15, 16
		}
		
		JSONArray jsonArr = new JSONArray();
		
		if(reviewList != null) {
			for(ReviewVO rvo : reviewList) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("parentProdId", rvo.getParentProdId());
				jsonObj.put("fk_userid", rvo.getFk_userid());
				jsonObj.put("review_id", rvo.getReview_id());
				jsonObj.put("name", rvo.getName());
				jsonObj.put("star", rvo.getStar());
				jsonObj.put("regDate", rvo.getRegDate());
				jsonObj.put("content", rvo.getContent());
				
			//	System.out.println(rvo.getReview_id());
			//	System.out.println(reviewLikeList.contains(rvo.getReview_id()));
				Boolean flag = false;
				
				if(reviewLikeList.contains(rvo.getReview_id())) { // 로그인 유저가 추천을 누른 리뷰id가 해당 공연에 있는 리뷰id 를 갖고 있다면
					flag = true;
				}
				
				jsonObj.put("flag",flag);
				
				
				for(int i=0; i<reviewLikecntList.size(); i++) {
					if(reviewLikecntList.get(i).get("fk_parentReviewId").equals(rvo.getReview_id())){ 
						jsonObj.put("reviewlikecnt", reviewLikecntList.get(i).get("reviewlikecnt"));
					}
				}
				
				
				jsonArr.put(jsonObj);
			}
		}
		
		return jsonArr.toString();
	}
	
	
    
	// 해당 상품에 달린 리뷰 총페이지 가져오기
	@ResponseBody
	@RequestMapping(value="/getReviewTotalPage.action", produces="text/plain;charset=UTF-8") 
	public String getCommentTotalPage(HttpServletRequest request) {
		
		String parentProdId = request.getParameter("parentProdId");
		String sizePerPage = request.getParameter("sizePerPage");
		
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("parentProdId", parentProdId);
		
		// 해당 상품(parentProdId) 에 해당하는 총 리뷰수 알아오기
		int totalCount = service.getReviewTotalCount(paraMap);

		// 총페이지(totalPage)수 구하기
		int totalPage = (int) Math.ceil((double)totalCount / Integer.parseInt(sizePerPage));
		
		double avgStar = 0;
		
		if(totalCount > 0) {
			// 해당 상품(parentProdId) 에 해당하는 평점 알아오기
			avgStar = service.getReviewAvgStar(paraMap);
			System.out.println(avgStar);
		}
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("totalPage", totalPage);
		jsonObj.put("totalCount", totalCount);
		jsonObj.put("avgStar", avgStar);
			       
		return jsonObj.toString();
		
	}
	
	// 리뷰 삭제하기
	@ResponseBody
	@RequestMapping(value="/delReview.action", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
	public String delReview(HttpServletRequest request, ReviewVO rvo) {	
		
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("fk_userid", rvo.getFk_userid());
		paraMap.put("review_id", rvo.getReview_id());
		
		int n = service.delReview(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	
	// 리뷰수정하기
	@ResponseBody
	@RequestMapping(value="/editReview.action", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
	public String editReview(HttpServletRequest request) {	

		String review_id = request.getParameter("review_id");
		String star = request.getParameter("star");
		String content = request.getParameter("content");
		
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("review_id", review_id);
		paraMap.put("star", star);
		paraMap.put("content", content);
		
		int n = service.editReview(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	
	// 리뷰 추천하기
	@ResponseBody
	@RequestMapping(value="/likeReview.action", produces="text/plain;charset=UTF-8")      
	public String likeReview(HttpServletRequest request) {

		String review_id = request.getParameter("review_id"); 
		String loginuserid = request.getParameter("loginuserid");  
		String fk_parentProdId = request.getParameter("fk_parentProdId");  
	//	String flag = request.getParameter("flag"); 

		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("review_id", review_id);
		paraMap.put("loginuserid", loginuserid);
		paraMap.put("fk_parentProdId", fk_parentProdId);
		
		int existlike = service.existLikeReview(paraMap); 
		String m = "";
		
		int result = 0;
		if(existlike == 0) { // 추천이 존재하지 않는다면
			result = service.likeReview(paraMap);
			m = "추천";
		}
		else { // 이미 추천했다면
			result = service.dislikeReview(paraMap);
			m = "추천취소";
		}
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("result", result);
		jsonObj.put("m", m);
		jsonObj.put("existlike", existlike);
	//	jsonObj.put("flag", flag);

		return jsonObj.toString();  

	} 
	
	
}
