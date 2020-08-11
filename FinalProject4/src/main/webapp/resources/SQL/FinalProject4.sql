--- **** FinalProject Team 4 - YES 24 **** ----

--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------- sys 에서 작업 ---------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
---- *** FinalProject *** ----
create user finalproject4 identified by eclass
default tablespace users;

grant connect, resource, unlimited tablespace to finalproject4;
grant create view to finalproject4;

-- 현재 오라클 서버에 존재하는 모든 오라클 계정을 조회해본다.
select *
from dba_users;

-- 계정 삭제 drop user finalproject cascade;

grant create session to finalproject4;
grant create table to finalproject4;
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

show user;
-- USER이(가) "FINALPROJECT4"입니다.

----------------------------------- 제약조건 -----------------------------------
-- 제약조건 조회
select * from all_constraints where table_name = '테이블명';

-- 제약조건 삭제
alter table yes_show_map drop constraint FK_PROD_ID cascade;

----------------------------------- 회원 테이블 - User -----------------------------------
-- 회원 테이블
drop table yes_member cascade constraints;
create table yes_member
(idx                number(10)     not null       -- 회원번호(시퀀스로 데이터가 들어온다)
,userid             varchar2(20)   not null       -- 회원아이디
,name               varchar2(30)   not null       -- 회원명
,pwd                varchar2(200)  default '0'    -- 비밀번호 (SHA-256 암호화 대상)
,email              varchar2(200)  not null       -- 이메일   (AES-256 암호화/복호화 대상)
,hp1                varchar2(3)                   -- 연락처
,hp2                varchar2(200)                 --         (AES-256 암호화/복호화 대상) 
,hp3                varchar2(200)                 --         (AES-256 암호화/복호화 대상)
,postcode           varchar2(5)                   -- 우편번호
,address            varchar2(200)                 -- 주소
,detailaddress      varchar2(200)                 -- 상세주소
,extraaddress       varchar2(200)                 -- 참고항목
,gender             varchar2(3)                   -- 성별     남자 : 1 / 여자 : 2
,birthday           varchar2(8)                   -- 생년월일 
,coin               number default 0              -- 코인액
,point              number default 0              -- 포인트 
,registerday        date default sysdate          -- 가입일자
,status             number(1) default 1           -- 회원탈퇴유무   1:사용가능(가입중) / 0:사용불능(탈퇴) 
,lastLoginDate      date default sysdate          -- 마지막으로 로그인 한 날짜시간 기록용
,lastPwdChangeDate  date default sysdate          -- 마지막으로 암호를 변경한 날짜시간 기록용
,clientip           varchar2(20)                  -- 클라이언트의 IP 주소
,kakaoStatus        varchar2(1) default '0'       -- 카카오 로그인 유무
,naverStatus        varchar2(1) default '0'       -- 네이버 로그인 유무
,constraint   PK_final_member_test_idx primary key(idx)
,constraint   UQ_final_member__test_userid unique(userid)
,constraint   CK_final_member_test_gender check( gender in('1','2') ) 
,constraint   CK_final_member_test_status check( status in('0','1') ) 
,constraint   CK_final_member_test_kakao check( status in('0','1') ) 
);

drop sequence seq_member;
create sequence seq_member
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

