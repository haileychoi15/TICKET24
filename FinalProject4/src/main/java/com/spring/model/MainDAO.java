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
