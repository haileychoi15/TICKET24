package com.spring.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

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

	// 결제완료 후 insert == //
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	public int reserveComplete(HashMap<String, String> reserveInsertMap) {
		String receiveMethod = reserveInsertMap.get("receiveMethod");
		String seatIdes = reserveInsertMap.get("seatIdes"); // 좌석코드
		String[] seatArr = seatIdes.split(",");
		String dateID = reserveInsertMap.get("dateID");
		String userid = reserveInsertMap.get("userid");
		String couponId = reserveInsertMap.get("couponId");
		String paySum = reserveInsertMap.get("paySum");
		String usePoint = reserveInsertMap.get("usePoint");
		
		int n = dao.reserveComplete(reserveInsertMap);
		
		if(n == 1) {
			for(int i=0; i<seatArr.length; i++) {
				String selSeat = seatArr[i];
				
				HashMap<String, String> updateSeatMap = new HashMap<>();
				updateSeatMap.put("selSeat", selSeat);
				updateSeatMap.put("dateID", dateID);
				updateSeatMap.put("userid", userid);
				
				int m = dao.updateSeat(updateSeatMap);
				int z = dao.insertSeatList(updateSeatMap);
				
			}
			
			HashMap<String, String> updatePoint = new HashMap<>();
			updatePoint.put("userid", userid);
			updatePoint.put("paySum", paySum);
			updatePoint.put("usePoint", usePoint);
			
			if(!"0".equals("couponId")) {
				int u = dao.useCoupon(couponId);
			}
			int p = dao.updatePoint(updatePoint);
			int l = dao.updatePointList(updatePoint);
			if(!"0".equals(usePoint)) {
				int p2 = dao.updatePoint2(updatePoint);
				int l2 = dao.updatePointList2(updatePoint);
			}
			
			if("2".equals(receiveMethod)) {
				// int m = dao.shipInsert(reserveInsertMap);
			}
			
		}
		

		return n;
	}

	@Override
	public String getRevId(HashMap<String, String> reserveInsertMap) {
		String getRevId = dao.getRevId(reserveInsertMap);
		return getRevId;
	}

	@Override
	public int reserveStatusInsert(HashMap<String, String> reserveInsertMap) {
		int n = dao.reserveStatusInsert(reserveInsertMap);
		return n;
	}

	@Override
	public String getMap(String showNum) {
		String mapName = dao.getMap(showNum);
		return mapName;
	}

	@Override
	public String getPoint(String userid) {
		String getPoint = dao.getPoint(userid);
		return getPoint;
	}


}
