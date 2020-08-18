package com.spring.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.model.InterPayDAO;

@Service
public class PayService implements InterPayService {

	@Autowired
	private InterPayDAO dao;

	// == 예매하기 클릭 시, 좌석선택 및 시간, 할인 팝업창 띄우기 == //
	@Override
	public HashMap<String, String> getShowRsvInfo(String showNum) {
		HashMap<String, String> getShowRsvInfo = dao.getShowRsvInfo(showNum);
		return getShowRsvInfo;
	}

	// == 예매하기, 공연 날짜정보 == //
	@Override
	public List<String> getShowDay(String showNum) {
		List<String> getShowDay = dao.getShowDay(showNum);
		return getShowDay;
	}
	
	// == 예매하기 창, 공연 시간정보 == //
	@Override
	public List<HashMap<String, String>> getShowTime(String showNum) {
		List<HashMap<String, String>> getShowTime = dao.getShowTime(showNum);
		return getShowTime;
	}

	// == 시간, 회차에 따른 좌석상태 ajax == //
	@Override
	public List<HashMap<String, String>> getSeatStatus(String dateID) {
		List<HashMap<String, String>> getSeatStatus = dao.getSeatStatus(dateID);
		return getSeatStatus;
	}

	// == 좌석 타입 정보 == //
	@Override
	public List<HashMap<String, String>> getSeatType(String showNum) {
		List<HashMap<String, String>> getSeatType = dao.getSeatType(showNum);
		return getSeatType;
	}

	// == 공연 일시 코드 가져오기 == //
	@Override
	public String getDateId(HashMap<String, String> seatMap) {
		String dateId = dao.getDateId(seatMap);
		return dateId;
	}

	// == 결제창 사용가능 쿠폰 가져오기 == //
	@Override
	public List<HashMap<String, String>> takeCoupon(String userid) {
		List<HashMap<String, String>> takeCoupon = dao.takeCoupon(userid);
		return takeCoupon;
	}

}
