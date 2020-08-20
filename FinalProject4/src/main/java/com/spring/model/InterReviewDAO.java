package com.spring.model;

import java.util.HashMap;
import java.util.List;

public interface InterReviewDAO {

	int addReview(HashMap<String, String> paraMap); // 리뷰등록하기

	List<ReviewVO> reviewList(HashMap<String, String> paraMap); // 해당 상품에 달린 리뷰목록 가져오기

	int getReviewTotalCount(HashMap<String, String> paraMap); // 해당 상품(parentProdId) 에 해당하는 총 리뷰수 알아오기

	double getReviewAvgStar(HashMap<String, String> paraMap); // 해당 상품(parentProdId) 에 해당하는 평점 알아오기

	int delReview(HashMap<String, String> paraMap); // 리뷰 삭제하기

	int editReview(HashMap<String, String> paraMap); // 리뷰 수정하기

	int likeReview(HashMap<String, String> paraMap); // 리뷰 추천하기

	int dislikeReview(HashMap<String, String> paraMap); // 리뷰 추천 취소하기

	int existLikeReview(HashMap<String, String> paraMap);

}
