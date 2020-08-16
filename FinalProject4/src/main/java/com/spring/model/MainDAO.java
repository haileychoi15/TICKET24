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
	
	// == category 공연 리스트 ajax - 주간랭킹순 == //
	@Override
	public List<HashMap<String, String>> selectOne(HashMap<String, String> showInfoMap) {
		List<HashMap<String, String>> selectOne = sqlsession.selectList("finalproject4.selectOne", showInfoMap);
		
		
		return selectOne;
	}
	// == category 공연 리스트 ajax - 신상품순 == //
	@Override
	public List<HashMap<String, String>> selectTwo(HashMap<String, String> showInfoMap) {
		List<HashMap<String, String>> selectTwo = sqlsession.selectList("finalproject4.selectTwo", showInfoMap);
		return selectTwo;
	}
	// == category 공연 리스트 ajax - 종료임박순 == //
	@Override
	public List<HashMap<String, String>> selectThree(HashMap<String, String> showInfoMap) {
		List<HashMap<String, String>> selectThree = sqlsession.selectList("finalproject4.selectThree", showInfoMap);
		return selectThree;
	}
	// == category 공연 리스트 ajax - 상품명순 == //
	@Override
	public List<HashMap<String, String>> selectFour(HashMap<String, String> showInfoMap) {
		List<HashMap<String, String>> selectFour = sqlsession.selectList("finalproject4.selectFour", showInfoMap);
		return selectFour;
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

	@Override
	public String getTotalCnt(HashMap<String, String> showInfoMap) {
		String getTotalCnt = sqlsession.selectOne("finalproject4.getTotalCnt", showInfoMap);
		return getTotalCnt;
	}

	// 쿠폰이 존재하는지 확인
	@Override
	public int getCouponIs(HashMap<String, String> couponMap) {
		int n = sqlsession.selectOne("finalproject4.getCouponIs", couponMap);
		return n;
	}


}
