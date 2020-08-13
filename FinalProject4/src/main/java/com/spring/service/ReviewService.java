package com.spring.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.model.InterReviewDAO;

@Service
public class ReviewService implements InterReviewService {

	@Autowired
	private InterReviewDAO dao;
	
}
