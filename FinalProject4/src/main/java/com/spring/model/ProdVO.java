package com.spring.model;

public class ProdVO {

   private String prod_id;             // -- 공연정보코드 (시퀀스)
   private String fk_category_id;         // -- 카테고리코드
   private String category_name;         // -- 카테고리명
   private String fk_category_detail_id;   // -- 세부카테고리코드
   private String prod_title;            // -- 공연명
   private String prod_img;            // -- 대표이미지
   private String prod_detail_img;         // -- 상세이미지
   private String date_start;            // -- 공연시작날짜
   private String date_end;            // -- 공연종료날짜
   private String info_open_date;         // -- 티켓오픈일시
   private String info_close_date;         // -- 티켓마감일시
   private String info_rev_status;         // -- 예매가능상태
   private String info_grade;            // -- 관람등급
   private String info_run_time;         // -- 관람시간
   private String info_qnty;            // -- 판매량
   private String map_address;            // -- 공연장소주소
   private String map_name;            // -- 공연장소명
   private String map_id;               // -- 공연장소코드
   
   
   public ProdVO() {}
   
   public ProdVO(String prod_id, String fk_category_id, String category_name, String fk_category_detail_id,
         String prod_title, String prod_img, String prod_detail_img, String date_start, String date_end,
         String info_open_date, String info_close_date, String info_rev_status, String info_grade,
         String info_run_time, String info_qnty, String map_address, String map_name, String map_id) {
      super();
      this.prod_id = prod_id;
      this.fk_category_id = fk_category_id;
      this.category_name = category_name;
      this.fk_category_detail_id = fk_category_detail_id;
      this.prod_title = prod_title;
      this.prod_img = prod_img;
      this.prod_detail_img = prod_detail_img;
      this.date_start = date_start;
      this.date_end = date_end;
      this.info_open_date = info_open_date;
      this.info_close_date = info_close_date;
      this.info_rev_status = info_rev_status;
      this.info_grade = info_grade;
      this.info_run_time = info_run_time;
      this.info_qnty = info_qnty;
      this.map_address = map_address;
      this.map_name = map_name;
      this.map_id = map_id;
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

   public String getCategory_name() {
      return category_name;
   }

   public void setCategory_name(String category_name) {
      this.category_name = category_name;
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

   public String getProd_detail_img() {
      return prod_detail_img;
   }

   public void setProd_detail_img(String prod_detail_img) {
      this.prod_detail_img = prod_detail_img;
   }

   public String getDate_start() {
      return date_start;
   }

   public void setDate_start(String date_start) {
      this.date_start = date_start;
   }

   public String getDate_end() {
      return date_end;
   }

   public void setDate_end(String date_end) {
      this.date_end = date_end;
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

   public String getMap_address() {
      return map_address;
   }

   public void setMap_address(String map_address) {
      this.map_address = map_address;
   }

   public String getMap_name() {
      return map_name;
   }

   public void setMap_name(String map_name) {
      this.map_name = map_name;
   }

   public String getMap_id() {
      return map_id;
   }

   public void setMap_id(String map_id) {
      this.map_id = map_id;
   }
   
   

   
}