package com.spring.service;

import java.util.HashMap;
import java.util.List;

import com.spring.model.ProdVO;

public interface InterMainService {

	// === 메인페이지 공연 정보들 === //
	List<ProdVO> getProdList(String category);
	
	int getTotalProdCount(HashMap<String, String> paraMap);

	List<ProdVO> prodList(HashMap<String, String> paraMap);



}
