package com.spring.model;

public class ShowVO {

	private String prod_id;
	private String fk_category_id;
	private String fk_category_detail_id;
	private String prod_title;
	private String prod_img;
	private String prd_detail_img;
	private String info_open_date;
	private String info_close_date;
	private String info_rev_status;
	private String info_grade;
	private String info_run_time;
	private String info_qnty;
	
	public ShowVO() {}
	
	public ShowVO(String prod_id, String fk_category_id, String fk_category_detail_id, String prod_title,
			String prod_img, String prd_detail_img, String info_open_date, String info_close_date,
			String info_rev_status, String info_grade, String info_run_time, String info_qnty) {
		super();
		this.prod_id = prod_id;
		this.fk_category_id = fk_category_id;
		this.fk_category_detail_id = fk_category_detail_id;
		this.prod_title = prod_title;
		this.prod_img = prod_img;
		this.prd_detail_img = prd_detail_img;
		this.info_open_date = info_open_date;
		this.info_close_date = info_close_date;
		this.info_rev_status = info_rev_status;
		this.info_grade = info_grade;
		this.info_run_time = info_run_time;
		this.info_qnty = info_qnty;
	}

	public String getProd_id() {
		return prod_id;
	}

	public void setProd_id(String prod_id) {
		this.prod_id = prod_id;
	}

	public String getFk_category_id() {
		return fk_category_id;
	}

	public void setFk_category_id(String fk_category_id) {
		this.fk_category_id = fk_category_id;
	}

	public String getFk_category_detail_id() {
		return fk_category_detail_id;
	}

	public void setFk_category_detail_id(String fk_category_detail_id) {
		this.fk_category_detail_id = fk_category_detail_id;
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

	public String getPrd_detail_img() {
		return prd_detail_img;
	}

	public void setPrd_detail_img(String prd_detail_img) {
		this.prd_detail_img = prd_detail_img;
	}

	public String getInfo_open_date() {
		return info_open_date;
	}

	public void setInfo_open_date(String info_open_date) {
		this.info_open_date = info_open_date;
	}

	public String getInfo_close_date() {
		return info_close_date;
	}

	public void setInfo_close_date(String info_close_date) {
		this.info_close_date = info_close_date;
	}

	public String getInfo_rev_status() {
		return info_rev_status;
	}

	public void setInfo_rev_status(String info_rev_status) {
		this.info_rev_status = info_rev_status;
	}

	public String getInfo_grade() {
		return info_grade;
	}

	public void setInfo_grade(String info_grade) {
		this.info_grade = info_grade;
	}

	public String getInfo_run_time() {
		return info_run_time;
	}

	public void setInfo_run_time(String info_run_time) {
		this.info_run_time = info_run_time;
	}

	public String getInfo_qnty() {
		return info_qnty;
	}

	public void setInfo_qnty(String info_qnty) {
		this.info_qnty = info_qnty;
	}
	
	
	
}
