package com.spring.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.model.InterReviewDAO;

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
	
}
