package com.spring.model;

import java.util.HashMap;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository 
public class ReviewDAO implements InterReviewDAO {
	
	@Resource
	private SqlSessionTemplate sqlsession;

	// 리뷰등록하기
	@Override
	public int addReview(HashMap<String, String> paraMap) {
		int n = sqlsession.insert("finalproject4.addReview", paraMap);
		return n;
	}
	
}
