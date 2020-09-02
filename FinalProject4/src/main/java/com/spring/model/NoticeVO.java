package com.spring.model;

import org.springframework.web.multipart.MultipartFile;

public class NoticeVO {

	private String notice_id;
	private String fk_userid;
	private String no_cate_name;
	private String category;
	private String ticketopenday;
	private String subject;
	private String content;
	private String readCount;
	private String regDate;
	private String status;
	
	private String prod_id;
	private String prod_title;
	private String prod_img;
	
	private String fileName; 		// -- WAS(톰캣)에 저장될 파일명(20200725092715353243254235235234.png)
	private String orgFilename; 	// -- 진짜 파일명(강아지.png)  // 사용자가 파일을 업로드 하거나 파일을 다운로드 할때 사용되어지는 파일명 
	private String fileSize; 		// -- 파일크기  
	// 이 3개는 DB 에 저장되는 파일정보이고, 진짜 파일을 받는 것이 필요하다.
	
	private MultipartFile attach;

	private String previousseq;      // 이전글번호
	private String previoussubject;  // 이전글제목
	private String nextseq;          // 다음글번호
	private String nextsubject;      // 다음글제목	
	
	
	public NoticeVO() {}
	
	public NoticeVO(String notice_id, String fk_userid, String no_cate_name, String category, String ticketopenday,
			String subject, String content, String readCount, String regDate, String status, String prod_id, String prod_title, String prod_img, 
			String fileName, String orgFilename, String fileSize, MultipartFile attach) {
		this.notice_id = notice_id;
		this.fk_userid = fk_userid;
		this.no_cate_name = no_cate_name;
		this.category = category;
		this.ticketopenday = ticketopenday;
		this.subject = subject;
		this.content = content;
		this.readCount = readCount;
		this.regDate = regDate;
		this.status = status;
		this.prod_id = prod_id;
		this.prod_title = prod_title;
		this.prod_img = prod_img;
		this.fileName = fileName;
		this.orgFilename = orgFilename;
		this.fileSize = fileSize;
		this.attach = attach;
	}

	public String getNotice_id() {
		return notice_id;
	}

	public void setNotice_id(String notice_id) {
		this.notice_id = notice_id;
	}

	public String getFk_userid() {
		return fk_userid;
	}

	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}

	public String getNo_cate_name() {
		return no_cate_name;
	}

	public void setNo_cate_name(String no_cate_name) {
		this.no_cate_name = no_cate_name;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getTicketopenday() {
		return ticketopenday;
	}

	public void setTicketopenday(String ticketopenday) {
		this.ticketopenday = ticketopenday;
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

	public String getReadCount() {
		return readCount;
	}

	public void setReadCount(String readCount) {
		this.readCount = readCount;
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

	public String getProd_id() {
		return prod_id;
	}

	public void setProd_id(String prod_id) {
		this.prod_id = prod_id;
	}

	public String getProd_title() {
		return prod_title;
	}

	public void setProd_title(String prod_title) {
		this.prod_title = prod_title;
	}

	public String getProd_img() {
		return prod_img;
	}

	public void setProd_img(String prod_img) {
		this.prod_img = prod_img;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getOrgFilename() {
		return orgFilename;
	}

	public void setOrgFilename(String orgFilename) {
		this.orgFilename = orgFilename;
	}

	public String getFileSize() {
		return fileSize;
	}

	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}

	public MultipartFile getAttach() {
		return attach;
	}

	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}

	public String getPreviousseq() {
		return previousseq;
	}

	public void setPreviousseq(String previousseq) {
		this.previousseq = previousseq;
	}

	public String getPrevioussubject() {
		return previoussubject;
	}

	public void setPrevioussubject(String previoussubject) {
		this.previoussubject = previoussubject;
	}

	public String getNextseq() {
		return nextseq;
	}

	public void setNextseq(String nextseq) {
		this.nextseq = nextseq;
	}

	public String getNextsubject() {
		return nextsubject;
	}

	public void setNextsubject(String nextsubject) {
		this.nextsubject = nextsubject;
	} 
	
	
	
}
