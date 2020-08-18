package com.spring.model;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository 
public class MapDAO implements InterMapDAO {
	
	@Resource
	private SqlSessionTemplate sqlsession;
	
	
	// 해당상품의 지도정보 불러오기
	@Override
	public HashMap<String, String> mapInfo(HashMap<String, String> paraMap) {
		HashMap<String, String> mapInfo = sqlsession.selectOne("finalproject4.mapInfo", paraMap);
		return mapInfo;
	}
	
	

}
