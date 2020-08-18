package com.spring.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.model.InterReviewDAO;
import com.spring.model.ReviewVO;

@Service
public class ReviewService implements InterReviewService {

	@Autowired
	private InterReviewDAO dao;

	
	// 리뷰등록하기
	@Override
	public int addReview(HashMap<String, String> paraMap) {
		int n = dao.addReview(paraMap);
		return n;
	}

	// 해당 상품에 달린 리뷰목록 가져오기
	@Override
	public List<ReviewVO> reviewList(HashMap<String, String> paraMap) {
		List<ReviewVO> reviewList = dao.reviewList(paraMap);
		return reviewList;
	}

	// 해당 상품(parentProdId) 에 해당하는 총 리뷰수 알아오기
	@Override
	public int getReviewTotalCount(HashMap<String, String> paraMap) {
		int n = dao.getReviewTotalCount(paraMap);
		return n;
	}

	// 해당 상품(parentProdId) 에 해당하는 평점 알아오기
	@Override
	public double getReviewAvgStar(HashMap<String, String> paraMap) {
		double n = dao.getReviewAvgStar(paraMap);
		return n;
	}

	// 리뷰 삭제하기
	@Override
	public int delReview(HashMap<String, String> paraMap) {
		int n = dao.delReview(paraMap);
		return n;
	}

	// 리뷰 수정하기
	@Override
	public int editReview(HashMap<String, String> paraMap) {
		int n = dao.editReview(paraMap);
		return n;
	}
	
}