insert into yes_member(idx, userid, name, pwd, email, hp1, hp2, hp3, postcode, address, detailAddress, extraAddress, gender, birthday, coin, point, registerday, status, lastlogindate, lastpwdchangedate, clientip, kakaoStatus, naverStatus) 
values(seq_member.nextval, 'kimjy', '김진영', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', 'KaDz2RcfIWg51HF/fFWvOxLoX5Y6H9S5+AmisF8ovv0=' , '010', '5vlo5ZBnIbLMyMz3NtK38A==', 'TYENQOsy0AExa9/mtma0ow==', '50234', '서울 송파구 오금로 95', '337동 708호', '오금동 현대아파트', '1', '19960920', default, default, default, default, default, default, '127.0.0.1', '1', default);

insert into yes_member(idx, userid, name, pwd, email, hp1, hp2, hp3, postcode, address, detailAddress, extraAddress, gender, birthday, coin, point, registerday, status, lastlogindate, lastpwdchangedate, clientip, kakaoStatus, naverStatus) 
values(seq_member.nextval, 'admin', '관리자', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', 'KaDz2RcfIWg51HF/fFWvOxLoX5Y6H9S5+AmisF8ovv0=' , '010', '5vlo5ZBnIbLMyMz3NtK38A==', 'TYENQOsy0AExa9/mtma0ow==', '50234', '서울 송파구 오금로 95', '337동 708호', '오금동 현대아파트', '1', '19960920', default, default, default, default, default, default, '127.0.0.1', '1', default);

commit;

-- 로그인 테이블 삭제
drop table yes_login cascade constraints;

-- 로그인 테이블 생성
create table yes_login
(login_idx                number(10)     not null       -- 회원번호(시퀀스로 데이터가 들어온다)
,userid             varchar2(20)   not null       -- 회원아이디
,name               varchar2(30)   not null       -- 회원명
,pwd                varchar2(200)  default '0'    -- 비밀번호 (SHA-256 암호화 대상)
);



----------------------------------- 공연 테이블 - Show -----------------------------------
-- 카테고리 테이블
drop table yes_show_category cascade constraints purge;
create table yes_show_category
(category_id    number(10)      not null    -- 카테고리 코드
,category_name  varchar2(20)    not null    -- 카테고리 명
,constraint PK_category_id primary key (category_id)
);

drop sequence seq_show_category;
create sequence seq_show_category
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

insert into yes_show_category(category_id, category_name)
values(1,'클래식');
insert into yes_show_category(category_id, category_name)
values(2,'콘서트');
insert into yes_show_category(category_id, category_name)
values(3,'뮤지컬');
insert into yes_show_category(category_id, category_name)
values(4,'연극');
insert into yes_show_category(category_id, category_name)
values(5,'전시');
insert into yes_show_category(category_id, category_name)
values(6,'아동');
commit;


select * 
from yes_show_category;

select *
from yes_show_category_detail;

-- 세부 카테고리 테이블
drop table yes_show_category_detail cascade constraints purge;
create table yes_show_category_detail
(category_detail_id     number(10)  not null    -- 세부 카테고리 코드
,category_id            number(10)  not null    -- 카테고리 코드(FK)
,category_detail_name   varchar2(20)  not null    -- 세부카테고리명
,constraint PK_category_detail_id primary key (category_detail_id)
,constraint FK_category_id foreign key(category_id) references yes_show_category(category_id) on delete cascade
);

drop sequence seq_show_category_detail;
create sequence seq_show_category_detail
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

insert into yes_show_category_detail(category_detail_id, category_id, category_detail_name)
values(seq_show_category_detail.nextval, 1, '전체보기');
insert into yes_show_category_detail(category_detail_id, category_id, category_detail_name)
values(seq_show_category_detail.nextval, 1, '클래식');
insert into yes_show_category_detail(category_detail_id, category_id, category_detail_name)
values(seq_show_category_detail.nextval, 1, '발레/무용');
insert into yes_show_category_detail(category_detail_id, category_id, category_detail_name)
values(seq_show_category_detail.nextval, 1, '국악');

insert into yes_show_category_detail(category_detail_id, category_id, category_detail_name)
values(seq_show_category_detail.nextval, 2, '전체보기');
insert into yes_show_category_detail(category_detail_id, category_id, category_detail_name)
values(seq_show_category_detail.nextval, 2, '국내뮤지션');
insert into yes_show_category_detail(category_detail_id, category_id, category_detail_name)
values(seq_show_category_detail.nextval, 2, '해외뮤지션');
insert into yes_show_category_detail(category_detail_id, category_id, category_detail_name)
values(seq_show_category_detail.nextval, 2, '페스티벌');

insert into yes_show_category_detail(category_detail_id, category_id, category_detail_name)
values(seq_show_category_detail.nextval, 3, '전체보기');
insert into yes_show_category_detail(category_detail_id, category_id, category_detail_name)
values(seq_show_category_detail.nextval, 3, '라이선스');
insert into yes_show_category_detail(category_detail_id, category_id, category_detail_name)
values(seq_show_category_detail.nextval, 3, '오리지널');
insert into yes_show_category_detail(category_detail_id, category_id, category_detail_name)
values(seq_show_category_detail.nextval, 3, '창작');
insert into yes_show_category_detail(category_detail_id, category_id, category_detail_name)
values(seq_show_category_detail.nextval, 3, '넌버벌퍼포먼스');

insert into yes_show_category_detail(category_detail_id, category_id, category_detail_name)
values(seq_show_category_detail.nextval, 4, '전체보기');
insert into yes_show_category_detail(category_detail_id, category_id, category_detail_name)
values(seq_show_category_detail.nextval, 4, '대학로');
insert into yes_show_category_detail(category_detail_id, category_id, category_detail_name)
values(seq_show_category_detail.nextval, 4, '기타지역');

insert into yes_show_category_detail(category_detail_id, category_id, category_detail_name)
values(seq_show_category_detail.nextval, 5, '전체보기');
insert into yes_show_category_detail(category_detail_id, category_id, category_detail_name)
values(seq_show_category_detail.nextval, 5, '전시');
insert into yes_show_category_detail(category_detail_id, category_id, category_detail_name)
values(seq_show_category_detail.nextval, 5, '체험/행사');
insert into yes_show_category_detail(category_detail_id, category_id, category_detail_name)
values(seq_show_category_detail.nextval, 5, '워터파크/스파');

insert into yes_show_category_detail(category_detail_id, category_id, category_detail_name)
values(seq_show_category_detail.nextval, 6, '전체보기');
insert into yes_show_category_detail(category_detail_id, category_id, category_detail_name)
values(seq_show_category_detail.nextval, 6, '뮤지컬');
insert into yes_show_category_detail(category_detail_id, category_id, category_detail_name)
values(seq_show_category_detail.nextval, 6, '연극');
insert into yes_show_category_detail(category_detail_id, category_id, category_detail_name)
values(seq_show_category_detail.nextval, 6, '기타');

commit;


-- 공연 테이블
drop table prod cascade constraints purge;
create table prod
(prod_id                number           -- 공연정보코드
,fk_category_id         number           -- 카테고리코드
,fk_category_detail_id  number           -- 세부카테고리코드
,prod_title             varchar2(100)    -- 공연명
,prod_img               varchar2(100)    -- 대표이미지
,prod_detail_img        varchar2(100)    -- 상세이미지
,date_start             date             -- 공연시작날짜
,date_end               date             -- 공연종료날짜
,info_open_date         date             -- 티켓오픈일시
,info_close_date        date             -- 티켓마감일시
,info_rev_status        number           -- 예매가능상태
,info_grade             varchar2(50)     -- 관람등급
,info_run_time          varchar2(10)     -- 관람시간
,info_qnty              number default 0 -- 판매량
,constraint PK_prod_id primary key (prod_id)
--,constraint FK_category_id foreign key(fk_category_id) references category(category_id)
--,constraint FK_info_close_date foreign key(date)
);

drop sequence seq_show;
create sequence seq_show
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

select prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty
from prod
where prod_id = '1';

select prod_id, C.category_name, fk_category_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty
from prod P join  yes_show_category C
on P. fk_category_id = C.category_id;
-- 공연 테이블 임시

insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(1,1,101,'썸머클래식 Summer Classics','FinalProject4/src/main/webapp/resources/images/classic/classic_01m.jpg','FinalProject4/src/main/webapp/resources/images/classic/classic_01L.jpg',to_date('2020/06/01','yyyy/mm/dd'),to_date('2020/09/01','yyyy/mm/dd'),1,'12세 이상','100분',default);
--세종문화회관 M씨어터
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(2,1,102,'피들스 스트링 앙상블','FinalProject4/src/main/webapp/resources/images/classic/classic_02m.jpg','FinalProject4/src/main/webapp/resources/images/classic/classic_02L.jpg',to_date('2020/08/01','yyyy/mm/dd'),to_date('2020/08/01','yyyy/mm/dd'),1,'7세 이상','75분',default);
--광림아트센터 장천홀
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(3,1,103,'2020 교향악축제','FinalProject4/src/main/webapp/resources/images/classic/classic_03m.jpg','FinalProject4/src/main/webapp/resources/images/classic/classic_03L.jpg',to_date('2020/08/09','yyyy/mm/dd'),to_date('2020/08/09','yyyy/mm/dd'),1,'8세 이상','120분',default);
--예술의전당 콘서트홀
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(4,1,104,'어니스트 필하모닉 오케스트라 제1회 정기연주회','FinalProject4/src/main/webapp/resources/images/classic/classic_04m.jpg','FinalProject4/src/main/webapp/resources/images/classic/classic_04L.jpg',to_date('2020/08/08','yyyy/mm/dd'),to_date('2020/08/08','yyyy/mm/dd'),1,'8세 이상','95분',default);
--광림아트센터 장천홀
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(5,1,105,'오르간 오딧세이','FinalProject4/src/main/webapp/resources/images/classic/classic_05m.jpg','FinalProject4/src/main/webapp/resources/images/classic/classic_05L.jpg',to_date('2020/07/28','yyyy/mm/dd'),to_date('2020/12/22','yyyy/mm/dd'),1,'6세 이상','70분',default);
--롯데 콘서트홀
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(6,1,106,'57회 정기공연 <토스카>','FinalProject4/src/main/webapp/resources/images/classic/classic_06m.jpg','FinalProject4/src/main/webapp/resources/images/classic/classic_06L.jpg',to_date('2020/11/11','yyyy/mm/dd'),to_date('2020/11/15','yyyy/mm/dd'),1,'7세 이상','70분',default);
--세종문화회관 대극장
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(7,1,107,'레드 슈즈','FinalProject4/src/main/webapp/resources/images/classic/classic_07m.jpg','FinalProject4/src/main/webapp/resources/images/classic/classic_07L.jpg',to_date('2020/09/04','yyyy/mm/dd'),to_date('2020/09/05','yyyy/mm/dd'),1,'8세 이상','120분',default);
--예술의전당 CJ토월극장
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(8,1,108,'서울시오페라단 2020 <세비야의 이발사>','FinalProject4/src/main/webapp/resources/images/classic/classic_08m.jpg','FinalProject4/src/main/webapp/resources/images/classic/classic_08L.jpg',to_date('2020/08/18','yyyy/mm/dd'),to_date('2020/08/22','yyyy/mm/dd'),1,'5세 이상','150분',default);
--세종문화회관 M씨어터
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(9,1,109,'토요일 오후의 클래식','FinalProject4/src/main/webapp/resources/images/classic/classic_09m.jpg','FinalProject4/src/main/webapp/resources/images/classic/classic_09L.jpg',to_date('2020/01/04','yyyy/mm/dd'),to_date('2020/12/19','yyyy/mm/dd'),1,'성인','120분',default);
--kt chamberhall
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(10,1,110,'파이낸셜뉴스 창간 20주년 기념 음악회','FinalProject4/src/main/webapp/resources/images/classic/classic_10m.jpg','FinalProject4/src/main/webapp/resources/images/classic/classic_10L.jpg',to_date('2020/07/31','yyyy/mm/dd'),to_date('2020/07/31','yyyy/mm/dd'),1,'7세 이상','120분',default);
--롯데 콘서트홀
commit;

insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(11,1,201,'가을방학 정규 4집 발매 기념 공연[세상은 한 장의 손수건]','FinalProject4/src/main/webapp/resources/images/concert/concert_01m.jpg','FinalProject4/src/main/webapp/resources/images/concert/concert_01L.jpg',to_date('2020/06/01','yyyy/mm/dd'),to_date('2020/09/01','yyyy/mm/dd'),1,'12세 이상','100분',default);
--노들섬 라이브 하우스
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(12,2,202,'2020 WILD KARD IN SEOUL','FinalProject4/src/main/webapp/resources/images/concert/concert_02m.jpg','FinalProject4/src/main/webapp/resources/images/concert/concert_02L.jpg',to_date('2020/08/01','yyyy/mm/dd'),to_date('2020/08/01','yyyy/mm/dd'),1,'7세 이상','75분',default);
--노들섬 라이브 하우스
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(13,2,203,'2020 DMZPOP DRIVE IN CONECERT in CHOELWON','FinalProject4/src/main/webapp/resources/images/concert/concert_03m.jpg','FinalProject4/src/main/webapp/resources/images/concert/concert_03L.jpg',to_date('2020/08/09','yyyy/mm/dd'),to_date('2020/08/09','yyyy/mm/dd'),1,'8세 이상','120분',default);
--김화생활체육공원 특설무대
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(14,2,204,'SURL concert <Ah, ah, What can I do?>','FinalProject4/src/main/webapp/resources/images/concert/concert_04m.jpg','FinalProject4/src/main/webapp/resources/images/concert/concert_04L.jpg',to_date('2020/08/08','yyyy/mm/dd'),to_date('2020/08/08','yyyy/mm/dd'),1,'8세 이상','95분',default);
--노들섬 라이브 하우스
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(15,2,205,'팬텀싱어3 콘서트','FinalProject4/src/main/webapp/resources/images/concert/concert_05m.jpg','FinalProject4/src/main/webapp/resources/images/concert/concert_05L.jpg',to_date('2020/07/28','yyyy/mm/dd'),to_date('2020/12/22','yyyy/mm/dd'),1,'6세 이상','70분',default);
--부산 벡스코 제1전시장 1홀
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(16,2,206,'그랜드 민트 페스티벌2020<공식티켓>','FinalProject4/src/main/webapp/resources/images/concert/concert_06m.jpg','FinalProject4/src/main/webapp/resources/images/concert/concert_06L.jpg',to_date('2020/11/11','yyyy/mm/dd'),to_date('2020/11/15','yyyy/mm/dd'),1,'7세 이상','70분',default);
--세종문화회관 대극장
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(17,2,207,'팬타스틱 팬미팅 콘서트','FinalProject4/src/main/webapp/resources/images/concert/concert_07m.jpg','FinalProject4/src/main/webapp/resources/images/concert/concert_07L.jpg',to_date('2020/09/04','yyyy/mm/dd'),to_date('2020/09/05','yyyy/mm/dd'),1,'8세 이상','120분',default);
--노들섬 라이브 하우스
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(18,2,208,'포레스텔라 콘서트 <넬라판타지아>','FinalProject4/src/main/webapp/resources/images/concert/concert_08m.jpg','FinalProject4/src/main/webapp/resources/images/concert/concert_08L.jpg',to_date('2020/08/18','yyyy/mm/dd'),to_date('2020/08/22','yyyy/mm/dd'),1,'5세 이상','150분',default);
--세종문화회관 M씨어터
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(19,2,209,'엔니오 모리꼬네 시네콘서트','FinalProject4/src/main/webapp/resources/images/concert/concert_09m.jpg','FinalProject4/src/main/webapp/resources/images/concert/concert_09L.jpg',to_date('2020/01/04','yyyy/mm/dd'),to_date('2020/12/19','yyyy/mm/dd'),1,'성인','120분',default);
--예술의전당 오페라극장
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(20,2,210,'그린플러그드 경주 2020','FinalProject4/src/main/webapp/resources/images/concert/concert_10m.jpg','FinalProject4/src/main/webapp/resources/images/concert/concert_10L.jpg',to_date('2020/07/31','yyyy/mm/dd'),to_date('2020/07/31','yyyy/mm/dd'),1,'7세 이상','120분',default);
--롯데 콘서트홀
commit;

insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(21,3,301,'뮤지컬 [라 루미에르]','FinalProject4/src/main/webapp/resources/images/musical/musical_01m.jpg','FinalProject4/src/main/webapp/resources/images/musical/musical_01L.jpg',to_date('2020/06/01','yyyy/mm/dd'),to_date('2020/09/01','yyyy/mm/dd'),1,'12세 이상','100분',default);
--대학로 유니플렉스 2관
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(22,3,302,'뮤지컬 <머더발라드>','FinalProject4/src/main/webapp/resources/images/musical/musical_02m.jpg','FinalProject4/src/main/webapp/resources/images/musical/musical_02L.jpg',to_date('2020/08/01','yyyy/mm/dd'),to_date('2020/08/01','yyyy/mm/dd'),1,'7세 이상','75분',default);
--세종문화회관 S씨어터
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(23,3,303,'뮤지컬<더 모먼트>','FinalProject4/src/main/webapp/resources/images/musical/musical_03m.jpg','FinalProject4/src/main/webapp/resources/images/musical/musical_03L.jpg',to_date('2020/08/09','yyyy/mm/dd'),to_date('2020/08/09','yyyy/mm/dd'),1,'8세 이상','120분',default);
--대학로 유니플렉스 2관
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(24,3,304,'뮤지컬<베르테르>','FinalProject4/src/main/webapp/resources/images/musical/musical_04m.jpg','FinalProject4/src/main/webapp/resources/images/musical/musical_04L.jpg',to_date('2020/08/08','yyyy/mm/dd'),to_date('2020/08/08','yyyy/mm/dd'),1,'8세 이상','95분',default);
--광림아트센터 BBCH홀
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(25,3,305,'뮤지컬<캣츠> 40주년 내한공연 - 서울','FinalProject4/src/main/webapp/resources/images/musical/musical_05m.jpg','FinalProject4/src/main/webapp/resources/images/musical/musical_05L.jpg',to_date('2020/07/28','yyyy/mm/dd'),to_date('2020/12/22','yyyy/mm/dd'),1,'6세 이상','70분',default);
--샤롯데 씨어터
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(26,3,306,'뮤지컬 <오페라의 유령> 월드투어','FinalProject4/src/main/webapp/resources/images/musical/musical_06m.jpg','FinalProject4/src/main/webapp/resources/images/musical/musical_06L.jpg',to_date('2020/11/11','yyyy/mm/dd'),to_date('2020/11/15','yyyy/mm/dd'),1,'7세 이상','70분',default);
--블루스퀘어 인터파크홀
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(27,3,307,'뮤지컬 <어쩌면 해피엔딩> 2020','FinalProject4/src/main/webapp/resources/images/musical/musical_07m.jpg','FinalProject4/src/main/webapp/resources/images/musical/musical_07L.jpg',to_date('2020/09/04','yyyy/mm/dd'),to_date('2020/09/05','yyyy/mm/dd'),1,'8세 이상','120분',default);
--예스24스테이지 1관
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(28,3,308,'뮤지컬 펀홈(FUN HOME)','FinalProject4/src/main/webapp/resources/images/musical/musical_08m.jpg','FinalProject4/src/main/webapp/resources/images/musical/musical_08L.jpg',to_date('2020/08/18','yyyy/mm/dd'),to_date('2020/08/22','yyyy/mm/dd'),1,'5세 이상','150분',default);
--동국대학교 이해랑 예술극장
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(29,3,309,'Musical 유앤잇 <YOU & IT>','FinalProject4/src/main/webapp/resources/images/musical/musical_09m.jpg','FinalProject4/src/main/webapp/resources/images/musical/musical_09L.jpg',to_date('2020/01/04','yyyy/mm/dd'),to_date('2020/12/19','yyyy/mm/dd'),1,'성인','120분',default);
--대학로 드림아트센터 2관
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(30,3,310,'뮤지컬 <브로드웨이42번가>','FinalProject4/src/main/webapp/resources/images/musical/musical_10m.jpg','FinalProject4/src/main/webapp/resources/images/musical/musical_10L.jpg',to_date('2020/07/31','yyyy/mm/dd'),to_date('2020/07/31','yyyy/mm/dd'),1,'7세 이상','120분',default);
--부산 소향씨어터 신한카드홀
commit;

insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(31,4,401,'연극 [라스트 세션] Last Session','FinalProject4/src/main/webapp/resources/images/theater/theater_01m.jpg','FinalProject4/src/main/webapp/resources/images/theater/theater_01L.jpg',to_date('2020/06/01','yyyy/mm/dd'),to_date('2020/09/01','yyyy/mm/dd'),1,'12세 이상','100분',default);
--예스24스테이지 3관
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(32,4,402,'2020 밀양공연예술축제 [한 여름 밤의 꿈]','FinalProject4/src/main/webapp/resources/images/theater/theater_02m.jpg','FinalProject4/src/main/webapp/resources/images/theater/theater_02L.jpg',to_date('2020/08/01','yyyy/mm/dd'),to_date('2020/08/01','yyyy/mm/dd'),1,'7세 이상','75분',default);
--밀양아리랑아트센터 대극장
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(33,4,403,'연극 [연애하기좋은날]','FinalProject4/src/main/webapp/resources/images/theater/theater_03m.jpg','FinalProject4/src/main/webapp/resources/images/theater/theater_03L.jpg',to_date('2020/08/09','yyyy/mm/dd'),to_date('2020/08/09','yyyy/mm/dd'),1,'8세 이상','120분',default);
--BNK부산은행 조은극장 1관
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(34,4,404,'레미제라블','FinalProject4/src/main/webapp/resources/images/theater/theater_04m.jpg','FinalProject4/src/main/webapp/resources/images/theater/theater_04L.jpg',to_date('2020/08/08','yyyy/mm/dd'),to_date('2020/08/08','yyyy/mm/dd'),1,'8세 이상','95분',default);
--예술의전당 CJ 토월극장
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(35,4,405,'세종시문화재단 2020 공연장상주 단체 페스티벌','FinalProject4/src/main/webapp/resources/images/theater/theater_05m.jpg','FinalProject4/src/main/webapp/resources/images/theater/theater_05L.jpg',to_date('2020/07/28','yyyy/mm/dd'),to_date('2020/12/22','yyyy/mm/dd'),1,'6세 이상','70분',default);
--세종시문화예술회관
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(36,4,406,'2020 대한민국소극장 열전연극[인간의 무늬]','FinalProject4/src/main/webapp/resources/images/theater/theater_06m.jpg','FinalProject4/src/main/webapp/resources/images/theater/theater_06L.jpg',to_date('2020/11/11','yyyy/mm/dd'),to_date('2020/11/15','yyyy/mm/dd'),1,'7세 이상','70분',default);
--구미 소극장[공터_다]
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(37,4,407,'연극 [미래의 여름]','FinalProject4/src/main/webapp/resources/images/theater/theater_07m.jpg','FinalProject4/src/main/webapp/resources/images/theater/theater_07L.jpg',to_date('2020/09/04','yyyy/mm/dd'),to_date('2020/09/05','yyyy/mm/dd'),1,'8세 이상','120분',default);
--대학로 나온씨어터
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(38,4,408,'연극 [미스터얼간이]','FinalProject4/src/main/webapp/resources/images/theater/theater_08m.jpg','FinalProject4/src/main/webapp/resources/images/theater/theater_08L.jpg',to_date('2020/08/18','yyyy/mm/dd'),to_date('2020/08/22','yyyy/mm/dd'),1,'5세 이상','150분',default);
--BNK부산은행조은극장 2관
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(39,4,409,'나의 PS 파트너','FinalProject4/src/main/webapp/resources/images/theater/theater_09m.jpg','FinalProject4/src/main/webapp/resources/images/theater/theater_09L.jpg',to_date('2020/01/04','yyyy/mm/dd'),to_date('2020/12/19','yyyy/mm/dd'),1,'성인','120분',default);
--대구 여우별아트홀
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(40,4,410,'코믹추리극 행오버 - 해피씨어터','FinalProject4/src/main/webapp/resources/images/theater/theater_10m.jpg','FinalProject4/src/main/webapp/resources/images/theater/theater_10L.jpg',to_date('2020/07/31','yyyy/mm/dd'),to_date('2020/07/31','yyyy/mm/dd'),1,'7세 이상','120분',default);
--대학로 해피씨어터
commit;

insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(41,5,501,'완전한세상','FinalProject4/src/main/webapp/resources/images/exhibition/exhibition_01m.jpg','FinalProject4/src/main/webapp/resources/images/exhibition/exhibition_01L.jpg',to_date('2020/06/01','yyyy/mm/dd'),to_date('2020/09/01','yyyy/mm/dd'),1,'12세 이상','100분',default);
--뮤지엄 다
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(42,5,502,'[세종/전시] 브릭라이브 전시 체험','FinalProject4/src/main/webapp/resources/images/exhibition/exhibition_02m.jpg','FinalProject4/src/main/webapp/resources/images/exhibition/exhibition_02L.jpg',to_date('2020/08/01','yyyy/mm/dd'),to_date('2020/08/01','yyyy/mm/dd'),1,'7세 이상','75분',default);
--밀양아리랑아트센터 대극장
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(43,5,503,'암흑카페 1인 이용권','FinalProject4/src/main/webapp/resources/images/exhibition/exhibition_03m.jpg','FinalProject4/src/main/webapp/resources/images/exhibition/exhibition_03L.jpg',to_date('2020/08/09','yyyy/mm/dd'),to_date('2020/08/09','yyyy/mm/dd'),1,'8세 이상','120분',default);
--신촌 암흑카페
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(44,5,504,'양양 쏠비치 서핑스쿨 이용권','FinalProject4/src/main/webapp/resources/images/exhibition/exhibition_04m.jpg','FinalProject4/src/main/webapp/resources/images/exhibition/exhibition_04L.jpg',to_date('2020/08/08','yyyy/mm/dd'),to_date('2020/08/08','yyyy/mm/dd'),1,'8세 이상','95분',default);
--양양 쏠비치 아쿠아월드
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(45,5,505,'더에천 두번째 에피소드 삼강명탐정:죽은자들의 원혼','FinalProject4/src/main/webapp/resources/images/exhibition/exhibition_05m.jpg','FinalProject4/src/main/webapp/resources/images/exhibition/exhibition_05L.jpg',to_date('2020/07/28','yyyy/mm/dd'),to_date('2020/12/22','yyyy/mm/dd'),1,'6세 이상','70분',default);
--예천 삼강문화단지 내
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(46,5,506,'2020 경기전 왕과의 산책','FinalProject4/src/main/webapp/resources/images/exhibition/exhibition_06m.jpg','FinalProject4/src/main/webapp/resources/images/exhibition/exhibition_06L.jpg',to_date('2020/11/11','yyyy/mm/dd'),to_date('2020/11/15','yyyy/mm/dd'),1,'7세 이상','70분',default);
--전주학옥마을 경기전
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(47,5,507,'거제오션어드벤처','FinalProject4/src/main/webapp/resources/images/exhibition/exhibition_07m.jpg','FinalProject4/src/main/webapp/resources/images/exhibition/exhibition_07L.jpg',to_date('2020/09/04','yyyy/mm/dd'),to_date('2020/09/05','yyyy/mm/dd'),1,'8세 이상','120분',default);
--거제오션어드벤처
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(48,5,508,'경복궁의 인문학산책','FinalProject4/src/main/webapp/resources/images/exhibition/exhibition_08m.jpg','FinalProject4/src/main/webapp/resources/images/exhibition/exhibition_08L.jpg',to_date('2020/08/18','yyyy/mm/dd'),to_date('2020/08/22','yyyy/mm/dd'),1,'5세 이상','150분',default);
--경복궁
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(49,5,509,'경주대명아쿠아월드','FinalProject4/src/main/webapp/resources/images/exhibition/exhibition_09m.jpg','FinalProject4/src/main/webapp/resources/images/exhibition/exhibition_09L.jpg',to_date('2020/01/04','yyyy/mm/dd'),to_date('2020/12/19','yyyy/mm/dd'),1,'8세 이상','120분',default);
--경주대명아쿠아월드
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(50,5,510,'국가대표궁궐,경복궁','FinalProject4/src/main/webapp/resources/images/exhibition/exhibition_10m.jpg','FinalProject4/src/main/webapp/resources/images/exhibition/exhibition_10L.jpg',to_date('2020/07/31','yyyy/mm/dd'),to_date('2020/07/31','yyyy/mm/dd'),1,'7세 이상','120분',default);
--경복궁
commit;

insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(51,6,601,'완전한세상','FinalProject4/src/main/webapp/resources/images/theater/theater_01m.jpg','FinalProject4/src/main/webapp/resources/images/theater/theater_01L.jpg',to_date('2020/06/01','yyyy/mm/dd'),to_date('2020/09/01','yyyy/mm/dd'),1,'12세 이상','100분',default);
--뮤지엄 다
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(52,6,602,'[세종/전시] 브릭라이브 전시 체험','FinalProject4/src/main/webapp/resources/images/theater/theater_02m.jpg','FinalProject4/src/main/webapp/resources/images/theater/theater_02L.jpg',to_date('2020/08/01','yyyy/mm/dd'),to_date('2020/08/01','yyyy/mm/dd'),1,'7세 이상','75분',default);
--밀양아리랑아트센터 대극장
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(53,6,603,'암흑카페 1인 이용권','FinalProject4/src/main/webapp/resources/images/theater/theater_03m.jpg','FinalProject4/src/main/webapp/resources/images/theater/theater_03L.jpg',to_date('2020/08/09','yyyy/mm/dd'),to_date('2020/08/09','yyyy/mm/dd'),1,'8세 이상','120분',default);
--신촌 암흑카페
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(54,6,604,'양양 쏠비치 서핑스쿨 이용권','FinalProject4/src/main/webapp/resources/images/theater/theater_04m.jpg','FinalProject4/src/main/webapp/resources/images/theater/theater_04L.jpg',to_date('2020/08/08','yyyy/mm/dd'),to_date('2020/08/08','yyyy/mm/dd'),1,'8세 이상','95분',default);
--양양 쏠비치 아쿠아월드
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(55,6,605,'더에천 두번째 에피소드 삼강명탐정:죽은자들의 원혼','FinalProject4/src/main/webapp/resources/images/theater/theater_05m.jpg','FinalProject4/src/main/webapp/resources/images/theater/theater_05L.jpg',to_date('2020/07/28','yyyy/mm/dd'),to_date('2020/12/22','yyyy/mm/dd'),1,'6세 이상','70분',default);
--예천 삼강문화단지 내
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(56,6,606,'2020 경기전 왕과의 산책','FinalProject4/src/main/webapp/resources/images/theater/theater_06m.jpg','FinalProject4/src/main/webapp/resources/images/theater/theater_06L.jpg',to_date('2020/11/11','yyyy/mm/dd'),to_date('2020/11/15','yyyy/mm/dd'),1,'7세 이상','70분',default);
--전주한옥마을 경기전
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(57,6,607,'거제오션어드벤처','FinalProject4/src/main/webapp/resources/images/theater/theater_07m.jpg','FinalProject4/src/main/webapp/resources/images/theater/theater_07L.jpg',to_date('2020/09/04','yyyy/mm/dd'),to_date('2020/09/05','yyyy/mm/dd'),1,'8세 이상','120분',default);
--거제오션어드벤처
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(58,6,608,'경복궁의 인문학산책','FinalProject4/src/main/webapp/resources/images/theater/theater_08m.jpg','FinalProject4/src/main/webapp/resources/images/theater/theater_08L.jpg',to_date('2020/08/18','yyyy/mm/dd'),to_date('2020/08/22','yyyy/mm/dd'),1,'5세 이상','150분',default);
--경복궁
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(59,6,609,'경주대명아쿠아월드','FinalProject4/src/main/webapp/resources/images/theater/theater_09m.jpg','FinalProject4/src/main/webapp/resources/images/theater/theater_09L.jpg',to_date('2020/01/04','yyyy/mm/dd'),to_date('2020/12/19','yyyy/mm/dd'),1,'8세 이상','120분',default);
--경주대명아쿠아월드
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(60,6,610,'국가대표궁궐,경복궁','FinalProject4/src/main/webapp/resources/images/theater/theater_10m.jpg','FinalProject4/src/main/webapp/resources/images/theater/theater_10L.jpg',to_date('2020/07/31','yyyy/mm/dd'),to_date('2020/07/31','yyyy/mm/dd'),1,'7세 이상','120분',default);
--경복궁
commit;

-- 공연일시 테이블
drop table yes_show_date cascade constraints purge;
create table yes_show_date
(date_id        number(10)      -- 공연일시코드
,prod_id        number          -- 공연코드(FK)
,date_showday   date            -- 공연하는날짜
,date_showtime  varchar2(20)    -- 공연시간, 회차
,constraint PK_date_id primary key(date_id)
,constraint FK_prod_id_date foreign key(prod_id) references prod(prod_id) on delete cascade
);

drop sequence seq_show_date;
create sequence seq_show_date
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

select *
from yes_show_date;

insert into yes_show_date(date_id, prod_id, date_showday, date_showtime)
values(seq_show_date.nextval, 1, to_date('2020/09/01','yyyy/mm/dd'), '1회차 9시');
insert into yes_show_date(date_id, prod_id, date_showday, date_showtime)
values(seq_show_date.nextval, 1, to_date('2020/09/01','yyyy/mm/dd'), '2회차 11시');
insert into yes_show_date(date_id, prod_id, date_showday, date_showtime)
values(seq_show_date.nextval, 1, to_date('2020/09/02','yyyy/mm/dd'), '1회차 9시');
insert into yes_show_date(date_id, prod_id, date_showday, date_showtime)
values(seq_show_date.nextval, 1, to_date('2020/09/02','yyyy/mm/dd'), '2회차 11시');
commit;

-- 공연장소 테이블
drop table yes_show_map;
create table yes_show_map
(map_id         number(10)      -- 장소코드
,prod_id        number          -- 공연코드(FK)
,map_lng        number          -- 경도
,map_lat        number          -- 위도
,map_name       varchar2(20)    -- 장소이름
,map_address    varchar2(30)    -- 장소주소
,map_url        varchar2(50)    -- 홈페이지url
,map_img        varchar2(100)    -- 장소이미지
,constraint PK_map_id primary key(map_id)
,constraint FK_prod_id_map foreign key(prod_id) references prod(prod_id) on delete cascade
);

drop sequence seq_show_map;
create sequence seq_show_map
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

select *
from yes_show_map;

insert into yes_show_map(map_id, prod_id, map_lng, map_lat, map_name, map_address, map_url, map_img)
values(seq_show_map.nextval, 1, 37.56511284953554, 126.98187860455485, 'YES24 극장', '서울 종각역', 'www.naver.com', 'FinalProject4/src/main/webapp/resources/images/classic/classic_01m.jpg');



-- 공연 좌석 테이블
drop table yes_show_seat;
create table yes_show_seat
(seat_id        number(10)                  -- 좌석코드
,prod_id        number                      -- 공연코드(FK)
,seat_type      varchar(1)                  -- 좌석타입(R, S, A..)
,seat_name      varchar2(20)                -- 좌석이름
,seat_status    number(1)       default 0   -- 좌석상태
,constraint PK_seat_id primary key(seat_id)
,constraint FK_prod_id_seat foreign key(prod_id) references prod(prod_id) on delete cascade
);

drop sequence seq_show_seat;
create sequence seq_show_seat
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

select *
from yes_show_seat;

insert into yes_show_seat(seat_id, prod_id, seat_type, seat_name, seat_status)
values(seq_show_seat.nextval, 1, 'R', '1층 A열 001번', default);





----------------------------------- 예매 테이블 - Reservation -----------------------------------
-- 예매 테이블
drop table yes_reserve;
create table yes_reserve
(rev_id         number(10)                  -- 예매코드
,prod_id        number                      -- 공연코드(FK)
,user_id        number                      -- 회원코드(FK)
,seat_id        number                      -- 좌석코드(FK)
,status_id      number                      -- 상태코드(FK)
,rev_email      varchar2(20)                -- 예매자이메일
,rev_qnty       number(6)                   -- 예매수
,rev_date       date        default sysdate -- 예매일자
,rev_price      number(10)                  -- 예매가격
,rev_ship_method    number(1)               -- 수령방법
,rev_pay_method     number(1)               -- 결제방법
,rev_pay_status     number(1)               -- 결제상태
,constraint PK_rev_id primary key(rev_id)
,constraint FK_prod_id_rev foreign key(prod_id) references prod(prod_id) on delete cascade
,constraint FK_user_id_rev foreign key(user_id) references yes_member(idx) on delete cascade
,constraint FK_seat_id_rev foreign key(seat_id) references yes_show_seat(seat_id) on delete cascade
--,constraint FK_status_id_rev foreign key(status_id) references yes_rev_status(status_id) on delete cascade
);

drop sequence seq_reserve;
create sequence seq_reserve
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

select *
from yes_reserve;

insert into yes_reserve(rev_id, prod_id, user_id, seat_id, status_id, rev_email, rev_qnty, rev_date, rev_price, rev_ship_method, rev_pay_method, rev_pay_status)
values(seq_reserve.nextval, 1, 1, 1, 1, 'hyunho2005@naver.com', 2, default, 50000, 0, 0, 0);

-- 상태 테이블
drop table yes_rev_status;
create table yes_rev_status
(status_id          number(10)              -- 상태코드
,rev_id             number                  -- 예매코드(FK)
,status             number(1)   default 0   -- 상태
,status_cng_date    date                    -- 수정일자
,constraint PK_status_id primary key(status_id)
,constraint FK_rev_id_status foreign key(rev_id) references yes_reserve(rev_id) on delete cascade
);

drop sequence seq_rev_status;
create sequence seq_rev_status
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

select *
from yes_rev_status;

insert into yes_reserve(rev_id, prod_id, user_id, seat_id, status_id, rev_email, rev_qnty, rev_date, rev_price, rev_ship_method, rev_pay_method, rev_pay_status)
values(seq_reserve.nextval, 1, 1, 1, 1, 'hyunho2005@naver.com', 2, default, 50000, 0, 0, 0);

commit;

-----------------------------------------------------------------------------
-- 예매 시, 공연 정보가져올 view
create or replace view view_rev_showInfo
AS
select P.prod_id, P.prod_img, P.prod_title, P.info_grade, P.info_run_time, M.map_name 
from prod P
JOIN yes_show_map M
ON P.prod_id = M.prod_id;
--JOIN yes_show_seat S
--ON M.prod_id = S.prod_id;

select *
from view_rev_showInfo
where prod_id = 1;

-- 예매 시, 공연 시간 정보 가져옴
select prod_id, to_char(date_showday, 'yy/mm/dd') || ' ' || to_char(date_showday, 'day') as date_showday, date_showtime
from yes_show_date
where prod_id = 1
order by 1, 2;

select distinct to_char(date_showday, 'yy/mm/dd') || ' ' || to_char(date_showday, 'day') as date_showday
from yes_show_date
where prod_id = 1
order by date_showday;






----------------------------------- QNA 게시판 테이블 -----------------------------------

drop table yes_qna purge;

create table yes_qna
(qna_id         number                not null   -- 글번호
,fk_userid      varchar2(20)          not null   -- 사용자ID
,name           Nvarchar2(20)         not null   -- 글쓴이
,category       varchar2(20)          not null   -- 카테고리
,fk_rev_id      number(10)
,subject        Nvarchar2(200)        not null   -- 글제목
,content        Nvarchar2(2000)       not null   -- 글내용    -- clob
,pw             varchar2(20)          not null   -- 글암호
,readCount      number default 0      not null   -- 글조회수
,regDate        date default sysdate  not null   -- 글쓴시간
,secret         number(1) default 0   not null   -- 비밀글여부  1:비밀글, 0:공개글
,adminread      number(1) default 0
,adminans       number(1) default 0
,status         number(1) default 1   not null   -- 글삭제여부  1:사용가능한글,  0:삭제된글 
,groupno        number                not null   -- 답변글쓰기에 있어서 그룹번호 
                                                 -- 원글(부모글)과 답변글은 동일한 groupno 를 가진다.
                                                 -- 답변글이 아닌 원글(부모글)인 경우 groupno 의 값은 groupno 컬럼의 최대값(max)+1 로 한다.
,fk_seq         number default 0      not null   -- 답변글쓰기에 있어서 답변글이라면 fk_seq 컬럼의 값은 
                                                 -- 원글(부모글)의 seq 컬럼의 값을 가지게 되며,
                                                 -- 답변글이 아닌 원글일 경우 0 을 가지도록 한다.
,depthno        number default 0       not null  -- 답변글쓰기에 있어서 답변글 이라면
                                                 -- 원글(부모글)의 depthno + 1 을 가지게 되며,
                                                 -- 답변글이 아닌 원글일 경우 0 을 가지도록 한다.
,constraint  PK_qna_id primary key(qna_id)
,constraint  FK_qna_fk_userid foreign key(fk_userid) references yes_member(userid)
,constraint  FK_qna_fk_rev_id foreign key(fk_rev_id) references yes_reserve(rev_id)
,constraint  CK_qna_status check( status in(0,1) )
,constraint  CK_qna_secret check( secret in (0,1) )
,constraint  CK_qna_adminread check( adminread in (0,1) )
,constraint  CK_qna_adminans check( adminans in (0,1) )
);



drop sequence qnaSeq;

create sequence qnaSeq
start with 1
increment by 1
nomaxvalue 
nominvalue
nocycle
nocache;



----------------------------------- 공지 게시판 테이블 -----------------------------------



drop table yes_notice purge;

create table yes_notice
(notice_id      number                not null   -- 글번호
,fk_userid      varchar2(20)          not null   -- 사용자ID
,name           Nvarchar2(20)         not null   -- 글쓴이
,category       varchar2(20)          not null   -- 카테고리
,ticketopenday  varchar2(100)         
,subject        Nvarchar2(200)        not null   -- 글제목
,content        Nvarchar2(2000)       not null   -- 글내용    -- clob
,pw             varchar2(20)          not null   -- 글암호
,readCount      number default 0      not null   -- 글조회수
,regDate        date default sysdate  not null   -- 글쓴시간
,status         number(1) default 1   not null   -- 글삭제여부  1:사용가능한글,  0:삭제된글 
,fileName       varchar2(255)                    -- WAS(톰캣)에 저장될 파일명(20190725092715353243254235235234.png)                                       
,orgFilename    varchar2(255)                    -- 진짜 파일명(강아지.png)  // 사용자가 파일을 업로드 하거나 파일을 다운로드 할때 사용되어지는 파일명 
,fileSize       number                           -- 파일크기  
,constraint  PK_notice_id primary key(notice_id)
,constraint  FK_notice_fk_userid foreign key(fk_userid) references yes_member(userid)
,constraint  CK_notice_status check( status in(0,1) )
);



drop sequence noticeSeq;

create sequence noticeSeq
start with 1
increment by 1
nomaxvalue 
nominvalue
nocycle
nocache;



----------------------------------- 공지 카테고리 테이블 -----------------------------------


drop table yes_notice_cate purge;

create table yes_notice_cate
(no_cate_id    number(8)     not null  -- 카테고리 대분류 번호
,no_cate_code    varchar2(20)  not null  -- 카테고리 코드
,no_cate_name   varchar2(100) not null  -- 카테고리명
,constraint PK_no_cate_cnum primary key(no_cate_id)
,constraint UQ_no_cate_code unique(no_cate_code)
);

drop sequence noticeCateSeq;

create sequence noticeCateSeq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

insert into yes_notice_cate values(noticeCateSeq.nextval, '100000', '티켓오픈');
insert into yes_notice_cate values(noticeCateSeq.nextval, '200000', '서비스점검');
insert into yes_notice_cate values(noticeCateSeq.nextval, '300000', '변경/취소');
insert into yes_notice_cate values(noticeCateSeq.nextval, '400000', '기타');
commit;

select * 
from yes_notice_cate;


----------------------------------- QNA 카테고리 테이블 -----------------------------------


drop table yes_qna_cate purge;

create table yes_qna_cate
(qna_cate_id    number(8)     not null  -- 카테고리 대분류 번호
,qna_cate_code  varchar2(20)  not null  -- 카테고리 코드
,qna_cate_name  varchar2(100) not null  -- 카테고리명
,constraint PK_qna_cate_cnum primary key(qna_cate_id)
,constraint UQ_qna_cate_code unique(qna_cate_code)
);

drop sequence qnaCateSeq;

create sequence qnaCateSeq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

insert into yes_qna_cate values(qnaCateSeq.nextval, '100000', '주문');
insert into yes_qna_cate values(qnaCateSeq.nextval, '200000', '배송');
insert into yes_qna_cate values(qnaCateSeq.nextval, '300000', '취소/교환/환불');
insert into yes_qna_cate values(qnaCateSeq.nextval, '400000', '회원');
insert into yes_qna_cate values(qnaCateSeq.nextval, '500000', '공연/예매');
insert into yes_qna_cate values(qnaCateSeq.nextval, '600000', '기타');
commit;

select * 
from yes_qna_cate;


----------------------------------- 리뷰 테이블 -----------------------------------

create table yes_review
(review_id     number               not null   -- 리뷰번호
,fk_userid     varchar2(20)         not null   -- 사용자ID
,name          varchar2(20)         not null   -- 성명
,content       varchar2(1000)       not null   -- 리뷰내용
,star          number(1) default 5  not null   -- 별점
,regDate       date default sysdate not null   -- 작성일자
,parentProdId  number               not null   -- 원게시물 글번호(공연ID)
,fk_rev_status number default 0     not null   -- 예매상태
,fk_rev_date   date                            -- 예매일자
,status        number(1) default 1  not null   -- 글삭제여부
                                               -- 1 : 사용가능한 글,  0 : 삭제된 글
                                               -- 댓글은 원글이 삭제되면 자동적으로 삭제되어야 한다.
,constraint PK_review_id primary key(review_id)
,constraint FK_review_fk_userid foreign key(fk_userid)
                                references yes_member(userid)
,constraint FK_review_parentProdId foreign key(parentProdId) 
                                   references prod(prod_id) on delete cascade
,constraint FK_review_fk_rev_date foreign key(fk_rev_date)
                               references yes_reserve(rev_date)
,constraint CK_review_star check( star in (1,2,3,4,5) )
,constraint CK_review_status check( status in(1,0) ) 
);




drop sequence reviewSeq;

create sequence reviewSeq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


select *
from yes_review;


----------------------------------- 리뷰 테이블 -----------------------------------


drop table like_review purge;

create table like_review
(seq          number          not null    -- 시퀀스
,fk_userid          varchar2(20)	not null    -- 사용자ID
,fk_parentReviewId  number          not null    -- 리뷰ID
,fk_parentProdId    number          not null    -- 공연ID
,constraint	PK_like_rev primary key(fk_userid, fk_parentReviewId) -- 복합 primary key
,constraint FK_like_rev_userid foreign key(fk_userid) references yes_member(userid)
,constraint FK_like_rev_parentReviewId foreign key(fk_parentReviewId) references yes_review(review_id)
,constraint FK_like_rev_parentProdId foreign key(fk_parentProdId) references prod(prod_id) on delete cascade
);

drop sequence likeReviewSeq;

create sequence likeReviewSeq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


----------------------------------- 관심공연 테이블 -----------------------------------


drop table like_prod purge;

create table like_prod
(seq                number          not null    -- 시퀀스
,fk_userid          varchar2(20)	not null    -- 사용자ID
,fk_parentProdId    number          not null    -- 공연ID
,constraint FK_like_prod_fk_userid foreign key(fk_userid) references yes_member(userid)
,constraint FK_like_prod_fk_parentProdId foreign key(fk_parentProdId) references prod(prod_id) on delete cascade
);

drop sequence likeProdSeq;

create sequence likeProdSeq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;




----------------------------------- 고객센터질문(FAQ) 테이블 -----------------------------------

drop table yes_faq purge;

create table yes_faq
(faq_id         number                not null   -- 글번호
,fk_userid      varchar2(20)          not null   -- 사용자ID
,fk_category    varchar2(20)          not null   -- 카테고리  
,subject        Nvarchar2(200)        not null   -- 글제목
,content        Nvarchar2(2000)       not null   -- 글내용    -- clob
,regDate        date default sysdate  not null   -- 글쓴시간
,status         number(1) default 1   not null   -- 글삭제여부  1:사용가능한글,  0:삭제된글 
,constraint  PK_faq_id primary key(faq_id)
,constraint  FK_faq_fk_userid foreign key(fk_userid) references yes_member(userid)
,constraint  FK_faq_fk_category foreign key(fk_category) references yes_faq_cate(faq_cate_code)
,constraint  CK_faq_status check( status in(0,1) )
);



drop sequence faqSeq;

create sequence faqSeq
start with 1
increment by 1
nomaxvalue 
nominvalue
nocycle
nocache;

insert into yes_faq(faq_id, fk_userid, fk_category, subject, content)
values(faqSeq.nextval, 'admin', '1', '비회원도 공연 예매를 할 수 있나요?', '비회원 및 간편 가입 회원은 예매를 하실 수가 없습니다. <br/>
예매 서비스 이용을 위해서는 휴대폰 또는 I-PIN 본인 인증을 해주시기 바랍니다. ');
insert into yes_faq(faq_id, fk_userid, fk_category, subject, content)
values(faqSeq.nextval, 'admin', '1', '법인회원도 공연 예매를 할 수 있나요?', '법인회원도 공연예매 가능합니다. <br/>
현장에서 티켓 수령을 위해 사업자등록증 사본, 명함 또는 사원증, 예매내역서, 신분증 등을 지참해주시기 바랍니다. ');
insert into yes_faq(faq_id, fk_userid, fk_category, subject, content)
values(faqSeq.nextval, 'admin', '2', '환불 계좌 정보를 잘못 입력해서 환불 받지 못했어요!', '환불 계좌 정보를 잘못 입력하여 환불이 되지 않은 경우 환불 계좌 수정이 가능합니다. <br/>
MY티켓>예매확인/취소>결제내역 의 환불진행상태에서 [수정] 버튼을 클릭하시어 환불 계좌 정보를 입력해주세요. <br/>
단, PC 에서만, 평일 오전 10시 ~ 오후 3시 에 가능합니다. <br/>');
insert into yes_faq(faq_id, fk_userid, fk_category, subject, content)
values(faqSeq.nextval, 'admin', '4', '예매한 이후 회원정보를 변경했어요. 예매 정보에도 자동으로 반경되나요?', '아닙니다. 회원 정보 수정 후 기존 로그인 상태를 유지할 경우 변경된 회원 정보는 예매 정보에 반영이 되지 않습니다. <br/>
번거로우시겠지만 반드시 로그아웃 후 재 로그인을 하셔야 반영되므로, 최신 회원 정보 반영을 위해서는 재로그인해주시기 바랍니다. <br/>');
insert into yes_faq(faq_id, fk_userid, fk_category, subject, content)
values(faqSeq.nextval, 'admin', '3', '결제수단을 여러 개 이용하여 예매한 경우 취소는 어떻게 하나요?', '결제수단을 여러 개 이용하여 예매한 경우 취소는 어떻게 하나요? <br/>
여러 결제 수단을 이용 해 예매한 경우 부분 취소는 불가하며, 전체 취소만 가능합니다. <br/>
부분 취소를 원하시는 경우 고객센터(T.1544-6399)로 문의해주시기 바랍니다. <br/>
단, 취소 마감 시간 전까지만 가능합니다.');
insert into yes_faq(faq_id, fk_userid, fk_category, subject, content)
values(faqSeq.nextval, 'admin', '3', '예매 취소는 언제까지 할 수 있나요?', '예매 취소는 취소 마감 시간까지만 가능하며, 취소 일자에 따라 수수료가 부과됩니다. <br/>
<span style="color: red;">[예매취소 마감일]</span> <br/>
* 공연관람일이 일요일~월요일 → 토요일 오전 11시<br/>
* 공연관람일이 화요일~토요일 → 전날 오후 5시<br/>
* 공연관람일이 공휴일 및 공휴일 다음날<br/>
  → 공휴일 전날이 평일인 경우 오후 5시 <br/>
  → 공휴일 전날이 토요일, 일요일인 경우 토요일 오전 11시<br/>
  → 공휴일이 긴 경우에는 공휴일 첫날 기준 (평일 - 오후 5시 이전 / 일, 월 - 오전 11시 이전)<br/><br/>
단, 각 상품 정책에 따라 취소 마감 시간이 다를 수 있으며, 이 경우 해당 상품 정책이 우선 적용되오니 예매 시 상품 상세 정보 내 안내 사항을 참고해주시기 바랍니다.');

insert into yes_faq(faq_id, fk_userid, fk_category, subject, content)
values(faqSeq.nextval, 'admin', '3', '예매취소시 취소수수료가 부과되나요?', '취소 일자에 따라 취소수수료가 다르게 부과됩니다. ');

insert into yes_faq(faq_id, fk_userid, fk_category, subject, content)
values(faqSeq.nextval, 'admin', '3', '배송 받은 티켓을 취소하고 싶습니다.', '배송 받은 티켓은 웹/모바일 취소가 불가하며, 취소 마감 시간 전까지 예스24 고객센터로 반송되어야 취소 가능합니다. <br/>
단, 고객센터 운영시간에 한하며, 티켓이 고객센터에 도착한 날짜를 기준으로 취소수수료가 적용됩니다. <br/>');

insert into yes_faq(faq_id, fk_userid, fk_category, subject, content)
values(faqSeq.nextval, 'admin', '3', '공연 관람 당일 취소가 가능한가요 ?', '기본적으로 <span style="color: red;">공연 관람 당일 취소는 불가</span>합니다. <br/>
(관람일 당일 취소가 가능한 일부 공연의 경우 티켓 금액의 90%가 취소수수료로 부과됩니다.) <br/>
공연의 특성에 따라 취소마감시간/취소수수료 정책이 달라질 수 있으니 예매 시 반드시 각 공연 상세 정보를 확인해주시기 바랍니다.<br/>');

insert into yes_faq(faq_id, fk_userid, fk_category, subject, content)
values(faqSeq.nextval, 'admin', '3', '예매 취소 시 환불은 어떻게 받나요?', '결제 수단에 따라 아래의 방법과 같이 환불 됩니다.<br/>
신용카드<br/>- 일반적으로 취소완료 4~5일(토, 공휴일 제외) 후 카드 승인 취소가 확인됩니다.<br/>
무통장입금<br/>- 예매 취소 시 반드시 환불 받으실 은행명과 계좌번호를 입력해주세요.<br/>
YES상품권<br/>- 정상적으로 예매를 취소하는 경우 취소 시 바로 복원됩니다.<br/>
YES머니, 예치금<br/>- 정상적으로 예매를 취소하는 경우 취소 시 바로 복원됩니다.<br/>
쿠폰<br/>- 예매 취소시 쿠폰은 자동 복원됩니다.(쿠폰 사용 기간이 종료된 경우 복원되지 않습니다.)<br/>
* 단, 쿠폰에 따라 복원되지 않는 경우도 있으니 쿠폰 유의사항을 확인해주시기 바랍니다.');


insert into yes_faq(faq_id, fk_userid, fk_category, subject, content)
values(faqSeq.nextval, 'admin', '1', '공연 예매 시 몇 장까지 예매할 수 있나요?', '일반적으로 1회 예매 시 최대 10장까지 예매 가능합니다. <br/>
단, 공연에 따라 ID당 또는 회차당 예매 매수 제한이 있을 수 있으니, 각 상품 상세 정보를 확인해주시기 바랍니다.');

insert into yes_faq(faq_id, fk_userid, fk_category, subject, content)
values(faqSeq.nextval, 'admin', '1', '예매한 티켓의 관람일시 또는 좌석을 변경할 수 있나요?', '예매 건의 날짜, 시간, 좌석 등의 일부 변경을 원하실 경우 재예매 하신 후 기존 예매를 취소해주셔야 합니다. <br/>
단, 취소 마감시간 전까지만 가능하며, 취소 시점에 따라 예매수수료가 환불되지 않으며 취소수수료가 부과될 수있습니다. <br/>
* 재예매하시고 결제 완료 후 기존 예매 건의 취소 마감 시간 내에 고객센터(1544-6399)로 전화주시면 동일한 공연, 1회에 한해 100% 취소처리 해드립니다.');

insert into yes_faq(faq_id, fk_userid, fk_category, subject, content)
values(faqSeq.nextval, 'admin', '1', '공연 예매 시에도 YES포인트 적립이 되나요?', '일반적으로 공연 예매 시에는 YES포인트가 적립되지 않습니다. <br/> 
(간혹 이벤트 진행 시 특정 기간 동안 일부 상품에 한해 적립되는 경우가 있으며, 이 경우 YES포인트 적립 상품은 해당 상품 상세 정보에 별도 표기됩니다.) ');

insert into yes_faq(faq_id, fk_userid, fk_category, subject, content)
values(faqSeq.nextval, 'admin', '1', '예매(예약) 건의 결제 수단을 변경할 수 있나요?', ' "무통장입금"을 선택하여 예매한 경우 입금 완료 전 신용카드로 결제 수단을 변경할 수 있습니다. <br/>
PC>MY공연>예매확인/취소 상세에서 직접 변경하시거나 <br/>
고객센터 전화(1544-6399) 또는 일대일문의를 남겨주시면 처리 가능합니다. <br/>
단, 신용카드로 결제한 경우 다른 카드로 변경 또는 할부 개월 수 변경 등은 하실 수 없으니 카드 결제 시 유의해 주시기 바랍니다. ');


insert into yes_faq(faq_id, fk_userid, fk_category, subject, content)
values(faqSeq.nextval, 'admin', '4', '본인인증된 ID 로만 예매할 수 있나요?', '<span style="color: red;">공연 예매는 본인 인증된 ID로만 예매 가능합니다. </span><br/>
비회원 또는 간편 가입 회원 예매는 불가하오니, 예매 전 휴대폰 또는 I-PIN 으로 본인 인증을 하신 후 재로그인 해주시기 바랍니다.');

insert into yes_faq(faq_id, fk_userid, fk_category, subject, content)
values(faqSeq.nextval, 'admin', '4', 'YES마니아에게는 어떤 공연 예매 혜택이 있나요?', '매월 예매수수료 면제쿠폰 1장이 지급되며, 일부 공연에 한해 YES마니아 전용 할인이 제공됩니다.');

insert into yes_faq(faq_id, fk_userid, fk_category, subject, content)
values(faqSeq.nextval, 'admin', '2', '티켓 수령 방법은 어떤 것이 있나요?', '[현장수령]<br/>- 공연 관람 당일 공연장에서 예매 내역 확인 후 티켓을 수령하실 수 있습니다.><br/>
- 티켓 수령을 위해 예매자 본인 신분증과 예매내역서를 지참해주시기 바랍니다. <br/><br/>[배송]<br/>- 예매완료(결제익일) 기준 5~7일 이내에 배송됩니다. (주말, 공휴일 제외한 영업일 기준) <br/>
- 배송료는 2,800원이며 공연일 14일 전 예매 건에 한해 배송 접수 가능합니다. <br/>');

insert into yes_faq(faq_id, fk_userid, fk_category, subject, content)
values(faqSeq.nextval, 'admin', '2', '배송지 정보를 변경할 수 있나요?', '티켓 배송이 시작되기 전(발송대기 상태)에는 MY티켓>예매상세내역 에서 직접 변경할 수 있습니다. <br/>
배송이 시작된 이후에는 고객님께서 직접 배송 업체로 문의 및 변경 요청해주셔야 하며, <br/>
경우에 따라 배송지 변경이 불가할 수 있습니다. <br/>');

commit;

----------------------------------- FAQ 카테고리 테이블 -----------------------------------


drop table yes_faq_cate purge;

create table yes_faq_cate
(faq_cate_id     number(8)     not null  -- 카테고리 대분류 번호
,faq_cate_code   varchar2(20)  not null  -- 카테고리 코드
,faq_cate_name   varchar2(100) not null  -- 카테고리명
,constraint PK_faq_cate_cnum primary key(faq_cate_id)
,constraint UQ_faq_cate_code unique(faq_cate_code)
);

drop sequence faqCateSeq;

create sequence faqCateSeq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

insert into yes_faq_cate values(faqCateSeq.nextval, '1', '예매/결제');
insert into yes_faq_cate values(faqCateSeq.nextval, '2', '취소/환불');
insert into yes_faq_cate values(faqCateSeq.nextval, '3', '티켓수령');
insert into yes_faq_cate values(faqCateSeq.nextval, '4', '기타');
commit;

select * 
from yes_faq_cate;


select faq_id, fk_userid, fk_category, subject, content, regDate, status
from yes_faq
where fk_category = '1';

select faq_id, fk_userid, subject, content, regDate, status, faq_cate_name
from 
(
select faq_id, fk_userid, C.faq_cate_name, fk_category, subject, content, regDate, status
from yes_faq F join yes_faq_cate C
on F.fk_category = C.faq_cate_code
) T
where fk_category = '1';
-- 카테고리 1인 예매/결제 카테고리의 FAQ 글들 가져오기


select faq_id, fk_userid, subject, content, regDate, status, C.faq_cate_name, fk_category
from yes_faq F join yes_faq_cate C
on F.fk_category = C.faq_cate_code;
-- FAQ join 테이블

select faq_id, fk_userid, subject, content, regDate, status, faq_cate_name
from 
(
select faq_id, fk_userid, C.faq_cate_name, fk_category, subject, content, regDate, status
from yes_faq F join yes_faq_cate C
on F.fk_category = C.faq_cate_code
) T
where 1=1 and fk_category = '1' and subject like '%회원%';