package com.spring.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.model.NoticeVO;
import com.spring.model.ProdVO;
import com.spring.model.ReviewVO;
import com.spring.service.InterProdService;

@Component
@Controller
public class ProdController {
	
	@Autowired
	private InterProdService service;
	
	// 상품 상세페이지로 이동
	@RequestMapping(value="/detail.action")
	public ModelAndView detail(HttpServletRequest request, ModelAndView mav) {
		
		String seq = request.getParameter("seq");
		
		ProdVO pvo = service.prodDetail(seq); // 상품의 상세정보
		
		List<HashMap<String, String>> seattypeList = service.seattypeList(seq); // 상품의 좌석종류정보
		
		List<HashMap<String, String>> dateList = service.dateList(seq); // 상품의 날짜정보 
		
		mav.addObject("pvo", pvo);
		mav.addObject("seattypeList", seattypeList);
		mav.addObject("dateList", dateList);
		
	//	System.out.println(dateList.get(0).get("date_showday"));
	
		mav.setViewName("prod/detail.tiles1");
		return mav;
	}
	
	
	// 선택한 달력의 데이터와 같은 회차정보 불러오기
	@ResponseBody
	@RequestMapping(value="/dateLoading.action", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
	public String notice(HttpServletRequest request) {	
		
		String date = request.getParameter("chooseDate");
		String seq = request.getParameter("seq");
		

		System.out.println(date);
		
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("date", date);
		paraMap.put("seq", seq);
		
		List<HashMap<String, String>> showDateList = service.showDateList(paraMap);
		
		
		JSONArray jsonArr = new JSONArray();
	
		for(HashMap<String, String> showDate : showDateList) {
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("date_id", showDate.get("date_id"));
			jsonObj.put("prod_id", showDate.get("prod_id"));
			jsonObj.put("date_showday", showDate.get("date_showday"));
			jsonObj.put("date_showtime", showDate.get("date_showtime"));
	
			jsonArr.put(jsonObj);
		}
	
		return jsonArr.toString();
	}
	
	
	// 관심상품 등록하기
	@ResponseBody
	@RequestMapping(value="/likeProd.action", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
	public String likeProd(HttpServletRequest request) {	
		
		String fk_userid = request.getParameter("fk_userid");
		String prod_id = request.getParameter("prod_id");
		String existlike = request.getParameter("existlike");
		
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("fk_userid", fk_userid);
		paraMap.put("prod_id", prod_id);
		
		// 같은 아이디의 같은 글번호의 추천이 존재하는지 확인
		int n = 0;
		String m = "";
		
		System.out.println(existlike);
		
		if(existlike.equals("0")) { // 사용자에 해당 글번호에 대한 추천이 존재하지 않는다면
			n = service.likeProd(paraMap);
			m = "추천";
		}
		else { // 사용자에 해당 글번호에 대한 추천이 존재한다면
			n = service.dislikeProd(paraMap);
			m = "추천취소";
		}

		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		jsonObj.put("m", m);

		return jsonObj.toString();  
	}
	
	
	// 해당상품의 관심상품 등록수 
	@ResponseBody
	@RequestMapping(value="/LikeProdCnts.action", produces="text/plain;charset=UTF-8")      
	public String LikeProdCnt(HttpServletRequest request) {

		String prod_id = request.getParameter("prod_id");
		System.out.println(prod_id);
		
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("prod_id", prod_id);

		int LikeProdCnt = service.likeProdCnt(paraMap);

		JSONObject jsonObj = new JSONObject();
		jsonObj.put("LikeProdCnt", LikeProdCnt);

		return jsonObj.toString();  

	} 


	// 해당상품의 관심상품 누른 사람 목록
	@ResponseBody
	@RequestMapping(value="/likeProdUser.action", produces="text/plain;charset=UTF-8")      
	public String likeProdUser(HttpServletRequest request) {

		String prod_id = request.getParameter("prod_id");

		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("prod_id", prod_id);

		List<String> likeProdUserList = service.likeProdUserList(paraMap);

		JSONArray jsonArr = new JSONArray(); // jsonArr 는 이미 생성되었기 때문에 null 은 아니다. 따라서 json.length > 0, == 0 으로 구분한다. 

		if(likeProdUserList != null) {
			for(String likeUser : likeProdUserList) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("likeUser", likeUser);
				jsonArr.put(jsonObj);
			}
		}

		return jsonArr.toString();  

	} 
	
}
