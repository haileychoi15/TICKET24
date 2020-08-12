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
from yes_show
where prod_id = '1';

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

-- 공연 좌석 종류 테이블
drop table yes_seat_type;
create table yes_seat_type
(seattype_id        number(10)                  -- 좌석종류코드
,prod_id            number                      -- 공연코드(FK)
,seat_type          varchar(3)                  -- 좌석타입(R, S, A..)
,seat_price         number(10)                  -- 좌석이름
,seat_color         varchar2(20)                -- 좌석색깔
,constraint PK_seattype_id primary key(seattype_id)
,constraint FK_prod_id_seattype foreign key(prod_id) references prod(prod_id) on delete cascade
);

drop sequence seq_seat_type;
create sequence seq_seat_type
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

select *
from yes_seat_type;

insert into yes_seat_type(seattype_id, prod_id, seat_type, seat_price, seat_color)
values(seq_seat_type.nextval, 1, 'VIP', 120000, 'indianred');
insert into yes_seat_type(seattype_id, prod_id, seat_type, seat_price, seat_color)
values(seq_seat_type.nextval, 1, 'R', 80000, 'darkslateblue');
insert into yes_seat_type(seattype_id, prod_id, seat_type, seat_price, seat_color)
values(seq_seat_type.nextval, 1, 'S', 40000, 'mediumpurple');
commit;

select seat_type, seat_price, seat_color
from yes_seat_type
where prod_id = 1;


-- 공연 좌석 테이블
drop table yes_show_seat;
create table yes_show_seat
(seat_id        number(10)                  -- 좌석코드
,seattype_id    number                      -- 좌석타입코드(FK)
,date_id        number(20)                  -- 공연 일시/회차 (FK)
,seat_name      varchar2(40)                -- 좌석이름
,seat_status    number(1)       default 0   -- 좌석상태
,constraint PK_seat_id primary key(seat_id)
,constraint FK_seattype_id foreign key(seattype_id) references yes_seat_type(seattype_id) on delete cascade
);

drop sequence seq_show_seat;
create sequence seq_show_seat
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

update yes_show_seat set seat_status = 1 where seat_id = 17;
commit;

INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (1, 2, '1층 A구역 01열 001번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (2, 2, '1층 A구역 01열 002번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (3, 2, '1층 A구역 01열 003번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (4, 2, '1층 A구역 01열 004번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (5, 2, '1층 A구역 01열 005번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (6, 2, '1층 A구역 01열 006번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (7, 2, '1층 A구역 01열 007번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (8, 2, '1층 A구역 01열 008번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (9, 2, '1층 B구역 01열 001번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (10, 2, '1층 B구역 01열 002번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (11, 2, '1층 B구역 01열 003번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (12, 2, '1층 B구역 01열 004번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (13, 2, '1층 B구역 01열 005번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (14, 1, '1층 B구역 01열 006번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (15, 1, '1층 B구역 01열 007번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (16, 1, '1층 B구역 01열 008번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (17, 1, '1층 B구역 01열 009번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (18, 1, '1층 B구역 01열 010번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (19, 1, '1층 B구역 01열 011번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (20, 1, '1층 B구역 01열 012번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (21, 1, '1층 B구역 01열 013번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (22, 1, '1층 B구역 01열 014번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (23, 1, '1층 B구역 01열 015번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (24, 1, '1층 B구역 01열 016번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (25, 2, '1층 B구역 01열 017번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (26, 2, '1층 B구역 01열 018번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (27, 2, '1층 B구역 01열 019번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (28, 2, '1층 B구역 01열 020번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (29, 2, '1층 B구역 01열 021번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (30, 2, '1층 C구역 01열 001번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (31, 2, '1층 C구역 01열 002번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (32, 2, '1층 C구역 01열 003번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (33, 2, '1층 C구역 01열 004번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (34, 2, '1층 C구역 01열 005번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (35, 2, '1층 C구역 01열 006번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (36, 2, '1층 C구역 01열 007번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (37, 2, '1층 C구역 01열 008번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (38, 2, '1층 A구역 02열 001번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (39, 2, '1층 A구역 02열 002번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (40, 2, '1층 A구역 02열 003번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (41, 2, '1층 A구역 02열 004번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (42, 2, '1층 A구역 02열 005번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (43, 2, '1층 A구역 02열 006번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (44, 2, '1층 A구역 02열 007번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (45, 2, '1층 A구역 02열 008번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (46, 2, '1층 B구역 02열 001번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (47, 2, '1층 B구역 02열 002번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (48, 2, '1층 B구역 02열 003번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (49, 2, '1층 B구역 02열 004번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (50, 1, '1층 B구역 02열 005번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (51, 1, '1층 B구역 02열 006번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (52, 1, '1층 B구역 02열 007번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (53, 1, '1층 B구역 02열 008번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (54, 1, '1층 B구역 02열 009번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (55, 1, '1층 B구역 02열 010번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (56, 1, '1층 B구역 02열 011번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (57, 1, '1층 B구역 02열 012번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (58, 1, '1층 B구역 02열 013번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (59, 1, '1층 B구역 02열 014번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (60, 1, '1층 B구역 02열 015번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (61, 1, '1층 B구역 02열 016번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (62, 1, '1층 B구역 02열 017번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (63, 2, '1층 B구역 02열 018번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (64, 2, '1층 B구역 02열 019번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (65, 2, '1층 B구역 02열 020번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (66, 2, '1층 B구역 02열 021번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (67, 2, '1층 C구역 02열 001번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (68, 2, '1층 C구역 02열 002번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (69, 2, '1층 C구역 02열 003번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (70, 2, '1층 C구역 02열 004번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (71, 2, '1층 C구역 02열 005번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (72, 2, '1층 C구역 02열 006번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (73, 2, '1층 C구역 02열 007번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (74, 2, '1층 C구역 02열 008번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (75, 2, '1층 A구역 03열 001번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (76, 2, '1층 A구역 03열 002번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (77, 2, '1층 A구역 03열 003번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (78, 2, '1층 A구역 03열 004번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (79, 2, '1층 A구역 03열 005번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (80, 2, '1층 A구역 03열 006번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (81, 2, '1층 A구역 03열 007번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (82, 2, '1층 A구역 03열 008번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (83, 2, '1층 B구역 03열 001번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (84, 2, '1층 B구역 03열 002번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (85, 2, '1층 B구역 03열 003번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (86, 1, '1층 B구역 03열 004번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (87, 1, '1층 B구역 03열 005번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (88, 1, '1층 B구역 03열 006번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (89, 1, '1층 B구역 03열 007번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (90, 1, '1층 B구역 03열 008번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (91, 1, '1층 B구역 03열 009번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (92, 1, '1층 B구역 03열 010번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (93, 1, '1층 B구역 03열 011번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (94, 1, '1층 B구역 03열 012번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (95, 1, '1층 B구역 03열 013번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (96, 1, '1층 B구역 03열 014번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (97, 1, '1층 B구역 03열 015번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (98, 1, '1층 B구역 03열 016번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (99, 1, '1층 B구역 03열 017번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (100, 1, '1층 B구역 03열 018번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (101, 2, '1층 B구역 03열 019번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (102, 2, '1층 B구역 03열 020번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (103, 2, '1층 B구역 03열 021번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (104, 2, '1층 C구역 03열 001번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (105, 2, '1층 C구역 03열 002번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (106, 2, '1층 C구역 03열 003번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (107, 2, '1층 C구역 03열 004번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (108, 2, '1층 C구역 03열 005번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (109, 2, '1층 C구역 03열 006번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (110, 2, '1층 C구역 03열 007번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (111, 2, '1층 C구역 03열 008번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (112, 2, '1층 A구역 04열 001번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (113, 2, '1층 A구역 04열 002번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (114, 2, '1층 A구역 04열 003번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (115, 2, '1층 A구역 04열 004번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (116, 2, '1층 A구역 04열 005번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (117, 2, '1층 A구역 04열 006번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (118, 2, '1층 A구역 04열 007번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (119, 2, '1층 A구역 04열 008번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (120, 2, '1층 B구역 04열 001번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (121, 2, '1층 B구역 04열 002번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (122, 1, '1층 B구역 04열 003번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (123, 1, '1층 B구역 04열 004번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (124, 1, '1층 B구역 04열 005번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (125, 1, '1층 B구역 04열 006번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (126, 1, '1층 B구역 04열 007번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (127, 1, '1층 B구역 04열 008번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (128, 1, '1층 B구역 04열 009번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (129, 1, '1층 B구역 04열 010번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (130, 1, '1층 B구역 04열 011번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (131, 1, '1층 B구역 04열 012번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (132, 1, '1층 B구역 04열 013번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (133, 1, '1층 B구역 04열 014번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (134, 1, '1층 B구역 04열 015번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (135, 1, '1층 B구역 04열 016번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (136, 1, '1층 B구역 04열 017번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (137, 1, '1층 B구역 04열 018번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (138, 1, '1층 B구역 04열 019번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (139, 2, '1층 B구역 04열 020번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (140, 2, '1층 B구역 04열 021번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (141, 2, '1층 C구역 04열 001번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (142, 2, '1층 C구역 04열 002번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (143, 2, '1층 C구역 04열 003번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (144, 2, '1층 C구역 04열 004번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (145, 2, '1층 C구역 04열 005번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (146, 2, '1층 C구역 04열 006번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (147, 2, '1층 C구역 04열 007번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (148, 2, '1층 C구역 04열 008번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (149, 2, '1층 A구역 05열 001번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (150, 2, '1층 A구역 05열 002번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (151, 2, '1층 A구역 05열 003번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (152, 2, '1층 A구역 05열 004번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (153, 2, '1층 A구역 05열 005번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (154, 2, '1층 A구역 05열 006번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (155, 2, '1층 A구역 05열 007번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (156, 2, '1층 A구역 05열 008번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (157, 2, '1층 B구역 05열 001번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (158, 1, '1층 B구역 05열 002번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (159, 1, '1층 B구역 05열 003번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (160, 1, '1층 B구역 05열 004번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (161, 1, '1층 B구역 05열 005번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (162, 1, '1층 B구역 05열 006번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (163, 1, '1층 B구역 05열 007번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (164, 1, '1층 B구역 05열 008번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (165, 1, '1층 B구역 05열 009번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (166, 1, '1층 B구역 05열 010번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (167, 1, '1층 B구역 05열 011번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (168, 1, '1층 B구역 05열 012번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (169, 1, '1층 B구역 05열 013번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (170, 1, '1층 B구역 05열 014번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (171, 1, '1층 B구역 05열 015번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (172, 1, '1층 B구역 05열 016번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (173, 1, '1층 B구역 05열 017번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (174, 1, '1층 B구역 05열 018번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (175, 1, '1층 B구역 05열 019번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (176, 1, '1층 B구역 05열 020번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (177, 2, '1층 B구역 05열 021번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (178, 2, '1층 C구역 05열 001번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (179, 2, '1층 C구역 05열 002번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (180, 2, '1층 C구역 05열 003번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (181, 2, '1층 C구역 05열 004번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (182, 2, '1층 C구역 05열 005번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (183, 2, '1층 C구역 05열 006번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (184, 2, '1층 C구역 05열 007번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (185, 2, '1층 C구역 05열 008번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (186, 2, '1층 A구역 06열 001번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (187, 2, '1층 A구역 06열 002번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (188, 2, '1층 A구역 06열 003번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (189, 2, '1층 A구역 06열 004번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (190, 2, '1층 A구역 06열 005번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (191, 2, '1층 A구역 06열 006번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (192, 2, '1층 A구역 06열 007번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (193, 2, '1층 A구역 06열 008번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (194, 1, '1층 B구역 06열 001번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (195, 1, '1층 B구역 06열 002번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (196, 1, '1층 B구역 06열 003번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (197, 1, '1층 B구역 06열 004번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (198, 1, '1층 B구역 06열 005번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (199, 1, '1층 B구역 06열 006번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (200, 1, '1층 B구역 06열 007번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (201, 1, '1층 B구역 06열 008번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (202, 1, '1층 B구역 06열 009번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (203, 1, '1층 B구역 06열 010번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (204, 1, '1층 B구역 06열 011번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (205, 1, '1층 B구역 06열 012번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (206, 1, '1층 B구역 06열 013번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (207, 1, '1층 B구역 06열 014번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (208, 1, '1층 B구역 06열 015번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (209, 1, '1층 B구역 06열 016번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (210, 1, '1층 B구역 06열 017번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (211, 1, '1층 B구역 06열 018번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (212, 1, '1층 B구역 06열 019번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (213, 1, '1층 B구역 06열 020번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (214, 1, '1층 B구역 06열 021번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (215, 2, '1층 C구역 06열 001번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (216, 2, '1층 C구역 06열 002번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (217, 2, '1층 C구역 06열 003번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (218, 2, '1층 C구역 06열 004번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (219, 2, '1층 C구역 06열 005번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (220, 2, '1층 C구역 06열 006번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (221, 2, '1층 C구역 06열 007번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (222, 2, '1층 C구역 06열 008번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (223, 2, '1층 A구역 07열 001번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (224, 2, '1층 A구역 07열 002번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (225, 2, '1층 A구역 07열 003번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (226, 2, '1층 A구역 07열 004번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (227, 2, '1층 A구역 07열 005번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (228, 2, '1층 A구역 07열 006번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (229, 2, '1층 A구역 07열 007번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (230, 2, '1층 A구역 07열 008번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (231, 1, '1층 B구역 07열 001번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (232, 1, '1층 B구역 07열 002번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (233, 1, '1층 B구역 07열 003번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (234, 1, '1층 B구역 07열 004번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (235, 1, '1층 B구역 07열 005번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (236, 1, '1층 B구역 07열 006번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (237, 1, '1층 B구역 07열 007번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (238, 1, '1층 B구역 07열 008번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (239, 1, '1층 B구역 07열 009번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (240, 1, '1층 B구역 07열 010번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (241, 1, '1층 B구역 07열 011번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (242, 1, '1층 B구역 07열 012번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (243, 1, '1층 B구역 07열 013번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (244, 1, '1층 B구역 07열 014번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (245, 1, '1층 B구역 07열 015번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (246, 1, '1층 B구역 07열 016번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (247, 1, '1층 B구역 07열 017번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (248, 1, '1층 B구역 07열 018번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (249, 1, '1층 B구역 07열 019번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (250, 1, '1층 B구역 07열 020번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (251, 1, '1층 B구역 07열 021번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (252, 2, '1층 C구역 07열 001번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (253, 2, '1층 C구역 07열 002번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (254, 2, '1층 C구역 07열 003번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (255, 2, '1층 C구역 07열 004번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (256, 2, '1층 C구역 07열 005번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (257, 2, '1층 C구역 07열 006번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (258, 2, '1층 C구역 07열 007번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (259, 2, '1층 C구역 07열 008번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (260, 2, '1층 A구역 08열 001번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (261, 2, '1층 A구역 08열 002번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (262, 2, '1층 A구역 08열 003번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (263, 2, '1층 A구역 08열 004번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (264, 2, '1층 A구역 08열 005번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (265, 2, '1층 A구역 08열 006번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (266, 2, '1층 A구역 08열 007번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (267, 2, '1층 A구역 08열 008번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (268, 1, '1층 B구역 08열 001번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (269, 1, '1층 B구역 08열 002번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (270, 1, '1층 B구역 08열 003번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (271, 1, '1층 B구역 08열 004번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (272, 1, '1층 B구역 08열 005번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (273, 1, '1층 B구역 08열 006번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (274, 1, '1층 B구역 08열 007번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (275, 1, '1층 B구역 08열 008번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (276, 1, '1층 B구역 08열 009번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (277, 1, '1층 B구역 08열 010번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (278, 1, '1층 B구역 08열 011번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (279, 1, '1층 B구역 08열 012번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (280, 1, '1층 B구역 08열 013번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (281, 1, '1층 B구역 08열 014번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (282, 1, '1층 B구역 08열 015번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (283, 1, '1층 B구역 08열 016번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (284, 1, '1층 B구역 08열 017번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (285, 1, '1층 B구역 08열 018번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (286, 1, '1층 B구역 08열 019번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (287, 1, '1층 B구역 08열 020번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (288, 1, '1층 B구역 08열 021번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (289, 2, '1층 C구역 08열 001번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (290, 2, '1층 C구역 08열 002번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (291, 2, '1층 C구역 08열 003번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (292, 2, '1층 C구역 08열 004번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (293, 2, '1층 C구역 08열 005번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (294, 2, '1층 C구역 08열 006번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (295, 2, '1층 C구역 08열 007번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (296, 2, '1층 C구역 08열 008번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (297, 2, '1층 A구역 09열 001번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (298, 2, '1층 A구역 09열 002번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (299, 2, '1층 A구역 09열 003번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (300, 2, '1층 A구역 09열 004번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (301, 2, '1층 A구역 09열 005번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (302, 2, '1층 A구역 09열 006번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (303, 2, '1층 A구역 09열 007번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (304, 2, '1층 A구역 09열 008번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (305, 1, '1층 B구역 09열 001번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (306, 1, '1층 B구역 09열 002번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (307, 1, '1층 B구역 09열 003번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (308, 1, '1층 B구역 09열 004번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (309, 1, '1층 B구역 09열 005번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (310, 1, '1층 B구역 09열 006번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (311, 1, '1층 B구역 09열 007번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (312, 1, '1층 B구역 09열 008번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (313, 1, '1층 B구역 09열 009번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (314, 1, '1층 B구역 09열 010번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (315, 1, '1층 B구역 09열 011번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (316, 1, '1층 B구역 09열 012번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (317, 1, '1층 B구역 09열 013번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (318, 1, '1층 B구역 09열 014번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (319, 1, '1층 B구역 09열 015번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (320, 1, '1층 B구역 09열 016번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (321, 1, '1층 B구역 09열 017번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (322, 1, '1층 B구역 09열 018번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (323, 1, '1층 B구역 09열 019번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (324, 1, '1층 B구역 09열 020번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (325, 1, '1층 B구역 09열 021번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (326, 2, '1층 C구역 09열 001번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (327, 2, '1층 C구역 09열 002번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (328, 2, '1층 C구역 09열 003번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (329, 2, '1층 C구역 09열 004번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (330, 2, '1층 C구역 09열 005번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (331, 2, '1층 C구역 09열 006번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (332, 2, '1층 C구역 09열 007번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (333, 2, '1층 C구역 09열 008번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (334, 2, '1층 A구역 10열 001번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (335, 2, '1층 A구역 10열 002번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (336, 2, '1층 A구역 10열 003번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (337, 2, '1층 A구역 10열 004번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (338, 2, '1층 A구역 10열 005번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (339, 2, '1층 A구역 10열 006번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (340, 2, '1층 A구역 10열 007번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (341, 2, '1층 A구역 10열 008번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (342, 2, '1층 B구역 10열 001번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (343, 2, '1층 B구역 10열 002번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (344, 2, '1층 B구역 10열 003번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (345, 2, '1층 B구역 10열 019번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (346, 2, '1층 B구역 10열 020번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (347, 2, '1층 B구역 10열 021번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (348, 2, '1층 C구역 10열 001번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (349, 2, '1층 C구역 10열 002번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (350, 2, '1층 C구역 10열 003번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (351, 2, '1층 C구역 10열 004번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (352, 2, '1층 C구역 10열 005번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (353, 2, '1층 C구역 10열 006번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (354, 2, '1층 C구역 10열 007번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (355, 2, '1층 C구역 10열 008번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (356, 3, '2층 A구역 01열 001번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (357, 3, '2층 A구역 01열 002번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (358, 3, '2층 A구역 01열 003번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (359, 3, '2층 A구역 01열 004번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (360, 3, '2층 A구역 01열 005번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (361, 3, '2층 A구역 01열 006번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (362, 3, '2층 A구역 01열 007번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (363, 3, '2층 A구역 01열 008번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (364, 3, '2층 A구역 01열 009번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (365, 3, '2층 A구역 01열 010번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (366, 3, '2층 B구역 01열 001번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (367, 3, '2층 B구역 01열 002번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (368, 3, '2층 B구역 01열 003번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (369, 3, '2층 B구역 01열 004번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (370, 3, '2층 B구역 01열 005번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (371, 3, '2층 B구역 01열 006번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (372, 3, '2층 B구역 01열 007번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (373, 3, '2층 B구역 01열 008번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (374, 3, '2층 B구역 01열 009번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (375, 3, '2층 B구역 01열 010번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (376, 3, '2층 B구역 01열 011번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (377, 3, '2층 B구역 01열 012번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (378, 3, '2층 B구역 01열 013번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (379, 3, '2층 B구역 01열 014번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (380, 3, '2층 B구역 01열 015번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (381, 3, '2층 C구역 01열 001번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (382, 3, '2층 C구역 01열 002번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (383, 3, '2층 C구역 01열 003번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (384, 3, '2층 C구역 01열 004번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (385, 3, '2층 C구역 01열 005번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (386, 3, '2층 C구역 01열 006번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (387, 3, '2층 C구역 01열 007번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (388, 3, '2층 C구역 01열 008번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (389, 3, '2층 C구역 01열 009번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (390, 3, '2층 C구역 01열 010번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (391, 3, '2층 A구역 02열 001번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (392, 3, '2층 A구역 02열 002번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (393, 3, '2층 A구역 02열 003번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (394, 3, '2층 A구역 02열 004번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (395, 3, '2층 A구역 02열 005번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (396, 3, '2층 A구역 02열 006번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (397, 3, '2층 A구역 02열 007번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (398, 3, '2층 A구역 02열 008번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (399, 3, '2층 A구역 02열 009번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (400, 3, '2층 A구역 02열 010번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (401, 3, '2층 B구역 02열 001번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (402, 3, '2층 B구역 02열 002번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (403, 3, '2층 B구역 02열 003번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (404, 3, '2층 B구역 02열 004번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (405, 3, '2층 B구역 02열 005번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (406, 3, '2층 B구역 02열 006번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (407, 3, '2층 B구역 02열 007번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (408, 3, '2층 B구역 02열 008번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (409, 3, '2층 B구역 02열 009번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (410, 3, '2층 B구역 02열 010번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (411, 3, '2층 B구역 02열 011번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (412, 3, '2층 B구역 02열 012번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (413, 3, '2층 B구역 02열 013번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (414, 3, '2층 B구역 02열 014번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (415, 3, '2층 B구역 02열 015번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (416, 3, '2층 C구역 02열 001번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (417, 3, '2층 C구역 02열 002번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (418, 3, '2층 C구역 02열 003번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (419, 3, '2층 C구역 02열 004번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (420, 3, '2층 C구역 02열 005번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (421, 3, '2층 C구역 02열 006번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (422, 3, '2층 C구역 02열 007번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (423, 3, '2층 C구역 02열 008번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (424, 3, '2층 C구역 02열 009번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (425, 3, '2층 C구역 02열 010번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (426, 3, '2층 A구역 03열 001번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (427, 3, '2층 A구역 03열 002번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (428, 3, '2층 A구역 03열 003번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (429, 3, '2층 A구역 03열 004번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (430, 3, '2층 A구역 03열 005번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (431, 3, '2층 A구역 03열 006번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (432, 3, '2층 A구역 03열 007번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (433, 3, '2층 A구역 03열 008번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (434, 3, '2층 A구역 03열 009번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (435, 3, '2층 A구역 03열 010번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (436, 3, '2층 B구역 03열 001번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (437, 3, '2층 B구역 03열 002번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (438, 3, '2층 B구역 03열 003번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (439, 3, '2층 B구역 03열 004번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (440, 3, '2층 B구역 03열 005번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (441, 3, '2층 B구역 03열 006번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (442, 3, '2층 B구역 03열 007번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (443, 3, '2층 B구역 03열 008번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (444, 3, '2층 B구역 03열 009번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (445, 3, '2층 B구역 03열 010번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (446, 3, '2층 B구역 03열 011번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (447, 3, '2층 B구역 03열 012번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (448, 3, '2층 B구역 03열 013번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (449, 3, '2층 B구역 03열 014번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (450, 3, '2층 B구역 03열 015번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (451, 3, '2층 C구역 03열 001번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (452, 3, '2층 C구역 03열 002번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (453, 3, '2층 C구역 03열 003번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (454, 3, '2층 C구역 03열 004번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (455, 3, '2층 C구역 03열 005번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (456, 3, '2층 C구역 03열 006번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (457, 3, '2층 C구역 03열 007번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (458, 3, '2층 C구역 03열 008번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (459, 3, '2층 C구역 03열 009번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (460, 3, '2층 C구역 03열 010번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (461, 3, '2층 A구역 04열 001번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (462, 3, '2층 A구역 04열 002번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (463, 3, '2층 A구역 04열 003번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (464, 3, '2층 A구역 04열 004번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (465, 3, '2층 A구역 04열 005번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (466, 3, '2층 A구역 04열 006번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (467, 3, '2층 A구역 04열 007번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (468, 3, '2층 A구역 04열 008번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (469, 3, '2층 A구역 04열 009번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (470, 3, '2층 A구역 04열 010번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (471, 3, '2층 B구역 04열 001번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (472, 3, '2층 B구역 04열 002번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (473, 3, '2층 B구역 04열 003번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (474, 3, '2층 B구역 04열 004번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (475, 3, '2층 B구역 04열 005번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (476, 3, '2층 B구역 04열 006번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (477, 3, '2층 B구역 04열 007번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (478, 3, '2층 B구역 04열 008번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (479, 3, '2층 B구역 04열 009번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (480, 3, '2층 B구역 04열 010번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (481, 3, '2층 B구역 04열 011번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (482, 3, '2층 B구역 04열 012번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (483, 3, '2층 B구역 04열 013번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (484, 3, '2층 B구역 04열 014번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (485, 3, '2층 B구역 04열 015번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (486, 3, '2층 C구역 04열 001번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (487, 3, '2층 C구역 04열 002번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (488, 3, '2층 C구역 04열 003번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (489, 3, '2층 C구역 04열 004번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (490, 3, '2층 C구역 04열 005번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (491, 3, '2층 C구역 04열 006번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (492, 3, '2층 C구역 04열 007번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (493, 3, '2층 C구역 04열 008번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (494, 3, '2층 C구역 04열 009번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (495, 3, '2층 C구역 04열 010번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (496, 3, '2층 A구역 05열 001번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (497, 3, '2층 A구역 05열 002번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (498, 3, '2층 A구역 05열 003번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (499, 3, '2층 A구역 05열 004번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (500, 3, '2층 A구역 05열 005번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (501, 3, '2층 A구역 05열 006번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (502, 3, '2층 A구역 05열 007번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (503, 3, '2층 A구역 05열 008번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (504, 3, '2층 A구역 05열 009번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (505, 3, '2층 A구역 05열 010번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (506, 3, '2층 B구역 05열 001번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (507, 3, '2층 B구역 05열 002번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (508, 3, '2층 B구역 05열 003번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (509, 3, '2층 B구역 05열 004번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (510, 3, '2층 B구역 05열 005번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (511, 3, '2층 B구역 05열 006번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (512, 3, '2층 B구역 05열 007번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (513, 3, '2층 B구역 05열 008번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (514, 3, '2층 B구역 05열 009번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (515, 3, '2층 B구역 05열 010번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (516, 3, '2층 B구역 05열 011번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (517, 3, '2층 B구역 05열 012번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (518, 3, '2층 B구역 05열 013번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (519, 3, '2층 B구역 05열 014번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (520, 3, '2층 B구역 05열 015번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (521, 3, '2층 C구역 05열 001번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (522, 3, '2층 C구역 05열 002번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (523, 3, '2층 C구역 05열 003번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (524, 3, '2층 C구역 05열 004번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (525, 3, '2층 C구역 05열 005번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (526, 3, '2층 C구역 05열 006번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (527, 3, '2층 C구역 05열 007번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (528, 3, '2층 C구역 05열 008번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (529, 3, '2층 C구역 05열 009번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (530, 3, '2층 C구역 05열 010번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (531, 3, '2층 A구역 06열 001번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (532, 3, '2층 A구역 06열 002번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (533, 3, '2층 A구역 06열 003번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (534, 3, '2층 A구역 06열 004번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (535, 3, '2층 A구역 06열 005번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (536, 3, '2층 A구역 06열 006번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (537, 3, '2층 A구역 06열 007번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (538, 3, '2층 A구역 06열 008번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (539, 3, '2층 A구역 06열 009번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (540, 3, '2층 A구역 06열 010번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (541, 3, '2층 B구역 06열 001번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (542, 3, '2층 B구역 06열 002번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (543, 3, '2층 B구역 06열 003번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (544, 3, '2층 B구역 06열 004번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (545, 3, '2층 B구역 06열 005번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (546, 3, '2층 B구역 06열 006번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (547, 3, '2층 B구역 06열 007번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (548, 3, '2층 B구역 06열 008번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (549, 3, '2층 B구역 06열 009번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (550, 3, '2층 B구역 06열 010번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (551, 3, '2층 B구역 06열 011번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (552, 3, '2층 B구역 06열 012번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (553, 3, '2층 B구역 06열 013번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (554, 3, '2층 B구역 06열 014번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (555, 3, '2층 B구역 06열 015번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (556, 3, '2층 C구역 06열 001번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (557, 3, '2층 C구역 06열 002번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (558, 3, '2층 C구역 06열 003번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (559, 3, '2층 C구역 06열 004번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (560, 3, '2층 C구역 06열 005번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (561, 3, '2층 C구역 06열 006번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (562, 3, '2층 C구역 06열 007번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (563, 3, '2층 C구역 06열 008번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (564, 3, '2층 C구역 06열 009번', 0, 1);
INSERT INTO YES_SHOW_SEAT (SEAT_ID, seattype_id, SEAT_NAME, SEAT_STATUS, date_id) VALUES (565, 3, '2층 C구역 06열 010번', 0, 1);
commit;



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
,constraint FK_status_id_rev foreign key(status_id) references yes_status(status_id) on delete cascade
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
values(seq_reserve.nextval, 1, 1, 1, 1, 'hyunho2005@naver.com', 2, 50000, 0, 0, 0);

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
values(seq_reserve.nextval, 1, 1, 1, 1, 'hyunho2005@naver.com', 2, 50000, 0, 0, 0);



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

drop view view_seat_info;
create or replace view view_seat_info
AS
select S.seattype_id, S.seat_name, S.seat_status, T.prod_id, T.seat_type, T.seat_price, S.date_id, T.seat_color
from yes_show_seat S
join yes_seat_type T
on S.seattype_id = T.seattype_id;

select date_id, prod_id, seattype_id, seat_type, seat_name, seat_price, seat_status, date_id
from view_seat_info
where prod_id = 1;

select date_id
from yes_show_date
where prod_id=1 and to_char(date_showday, 'yy/mm/dd') || ' ' || to_char(date_showday, 'day')='20/09/01 화요일' and date_showtime = '1회차 9시';

select date_id, prod_id, seattype_id, seat_type, seat_name, seat_price, seat_status, date_id, seat_color
from view_seat_info
where prod_id = 1;