package com.spring.model;

import java.util.HashMap;

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
	
}
