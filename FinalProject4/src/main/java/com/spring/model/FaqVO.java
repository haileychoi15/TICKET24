package com.spring.model;

public class FaqVO {

	private String faq_id;
	private String fk_userid;
	private String subject;
	private String content;
	private String regDate;
	private String status;
	private String faq_cate_name;
	
	public FaqVO() {}
	
	public FaqVO(String faq_id, String fk_userid, String subject, String content, String regDate, String status,
			String faq_cate_name) {
		super();
		this.faq_id = faq_id;
		this.fk_userid = fk_userid;
		this.subject = subject;
		this.content = content;
		this.regDate = regDate;
		this.status = status;
		this.faq_cate_name = faq_cate_name;
	}

	public String getFaq_id() {
		return faq_id;
	}

	public void setFaq_id(String faq_id) {
		this.faq_id = faq_id;
	}

	public String getFk_userid() {
		return fk_userid;
	}

	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getFaq_cate_name() {
		return faq_cate_name;
	}

	public void setFaq_cate_name(String faq_cate_name) {
		this.faq_cate_name = faq_cate_name;
	}
	
	
	
	
}
