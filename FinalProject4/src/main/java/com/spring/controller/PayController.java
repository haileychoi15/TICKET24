package com.spring.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hpsf.Array;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.model.MemberVO;
import com.spring.service.InterPayService;

@Component
@Controller
public class PayController {

	@Autowired
	private InterPayService service;
	
	// == 예매하기 클릭 시, 좌석선택 및 시간, 할인 팝업창 띄우기 == //
	@RequestMapping(value="/reservePopUp.action")
	/*public ModelAndView requiredLogin_reservePopUp(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {*/
	public ModelAndView reservePopUp(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
/*
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		mav.addObject("loginuser", loginuser);
		
		String showNum = request.getAttribute("prodID");
*/
		String showNum = "1";
		mav.addObject("showNum", showNum);
		
		HashMap<String, String> getShowRsvInfo = new HashMap<>();
		getShowRsvInfo = service.getShowRsvInfo(showNum);
		mav.addObject("getShowRsvInfo", getShowRsvInfo);
		
		List<String> getShowDay = new ArrayList<>();
		getShowDay = service.getShowDay(showNum);
		mav.addObject("getShowDay", getShowDay);
		
		List<HashMap<String, String>> getShowTime = new ArrayList<>();
		getShowTime = service.getShowTime(showNum);
		mav.addObject("getShowTime", getShowTime);
		
		// 좌석타입종류
		List<HashMap<String, String>> getSeatType = new ArrayList<>();
		getSeatType = service.getSeatType(showNum);
		mav.addObject("getSeatType", getSeatType);
		
		mav.setViewName("reserve/seat.notiles");
		return mav;
	}
	
	// == 시간, 회차에 따른 좌석상태 ajax == //
	@ResponseBody
	@RequestMapping(value="/seatStatus.action", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	/*public String requiredLogin_seatStatus(HttpServletRequest request, HttpServletResponse response) {*/
	public String seatStatus(HttpServletRequest request, HttpServletResponse response) {
	
		String showDay = request.getParameter("showDay");
		String showRound = request.getParameter("showRound");
		String showNum = request.getParameter("prodID");
		
		HashMap<String, String> seatMap = new HashMap<>();
		seatMap.put("showDay", showDay);
		seatMap.put("showRound", showRound);
		seatMap.put("showNum", showNum);
		String dateID = service.getDateId(seatMap);
		
		JSONArray jsonArr = new JSONArray();
		
		List<HashMap<String, String>> getSeatStatus = service.getSeatStatus(dateID);
		
		if(getSeatStatus != null) {
			for(HashMap<String, String> seatStatus : getSeatStatus ) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("date_id", seatStatus.get("date_id"));
				jsonObj.put("prod_id", seatStatus.get("prod_id"));
				jsonObj.put("seattype_id", seatStatus.get("seattype_id"));
				jsonObj.put("seat_type", seatStatus.get("seat_type"));
				jsonObj.put("seat_name", seatStatus.get("seat_name"));
				jsonObj.put("seat_price", seatStatus.get("seat_price"));
				jsonObj.put("seat_status", seatStatus.get("seat_status"));
				jsonObj.put("date_id", seatStatus.get("date_id"));
				jsonObj.put("seat_color", seatStatus.get("seat_color"));
				
				jsonArr.put(jsonObj);
			}
		}
		
		return jsonArr.toString();
	}
		
	
	
	// == 결제 실행 API 띄우기 == //
	@RequestMapping(value="/payPopUp.action")
	/*public ModelAndView requiredLogin_payPopUp(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {*/
	public ModelAndView payPopUp(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
//		HttpSession session = request.getSession();
//		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
//		mav.addObject("loginuser", loginuser);
		
		String payMethodNum = request.getParameter("payNum"); // 결제 방법(1. 신용카드 or 2. 무통장입금)
		String showName = request.getParameter("showName"); // 공연 제목
		
		String showNum = request.getParameter("showNum"); // 공연 코드
		String paySum = request.getParameter("paySum"); // 공연 금액
		String payStatus = ""; // ( 2. 무통장입금이면 결제대기, 1. 바로 결제완료라면 결제완료, 0. 취소할경우 취소 )
		String email = request.getParameter("Email"); // 예매 이메일
		String showDay = request.getParameter("showDay");
		String showRound = request.getParameter("showRound");
		HashMap<String, String> dateMap = new HashMap<>();
		dateMap.put("showDay", showDay);
		dateMap.put("showRound", showRound);
		dateMap.put("showNum", showNum);
		String dateID = service.getDateId(dateMap); // 일시 코드
		String receiveMethod = request.getParameter("receiveMethod"); // 수령방법 ( 1. 현장수령  or 2. 배송 )
		
		String seatIdes = request.getParameter("seatIdes"); // 좌석코드
		String[] seatArr = seatIdes.split(",");
		int seatCnt2 = seatArr.length;
		String seatCnt = String.valueOf(seatCnt2); // 예매 수
		
		HashMap<String, String> reserveInfoMap = new HashMap<>();
		reserveInfoMap.put("payMethodNum", payMethodNum);
		reserveInfoMap.put("showNum", showNum);
		reserveInfoMap.put("paySum", paySum);
		reserveInfoMap.put("email", email);
		reserveInfoMap.put("dateID", dateID);
		reserveInfoMap.put("receiveMethod", receiveMethod);
		reserveInfoMap.put("showName", showName);
		reserveInfoMap.put("seatIdes", seatIdes);
		reserveInfoMap.put("seatCnt", seatCnt);
		
		if("1".equals(payMethodNum)) { // 신용카드 결제일 경우
			payStatus = "1";
			reserveInfoMap.put("payStatus", payStatus);
			mav.addObject("reserveInfoMap", reserveInfoMap);
			mav.setViewName("reserve/paymentGateway.notiles");
		}
		else if("2".equals(payMethodNum)) { // 무통장입금일 경우
			payStatus = "2";
			reserveInfoMap.put("payStatus", payStatus);
			
			// 무통장입금일 경우 트랜잭션
			mav.setViewName("reserve/payComplete.notiles");
		}
		
		return mav;
	}
	
