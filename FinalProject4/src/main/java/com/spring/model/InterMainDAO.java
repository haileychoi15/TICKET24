package com.spring.model;

import java.util.HashMap;
import java.util.List;

public interface InterMainDAO {

	// === 메인페이지 공연 정보들 === //
	List<ProdVO> getProdList(String category);
		
	int getTotalProdCount(HashMap<String, String> paraMap);
	
	List<ProdVO> prodList(HashMap<String, String> paraMap);

}
