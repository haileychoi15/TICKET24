package com.spring.model;

import java.util.HashMap;
import java.util.List;

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

	
	// 해당 상품에 달린 리뷰목록 가져오기
	@Override
	public List<ReviewVO> reviewList(HashMap<String, String> paraMap) {
		List<ReviewVO> reviewList = sqlsession.selectList("finalproject4.reviewList", paraMap);
		return reviewList;
	}

	// 해당 상품(parentProdId) 에 해당하는 총 리뷰수 알아오기
	@Override
	public int getReviewTotalCount(HashMap<String, String> paraMap) {
		int n = sqlsession.selectOne("finalproject4.getReviewTotalCount", paraMap);
		return n;
	}

	// 해당 상품(parentProdId) 에 해당하는 평점 알아오기
	@Override
	public double getReviewAvgStar(HashMap<String, String> paraMap) {
		double n = sqlsession.selectOne("finalproject4.getReviewAvgStar", paraMap);
		return n;
	}

	// 리뷰 삭제하기
	@Override
	public int delReview(HashMap<String, String> paraMap) {
		int n = sqlsession.update("finalproject4.delReview", paraMap);
		return n;
	}
	
}
