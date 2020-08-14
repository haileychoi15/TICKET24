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
