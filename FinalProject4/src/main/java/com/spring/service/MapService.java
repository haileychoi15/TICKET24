package com.spring.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.model.InterMapDAO;

@Service
public class MapService implements InterMapService {
	
	@Autowired
	private InterMapDAO dao;

	// 해당상품의 지도정보 불러오기
	@Override
	public HashMap<String, String> mapInfo(HashMap<String, String> paraMap) {
		HashMap<String, String> mapInfo = dao.mapInfo(paraMap);
		return mapInfo;
	}
	
	
}
