package com.spring.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.model.InterProdDAO;
import com.spring.model.ProdVO;

@Service
public class ProdService implements InterProdService {
	
	@Autowired
	private InterProdDAO dao;

	// 상품 상세페이지로 이동
	@Override
	public ProdVO prodDetail(String seq) {
		ProdVO pvo = dao.prodDetail(seq);
		return pvo;
	}

	// 상품의 좌석종류정보
	@Override
	public List<HashMap<String, String>> seattypeList(String seq) {
		List<HashMap<String, String>> seattypeList = dao.seattypeList(seq);
		return seattypeList;
	}
	
	// 상품의 날짜정보 
	@Override
	public List<HashMap<String, String>> dateList(String seq) {
		List<HashMap<String, String>> dateList = dao.dateList(seq);
		return dateList;
	}

	// 선택한 달력의 데이터와 같은 회차정보 불러오기
	@Override
	public List<HashMap<String, String>> showDateList(HashMap<String, String> paraMap) {
		List<HashMap<String, String>> showDateList = dao.showDateList(paraMap);
		return showDateList;
	}
	
}
