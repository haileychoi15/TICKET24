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

	// 관심상품 등록하기
	@Override
	public int likeProd(HashMap<String, String> paraMap) {
		int n = dao.likeProd(paraMap);
		return n;
	}

	// 관심상품 해제하기
	@Override
	public int dislikeProd(HashMap<String, String> paraMap) {
		int n = dao.dislikeProd(paraMap);
		return n;
	}
	
	// 해당상품의 관심상품 등록수 
	@Override
	public int likeProdCnt(HashMap<String, String> paraMap) {
		int n = dao.likeProdCnt(paraMap);
		return n;
	}
	
	// 같은 아이디의 같은 관심상품이 존재하는지 확인
	@Override
	public int existlike(HashMap<String, String> paraMap) {
		int n = dao.existlike(paraMap);
		return n;
	}
	
	
}
