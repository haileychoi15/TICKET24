package com.spring.model;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class BoardDAO implements InterBoardDAO {
	
	@Resource
	private SqlSessionTemplate sqlsession;

	@Override
	public List<FaqVO> faqList(HashMap<String, String> paraMap) {
		List<FaqVO> faqList = sqlsession.selectList("finalproject4.faqList", paraMap);
		return faqList;
	}
	
	
}
