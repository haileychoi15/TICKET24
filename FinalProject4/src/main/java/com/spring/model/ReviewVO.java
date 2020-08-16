package com.spring.model;


public class ReviewVO {

	private String review_id;  		// 리뷰번호
	private String fk_userid;  	 	// 사용자ID
	private String name;      	   	// 이름
	private String content;     	// 내용
	private String star;			// 별점
	private String regDate;     	// 작성일자
	private String parentProdId;	// 공연정보코드
	private String fk_rev_status;	// 예매여부
	private String fk_rev_date;		// 예매일자
	private String status;       	// 글삭제여부
	
	public ReviewVO() {}
	
	public ReviewVO(String review_id, String fk_userid, String name, String content, String star, String regDate,
			String parentProdId, String fk_rev_status, String fk_rev_date, String status) {
		super();
		this.review_id = review_id;
		this.fk_userid = fk_userid;
		this.name = name;
		this.content = content;
		this.star = star;
		this.regDate = regDate;
		this.parentProdId = parentProdId;
		this.fk_rev_status = fk_rev_status;
		this.fk_rev_date = fk_rev_date;
		this.status = status;
	}

	public String getReview_id() {
		return review_id;
	}

	public void setReview_id(String review_id) {
		this.review_id = review_id;
	}

	public String getFk_userid() {
		return fk_userid;
	}

	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getStar() {
		return star;
	}

	public void setStar(String star) {
		this.star = star;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getParentProdId() {
		return parentProdId;
	}

	public void setParentProdId(String parentProdId) {
		this.parentProdId = parentProdId;
	}

	public String getFk_rev_status() {
		return fk_rev_status;
	}

	public void setFk_rev_status(String fk_rev_status) {
		this.fk_rev_status = fk_rev_status;
	}

	public String getFk_rev_date() {
		return fk_rev_date;
	}

	public void setFk_rev_date(String fk_rev_date) {
		this.fk_rev_date = fk_rev_date;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	
}
