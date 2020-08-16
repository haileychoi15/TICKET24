package com.spring.model;

import java.util.HashMap;
import java.util.List;

public interface InterProdDAO {

	ProdVO prodDetail(String seq); // 상품 상세페이지로 이동

	List<HashMap<String, String>> seattypeList(String seq); // 상품의 좌석종류정보

	List<HashMap<String, String>> dateList(String seq); // 상품의 날짜정보

	List<HashMap<String, String>> showDateList(HashMap<String, String> paraMap); // 선택한 달력의 데이터와 같은 회차정보 불러오기

}
