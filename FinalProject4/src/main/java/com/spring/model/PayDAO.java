package com.spring.model;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository  
public class PayDAO implements InterPayDAO {

	@Resource
	private SqlSessionTemplate sqlsession;

	// == 예매하기 클릭 시, 좌석선택 및 시간, 할인 팝업창 띄우기 == //
	@Override
	public HashMap<String, String> getShowRsvInfo(String showNum) {
		HashMap<String, String> getShowRsvInfo = sqlsession.selectOne("finalproject4.getShowRsvInfo", showNum);
		return getShowRsvInfo;
	}
	
	// == 예매하기, 공연 날짜정보 == //
	@Override
	public List<String> getShowDay(String showNum) {
		List<String> getShowDay = sqlsession.selectList("finalproject4.getShowDay", showNum);
		return getShowDay;
	}

	// == 예매하기 창, 공연 시간정보 == //
	@Override
	public List<HashMap<String, String>> getShowTime(String showNum) {
		List<HashMap<String, String>> getShowTime = sqlsession.selectList("finalproject4.getShowTime", showNum);
		return getShowTime;
	}

	// == 시간, 회차에 따른 좌석상태 ajax == //
	@Override
	public List<HashMap<String, String>> getSeatStatus(String dateID) {
		List<HashMap<String, String>> getSeatStatus = sqlsession.selectList("finalproject4.getSeatStatus", dateID);
		return getSeatStatus;
	}

	// == 좌석 타입 정보 == //
	@Override
	public List<HashMap<String, String>> getSeatType(String showNum) {
		List<HashMap<String, String>> getSeatType = sqlsession.selectList("finalproject4.getSeatType", showNum);
		return getSeatType;
	}

	// == 공연 일시 코드 가져오기 == //
	@Override
	public String getDateId(HashMap<String, String> seatMap) {
		String dateId = sqlsession.selectOne("finalproject4.getDateId", seatMap);
		return dateId;
	}

	// == 결제창 사용가능 쿠폰 가져오기 == //
	@Override
	public List<HashMap<String, String>> takeCoupon(String userid2) {
		List<HashMap<String, String>> takeCoupon = sqlsession.selectList("finalproject4.takeCoupon", userid2);
		return takeCoupon;
	}

	// 결제완료 후 예매테이블 insert == //
	@Override
	public int reserveComplete(HashMap<String, String> reserveInsertMap) {
		int n = sqlsession.insert("finalproject4.reserveInsert", reserveInsertMap);
		return n;
	}

	@Override
	public int updateSeat(HashMap<String, String> updateSeatMap) {
		int n = sqlsession.update("finalproject4.updateSeat", updateSeatMap);
		return n;
	}

	@Override
	public int insertSeatList(HashMap<String, String> updateSeatMap) {
		int n = sqlsession.insert("finalproject4.insertSeatList", updateSeatMap);
		return n;
	}

	@Override
	public String getRevId(HashMap<String, String> reserveInsertMap) {
		String getRevId = sqlsession.selectOne("finalproject4.getRevId", reserveInsertMap);
		return getRevId;
	}

	@Override
	public int reserveStatusInsert(HashMap<String, String> reserveInsertMap) {
		int n = sqlsession.insert("finalproject4.reserveStatusInsert", reserveInsertMap);
		return n;
	}

	@Override
	public String getMap(String showNum) {
		String mapName = sqlsession.selectOne("finalproject4.getMap", showNum);
		return mapName;
	}

}
