package com.spring.model;

import java.util.HashMap;
import java.util.List;

public interface InterMainDAO {

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

	// == category 공연 리스트 ajax - 주간랭킹순 == //
	List<HashMap<String, String>> selectOne(HashMap<String, String> showInfoMap);
	// == category 공연 리스트 ajax - 신상품순 == //
	List<HashMap<String, String>> selectTwo(HashMap<String, String> showInfoMap);
	// == category 공연 리스트 ajax - 종료임박순 == //
	List<HashMap<String, String>> selectThree(HashMap<String, String> showInfoMap);
	// == category 공연 리스트 ajax - 상품명순== //
	List<HashMap<String, String>> selectFour(HashMap<String, String> showInfoMap);
		
	int getTotalProdCount(HashMap<String, String> paraMap);
	
	List<ProdVO> prodList(HashMap<String, String> paraMap);

	String getTotalCnt(HashMap<String, String> showInfoMap);

	
	
}
