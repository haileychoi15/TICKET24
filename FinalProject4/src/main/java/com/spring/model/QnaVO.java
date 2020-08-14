package com.spring.model;

public class QnaVO {

	private String qna_id;
	private String fk_userid;
	private String name;
	private String category;
	private String qna_cate_name;
	private String subject;
	private String content;
	private String pw;
	private String regDate;
	private String readCount;
	private String secret;
	private String adminread;
	private String adminans;
	private String status;
	private String groupno;
	private String fk_seq;
	private String depthno;
	private String fk_rev_id;
	private String prod_id;
	private String rev_email;
	private String prod_img;
	private String prod_title;
	
	public QnaVO() {}
	
	public QnaVO(String qna_id, String fk_userid, String name, String category, String qna_cate_name, String subject,
			String content, String pw, String regDate, String readCount, String secret, String adminread,
			String adminans, String status, String groupno, String fk_seq, String depthno, String fk_rev_id,
			String prod_id, String rev_email, String prod_img, String prod_title) {
		super();
		this.qna_id = qna_id;
		this.fk_userid = fk_userid;
		this.name = name;
		this.category = category;
		this.qna_cate_name = qna_cate_name;
		this.subject = subject;
		this.content = content;
		this.pw = pw;
		this.regDate = regDate;
		this.readCount = readCount;
		this.secret = secret;
		this.adminread = adminread;
		this.adminans = adminans;
		this.status = status;
		this.groupno = groupno;
		this.fk_seq = fk_seq;
		this.depthno = depthno;
		this.fk_rev_id = fk_rev_id;
		this.prod_id = prod_id;
		this.rev_email = rev_email;
		this.prod_img = prod_img;
		this.prod_title = prod_title;
	}

	public String getQna_id() {
		return qna_id;
	}

	public void setQna_id(String qna_id) {
		this.qna_id = qna_id;
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

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getQna_cate_name() {
		return qna_cate_name;
	}

	public void setQna_cate_name(String qna_cate_name) {
		this.qna_cate_name = qna_cate_name;
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

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getReadCount() {
		return readCount;
	}

	public void setReadCount(String readCount) {
		this.readCount = readCount;
	}

	public String getSecret() {
		return secret;
	}

	public void setSecret(String secret) {
		this.secret = secret;
	}

	public String getAdminread() {
		return adminread;
	}

	public void setAdminread(String adminread) {
		this.adminread = adminread;
	}

	public String getAdminans() {
		return adminans;
	}

	public void setAdminans(String adminans) {
		this.adminans = adminans;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getGroupno() {
		return groupno;
	}

	public void setGroupno(String groupno) {
		this.groupno = groupno;
	}

	public String getFk_seq() {
		return fk_seq;
	}

	public void setFk_seq(String fk_seq) {
		this.fk_seq = fk_seq;
	}

	public String getDepthno() {
		return depthno;
	}

	public void setDepthno(String depthno) {
		this.depthno = depthno;
	}

	public String getFk_rev_id() {
		return fk_rev_id;
	}

	public void setFk_rev_id(String fk_rev_id) {
		this.fk_rev_id = fk_rev_id;
	}

	public String getProd_id() {
		return prod_id;
	}

	public void setProd_id(String prod_id) {
		this.prod_id = prod_id;
	}

	public String getRev_email() {
		return rev_email;
	}

	public void setRev_email(String rev_email) {
		this.rev_email = rev_email;
	}

	public String getProd_img() {
		return prod_img;
	}

	public void setProd_img(String prod_img) {
		this.prod_img = prod_img;
	}

	public String getProd_title() {
		return prod_title;
	}

	public void setProd_title(String prod_title) {
		this.prod_title = prod_title;
	}
	
	
	
	
}