	// == 결제 실행 API 띄우기 == //
	@RequestMapping(value="/payComplete.action")
	/*public ModelAndView requiredLogin_payComplete(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {*/
	public ModelAndView payComplete(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		//HttpSession session = request.getSession();
		//MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		//String userid = loginuser.getUserid();
		String userid = "guzi10";
		
		String showNum = request.getParameter("showNum");
		String dateID = request.getParameter("dateID");
		String email = request.getParameter("email");
		String paySum = request.getParameter("paySum");
		String receiveMethod = request.getParameter("receiveMethod");
		String payMethodNum = request.getParameter("payMethodNum");
		String payShowName = request.getParameter("payShowName");
		String payStatus = request.getParameter("payStatus");
		String seatCnt = request.getParameter("seatCnt");
		String seatIdes = request.getParameter("seatIdes");
		String[] seatArr = seatIdes.split(",");
		
		String payMethod = "";
		if("1".equals(payMethodNum)) { // 신용카드 결제일 경우
			payMethod = "신용카드";
		}
		else { // 무통장입금일 경우
			payMethod = "무통장입금";
		}
		
		String sReceiveMethod = "";
		if("1".equals(receiveMethod)) { // 신용카드 결제일 경우
			sReceiveMethod = "현장수령";
		}
		else { // 무통장입금일 경우
			sReceiveMethod = "배송";
		}
		
		
		
		HashMap<String, String> reserveInsertMap = new HashMap<>();
		reserveInsertMap.put("showNum", showNum);
		reserveInsertMap.put("dateID", dateID);
		reserveInsertMap.put("email", email);
		reserveInsertMap.put("payShowName", payShowName);
		reserveInsertMap.put("receiveMethod", receiveMethod);
		reserveInsertMap.put("paySum", paySum);
		reserveInsertMap.put("payMethodNum", payMethodNum);
		reserveInsertMap.put("userid", userid);
		reserveInsertMap.put("payStatus", payStatus);
		reserveInsertMap.put("seatCnt", seatCnt);
		reserveInsertMap.put("seatIdes", seatIdes);
		
		
		HashMap<String, String> reserveInfoMap = new HashMap<>();
		reserveInfoMap.put("payShowName", payShowName);
		reserveInfoMap.put("payMethod", payMethod);
		reserveInfoMap.put("sReceiveMethod", sReceiveMethod);
		
		reserveInfoMap.put("showNum", showNum);
		reserveInfoMap.put("receiveMethod", receiveMethod);
		reserveInfoMap.put("paySum", paySum);
		reserveInfoMap.put("dateID", dateID);
		
		// 결제 성공했을 경우 트랜잭션
		int n = service.reserveComplete(reserveInsertMap);
		String revId = service.getRevId(reserveInsertMap);
		String mapName = service.getMap(showNum);
		
		
		reserveInsertMap.put("revId", revId);
		reserveInfoMap.put("revId", revId);
		int m = service.reserveStatusInsert(reserveInsertMap);
		
		if(n == 1) {
			mav.addObject("reserveInfoMap", reserveInfoMap);
			mav.addObject("seatArr", seatArr);
			mav.addObject("mapName", mapName);
			mav.setViewName("reserve/payComplete.notiles");
		}
		else {
			String msg = "결제가 실패하였습니다.";
			String loc = "javascript:history.back()";
			
			mav.addObject("msg", msg);
			mav.addObject("loc", loc);
			
			mav.setViewName("msg");
		}
		
		return mav;
	}
	
	// == 사용가능한 쿠폰 목록가져오기 == //
	@ResponseBody
	@RequestMapping(value="/takeCoupon.action", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	/*public String requriedLogin_takeCoupon(HttpServletRequest request, HttpServletResponse response) {*/
	public String takeCoupon(HttpServletRequest request, HttpServletResponse response) {
	
//		HttpSession session = request.getSession();
//		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
//		
//		String userid = loginuser.getUserid();
		String userid = "guzi10";

		JSONArray jsonArr = new JSONArray();
		
		List<HashMap<String, String>> takeCoupon = service.takeCoupon(userid);
		
		if(takeCoupon != null) {
			for(HashMap<String, String> coupon : takeCoupon ) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("coupon_dc", coupon.get("coupon_dc"));
				jsonObj.put("coupon_name", coupon.get("coupon_name"));
				
				jsonArr.put(jsonObj);
			}
		}
		
		return jsonArr.toString();
	}
	
	
}
