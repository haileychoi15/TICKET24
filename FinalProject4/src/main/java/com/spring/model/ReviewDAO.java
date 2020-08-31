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


	// 리뷰 수정하기
	@Override
	public int editReview(HashMap<String, String> paraMap) {
		int n = sqlsession.update("finalproject4.editReview", paraMap);
		return n;
	}

	// 리뷰 추천하기
	@Override
	public int likeReview(HashMap<String, String> paraMap) {
		int n = sqlsession.insert("finalproject4.likeReview", paraMap);
		return n;
	}

	// 리뷰 추천 취소하기
	@Override
	public int dislikeReview(HashMap<String, String> paraMap) {
		int n = sqlsession.delete("finalproject4.dislikeReview", paraMap);
		return n;
	}


	@Override
	public int existLikeReview(HashMap<String, String> paraMap) {
		int n = sqlsession.selectOne("finalproject4.existLikeReview", paraMap);
		return n;
	}

	// 해당 공연에 대한 추천있는 리뷰와 추천수
	@Override
	public List<String> reviewLikeList(HashMap<String, String> paraMap) {
		List<String> reviewLikeList = sqlsession.selectList("finalproject4.reviewLikeList", paraMap);
		return reviewLikeList;
	}

	// 공연에 달린 리뷰의 추천수 
	@Override
	public List<HashMap<String, String>> reviewLikecntList(HashMap<String, String> paraMap) {
		List<HashMap<String, String>> reviewLikecntList = sqlsession.selectList("finalproject4.reviewLikecntList", paraMap);
		return reviewLikecntList;
	}

	// 리뷰 등록 성공시 포인트 증가(트랜잭션)
	@Override
	public void pointAdd(HashMap<String, String> paraMap) {
		sqlsession.update("finalproject4.pointAdd", paraMap);
		
	}

	// 리뷰 등록 성공시 포인트 테이블에 적립내용 입력(트랜잭션)
	@Override
	public void pointInsertReview(HashMap<String, String> paraMap) {
		sqlsession.insert("finalproject4.pointInsertReview", paraMap);
		
	}

	// 리뷰시퀀스 채번하기
	@Override
	public String selectReviewSeq() {
		String seq = sqlsession.selectOne("finalproject4.selectReviewSeq");
		return seq;
	}

	// 리뷰 삭제 성공시 포인트 회수(트랜잭션)
	@Override
	public void pointRemove(HashMap<String, String> paraMap) {
		sqlsession.update("finalproject4.pointRemove", paraMap);
		
	}

	// 리뷰 삭제 성공시 포인트테이블 내용삭제 (트랜잭션)
	@Override
	public void pointDeleteReview(HashMap<String, String> paraMap) {
		sqlsession.delete("finalproject4.pointDeleteReview", paraMap);
		
	}
	
	
	
}
