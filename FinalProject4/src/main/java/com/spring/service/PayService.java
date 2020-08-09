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

}
