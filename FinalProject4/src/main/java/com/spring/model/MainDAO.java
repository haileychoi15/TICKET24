package com.spring.model;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class MainDAO implements InterMainDAO {

	@Resource
	private SqlSessionTemplate sqlsession;

	// === 메인페이지 공연 정보들 === //
	@Override
	public List<ProdVO> getProdList(String category) {
		List<ProdVO> getProdList = sqlsession.selectList("finalproject4.getProdList", category);
		return getProdList;
	}
	
	// == 메인페이지 what's Hot === //
	@Override
	public List<ProdVO> getHotProdList(String category) {
		List<ProdVO> getHotProdList = sqlsession.selectList("finalproject4.getHotProdList", category);
		return getHotProdList;
	}
	
	// == 메인페이지 지역추천 == //
	@Override
	public List<ProdVO> getlocalRecProdList(String category) {
		List<ProdVO> getlocalRecProdList = sqlsession.selectList("finalproject4.getlocalRecProdList", category);
		return getlocalRecProdList;
	}
	
	// == category 페이지 categoryName 가져오기 == //
	@Override
	public String getCategoryName(String category) {
		String getCategoryName = sqlsession.selectOne("finalproject4.getCategoryName", category);
		return getCategoryName;
	}

	// == category 페이지 detailCategoryName 가져오기 == //
	@Override
	public List<HashMap<String, String>> getdetailCategoryName(String category) {
		List<HashMap<String, String>> getdetailCategoryName = sqlsession.selectList("finalproject4.getdetailCategoryName", category);
		return getdetailCategoryName;
	}

	@Override
	public int getTotalProdCount(HashMap<String, String> paraMap) {
		int n = sqlsession.selectOne("board.getTotalProdCount", paraMap);
		return n;
	}

	@Override
	public List<ProdVO> prodList(HashMap<String, String> paraMap) {
		List<ProdVO> prodList = sqlsession.selectList("board.prodList", paraMap);
		return prodList;
	}

}
