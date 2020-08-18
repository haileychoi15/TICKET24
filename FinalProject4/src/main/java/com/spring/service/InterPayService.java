package com.spring.service;

import java.util.HashMap;
import java.util.List;

public interface InterPayService {

	// == 예매하기 클릭 시, 좌석선택 및 시간, 할인 팝업창 띄우기 == //
	HashMap<String, String> getShowRsvInfo(String showNum);

	// == 예매하기, 공연 날짜정보 == //
	List<String> getShowDay(String showNum);
	
	// == 예매하기 창, 공연 시간정보 == //
	List<HashMap<String, String>> getShowTime(String showNum);

	// == 시간, 회차에 따른 좌석상태 ajax == //
	List<HashMap<String, String>> getSeatStatus(String dateID);

	// == 좌석 타입 정보 == //
	List<HashMap<String, String>> getSeatType(String showNum);

	// == 공연 일시 코드 가져오기 == //
	String getDateId(HashMap<String, String> seatMap);

	// == 결제창 사용가능 쿠폰 가져오기 == //
	List<HashMap<String, String>> takeCoupon(String userid);


}
