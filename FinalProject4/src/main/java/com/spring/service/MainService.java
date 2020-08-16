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
	
	// == 메인페이지 what's Hot === //
	@Override
	public List<ProdVO> getHotProdList(String category) {
		List<ProdVO> getHotProdList = dao.getHotProdList(category);
		return getHotProdList;
	}
	
	// == 메인페이지 지역추천 == //
	@Override
	public List<ProdVO> getlocalRecProdList(String category) {
		List<ProdVO> getlocalRecProdList = dao.getlocalRecProdList(category);
		return getlocalRecProdList;
	}
	
	// == category 페이지 categoryName 가져오기 == //
	@Override
	public String getCategoryName(String category) {
		String getCategoryName = dao.getCategoryName(category);
		return getCategoryName;
	}
	
	// == category 페이지 detailCategoryName 가져오기 == //
	@Override
	public List<HashMap<String, String>> getdetailCategoryName(String category) {
		List<HashMap<String, String>> getdetailCategoryName = dao.getdetailCategoryName(category);
		return getdetailCategoryName;
	}

	// == 카테고리 페이지 공연 정보 ajax == //
	@Override
	public List<HashMap<String, String>> getSelectedShowList(HashMap<String, String> showInfoMap) {
		String num = showInfoMap.get("selectNum");
		List<HashMap<String, String>> getSelectedShowList = null;
		
		switch (num) {
		case "1":
			getSelectedShowList = dao.selectOne(showInfoMap);
			break;
		case "2":
			getSelectedShowList = dao.selectTwo(showInfoMap);
			break;
		case "3":
			getSelectedShowList = dao.selectThree(showInfoMap);
			break;
		case "4":
			getSelectedShowList = dao.selectFour(showInfoMap);
			break;
		}
		
		return getSelectedShowList;
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

	@Override
	public String getTotalCnt(HashMap<String, String> showInfoMap) {
		String getTotalCnt = dao.getTotalCnt(showInfoMap);
		return getTotalCnt;
	}

	

}
