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

----------------------------------- 회원 테이블 - User -----------------------------------
-- 회원 테이블 삭제
drop table yes_user cascade;
-- 회원 테이블 생성
create table yes_user
(user_idx           number(10)     not null       -- 회원번호(시퀀스로 데이터가 들어온다)
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
,gender             varchar2(1)                   -- 성별     남자 : 1 / 여자 : 2
,birthday           varchar2(8)                   -- 생년월일
,coin               number default 0              -- 코인액
,point              number default 0              -- 포인트 
,grade              varchar(1)                    -- 회원등급
,pointsum           number default 0              -- 누적포인트
,registerday        date default sysdate          -- 가입일자
,ok_sms             number(1)   not null          -- sms 수신 동의
,ok_email           number(1)   not null          -- email 수신 동의
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

-- 로그인 테이블 삭제
drop table yes_login cascade;

-- 로그인 테이블 생성
create table yes_login
(login_idx                number(10)     not null       -- 회원번호(시퀀스로 데이터가 들어온다)
,userid             varchar2(20)   not null       -- 회원아이디
,name               varchar2(30)   not null       -- 회원명
,pwd                varchar2(200)  default '0'    -- 비밀번호 (SHA-256 암호화 대상)
);



----------------------------------- 공연 테이블 - Show -----------------------------------
-- 공연 테이블
create table prod
(prod_id number
,fk_category_id number
,fk_category_detail_id varchar2(20)
,prod_title varchar2(20)
,prod_img varchar2(100)
,prod_deateil_img varchar2(100)
,prod_create_date  date
,constraint PK_prod_id primary key(prod_id)
--,constraint prod_fk_category_id foreign key(fk_category_id)references category(category_id)
--,constraint prod_fk_category_detail_id foreign key(fk_category_detail_id)references category(category_detail_id)
);

create table product_info
(info_id number                  --공연정보코드
,prod_fk_id                     --공연코드
,info_fk_open_date date         --티켓오픈일시
,info_fk_close_date date        --티켓마감일시
,info_status number             --예매가능상태
,info_grade varchar2(3)         --관람등급
,info_run_time varchar2(3)      --관람시간
,info_pr_open_date date         --공연오픈일자
,info_pr_close_date date        --공연마감일자
,info_place varchar2(30)        --장소
,info_prod_date date            --공연일시
,info_dday number default 0     --공연디데이
,info_image varchar2(100)       --공연정보(이미지)1
,info_image2 varchar2(100)      --공연정보(이미지)2
,info_qnty number default 0     -- 판매량
--,constraint PK_info_id primary key (id)
--,constraint FK_info_open_date foreign key(date)
--,constraint FK_info_close_date foreign key(date)
);

----------------------------------- 예매 테이블 - Reservation -----------------------------------