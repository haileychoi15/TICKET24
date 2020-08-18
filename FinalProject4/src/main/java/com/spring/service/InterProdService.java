package com.spring.service;

import java.util.HashMap;
import java.util.List;

import com.spring.model.ProdVO;

public interface InterProdService {

	ProdVO prodDetail(String seq); // 상품 상세페이지로 이동

	List<HashMap<String, String>> seattypeList(String seq); // 상품의 좌석종류정보

	List<HashMap<String, String>> dateList(String seq); // 상품의 날짜정보

	List<HashMap<String, String>> showDateList(HashMap<String, String> paraMap); // 선택한 달력의 데이터와 같은 회차정보 불러오기

	int likeProd(HashMap<String, String> paraMap); // 관심상품 등록하기

	int dislikeProd(HashMap<String, String> paraMap); // 관심상품 해제하기

	int likeProdCnt(HashMap<String, String> paraMap); // 해당상품의 관심상품 등록수 

	int existlike(HashMap<String, String> paraMap); // 같은 아이디의 같은 관심상품이 존재하는지 확인

}
