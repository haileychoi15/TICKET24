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

	
	// 예매 시 필요한 공연정보 가져오기
	@Override
	public HashMap<String, String> revShowInfo(String showNum) {
		HashMap<String, String> showvo = sqlsession.selectOne("finalproject4.revShowInfo", showNum);
		return showvo;
	}
	
}
