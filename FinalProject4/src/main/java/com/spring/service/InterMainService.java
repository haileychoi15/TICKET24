package com.spring.service;

import java.util.HashMap;
import java.util.List;

import com.spring.model.ProdVO;

public interface InterMainService {

	// === 메인페이지 공연 정보들 === //
	List<ProdVO> getProdList(String category);
	
	// == 메인페이지 what's Hot === //
	List<ProdVO> getHotProdList(String category);
	
	// == 메인페이지 지역추천 == //
	List<ProdVO> getlocalRecProdList(String category);
	
	// == category 페이지 categoryName 가져오기 == //
	String getCategoryName(String category);

	// == category 페이지 detailCategoryName 가져오기 == //
	List<HashMap<String, String>> getdetailCategoryName(String category);
	
	int getTotalProdCount(HashMap<String, String> paraMap);

	List<ProdVO> prodList(HashMap<String, String> paraMap);

	



}
