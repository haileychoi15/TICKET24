package com.spring.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.model.InterMainDAO;
import com.spring.model.InterPayDAO;
import com.spring.model.ProdVO;

@Service
public class MainService implements InterMainService {

	@Autowired
	private InterMainDAO dao;
	
	// === 메인페이지 공연 정보들 === //
	@Override
	public List<ProdVO> getProdList(String category) {
		List<ProdVO> getProdList = dao.getProdList(category);
		return getProdList;
	}
	
	@Override
	public int getTotalProdCount(HashMap<String, String> paraMap) {
		int n = dao.getTotalProdCount(paraMap);
		return n;
	}
	
	@Override
	public List<ProdVO> prodList(HashMap<String, String> paraMap) {
		List<ProdVO> prodList = dao.prodList(paraMap);
		return prodList;
	}

	


}
