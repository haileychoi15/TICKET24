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

}
