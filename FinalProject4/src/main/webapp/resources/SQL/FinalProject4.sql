Skip to content
Search or jump to…

Pull requests
Issues
Marketplace
Explore

@hppngRh
haileychoi15
/
yes24-ticket
0
11
Code
Issues
Pull requests
Actions
Projects
Wiki
Security
Insights
yes24-ticket/FinalProject4/src/main/webapp/resources/SQL/FinalProject4.sql
@SHINHyeonHo
SHINHyeonHo 0815
…
Latest commit 35ca81d 3 hours ago
 History
 4 contributors
@SHINHyeonHo@seulkimekim@jinyoung10@haileychoi15
824 lines (757 sloc)  69.1 KB

--- **** FinalProject Team 4 - YES 24 **** ----

SELECT  'DROP TABLE ' || object_name || ' CASCADE CONSTRAINTS;'
FROM    user_objects
WHERE   object_type = 'TABLE';



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

alter user finalorauser4 indentified by eclass;

CREATE USER finalorauser4 IDENTIFIED BY eclass
    DEFAULT TABLESPACE USERS;
--계정명, 암호, 저장공간 부여
GRANT CONNECT, RESOURCE TO finalorauser4;
--ROLE부여
GRANT UNLIMITED TABLESPACE TO finalorauser4;
--TABLESPACE 부여

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
    ,pwd                varchar2(200)  not null       -- 비밀번호 (SHA-256 암호화 대상)
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
    ,isSMS              varchar2(1) default '0'       -- sms 수신 여부
    ,isEMAIL            varchar2(1) default '0'       -- email 수신 여부
    ,sessionKey         varchar2(100) default 'none'  -- 로그인 유지시 세션 저장
    ,sessionLimit       timestamp
    ,constraint   PK_yes_member_idx primary key(idx)
    ,constraint   UK_yes_member_userid unique(userid)
    ,constraint   CK_yes_member_gender check( gender in('1','2') )
    ,constraint   CK_yes_member_status check( status in('0','1') )
    ,constraint   CK_yes_member_kakao check( status in('0','1') )
    ,constraint   CK_yes_member_isSMS check( status in('0','1') )
    ,constraint   CK_yes_member_isEMAIL check( status in('0','1') )
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
values(seq_member.nextval, 'guzi10', '김진영', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', 'KaDz2RcfIWg51HF/fFWvOxLoX5Y6H9S5+AmisF8ovv0=' , '010', '5vlo5ZBnIbLMyMz3NtK38A==', 'TYENQOsy0AExa9/mtma0ow==', '50234', '서울 송파구 오금로 95', '337동 708호', '오금동 현대아파트', '1', '19960920', default, default, default, default, default, default, '127.0.0.1', '1', default);

update yes_member
set point = 1000
where userid = 'guzi10';

select * from yes_member;
delete from yes_member;
commit;

----------------------------------- 공연 테이블 - Show -----------------------------------
-- 카테고리 테이블
drop table yes_show_category cascade constraints purge;
create table yes_show_category
(category_id    number(10)      not null    -- 카테고리 코드
    ,category_name  varchar2(20)    not null    -- 카테고리 명
    ,constraint PK_category_id primary key (category_id)
);

select category_name
from yes_show_category
where category_id = 1;

drop sequence seq_show_category;
create sequence seq_show_category
    start with 1
    increment by 1
    nomaxvalue
    nominvalue
    nocycle
    nocache;

insert into yes_show_category(category_id, category_name)
values(1,'콘서트');
insert into yes_show_category(category_id, category_name)
values(2,'뮤지컬');
insert into yes_show_category(category_id, category_name)
values(3,'연극');
insert into yes_show_category(category_id, category_name)
values(4,'클래식');
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

select *
from yes_show_category_detail

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
    ,constraint FK_category_id_prod foreign key(fk_category_id) references yes_show_category(category_id)
    ,constraint FK_category_detail_id foreign key(fk_category_detail_id) references yes_show_category_detail(category_detail_id)
);

drop sequence seq_show;
create sequence seq_show
    start with 1
    increment by 1
    nomaxvalue
    nominvalue
    nocycle
    nocache;

alter table prod
    add status number(1) default 1;

alter table prod
    add map_id number(10) default '1';

update prod set prod_img = replace(prod_img,'FinalProject4/src/main/webapp/resources/images/','');
update prod set prod_detail_img = replace(prod_detail_img,'FinalProject4/src/main/webapp/resources/images/','');

select prod_id, C.category_name, fk_category_id, prod_title,prod_img, prod_detail_img,info_open_date,
       info_close_date,info_rev_status,info_grade,info_run_time,info_qnty
from prod P join  yes_show_category C
                  on P. fk_category_id = C.category_id;
-- 공연 테이블 임시

select *
from prod;

select prod_id, fk_category_id, fk_category_detail_id, prod_title, prod_img, prod_detail_img, date_start, date_end
     , info_open_date, info_close_date, info_rev_status, info_grade, info_run_time, info_qnty, status, map_id
from prod
where fk_category_id = 1
order by info_qnty desc;

select *
from yes_show_category_detail;

insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(1,1,2,'썸머클래식 Summer Classics','FinalProject4/src/main/webapp/resources/images/classic/classic_01m.jpg','FinalProject4/src/main/webapp/resources/images/classic/classic_01L.jpg',to_date('2020/06/01','yyyy/mm/dd'),to_date('2020/09/01','yyyy/mm/dd'),1,'12세 이상','100분',default);
--세종문화회관 M씨어터
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(2,1,2,'피들스 스트링 앙상블','FinalProject4/src/main/webapp/resources/images/classic/classic_02m.jpg','FinalProject4/src/main/webapp/resources/images/classic/classic_02L.jpg',to_date('2020/08/01','yyyy/mm/dd'),to_date('2020/08/01','yyyy/mm/dd'),1,'7세 이상','75분',default);
--광림아트센터 장천홀
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(3,1,2,'2020 교향악축제','FinalProject4/src/main/webapp/resources/images/classic/classic_03m.jpg','FinalProject4/src/main/webapp/resources/images/classic/classic_03L.jpg',to_date('2020/08/09','yyyy/mm/dd'),to_date('2020/08/09','yyyy/mm/dd'),1,'8세 이상','120분',default);
--예술의전당 콘서트홀
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(4,1,2,'어니스트 필하모닉 오케스트라 제1회 정기연주회','FinalProject4/src/main/webapp/resources/images/classic/classic_04m.jpg','FinalProject4/src/main/webapp/resources/images/classic/classic_04L.jpg',to_date('2020/08/08','yyyy/mm/dd'),to_date('2020/08/08','yyyy/mm/dd'),1,'8세 이상','95분',default);
--광림아트센터 장천홀
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(5,1,2,'오르간 오딧세이','FinalProject4/src/main/webapp/resources/images/classic/classic_05m.jpg','FinalProject4/src/main/webapp/resources/images/classic/classic_05L.jpg',to_date('2020/07/28','yyyy/mm/dd'),to_date('2020/12/22','yyyy/mm/dd'),1,'6세 이상','70분',default);
--롯데 콘서트홀
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(6,1,2,'57회 정기공연 <토스카>','FinalProject4/src/main/webapp/resources/images/classic/classic_06m.jpg','FinalProject4/src/main/webapp/resources/images/classic/classic_06L.jpg',to_date('2020/11/11','yyyy/mm/dd'),to_date('2020/11/15','yyyy/mm/dd'),1,'7세 이상','70분',default);
--세종문화회관 대극장
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(7,1,3,'레드 슈즈','FinalProject4/src/main/webapp/resources/images/classic/classic_07m.jpg','FinalProject4/src/main/webapp/resources/images/classic/classic_07L.jpg',to_date('2020/09/04','yyyy/mm/dd'),to_date('2020/09/05','yyyy/mm/dd'),1,'8세 이상','120분',default);
--예술의전당 CJ토월극장
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(8,1,2,'서울시오페라단 2020 <세비야의 이발사>','FinalProject4/src/main/webapp/resources/images/classic/classic_08m.jpg','FinalProject4/src/main/webapp/resources/images/classic/classic_08L.jpg',to_date('2020/08/18','yyyy/mm/dd'),to_date('2020/08/22','yyyy/mm/dd'),1,'5세 이상','150분',default);
--세종문화회관 M씨어터
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(9,1,2,'토요일 오후의 클래식','FinalProject4/src/main/webapp/resources/images/classic/classic_09m.jpg','FinalProject4/src/main/webapp/resources/images/classic/classic_09L.jpg',to_date('2020/01/04','yyyy/mm/dd'),to_date('2020/12/19','yyyy/mm/dd'),1,'성인','120분',default);
--kt chamberhall
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(10,1,4,'파이낸셜뉴스 창간 20주년 기념 음악회','FinalProject4/src/main/webapp/resources/images/classic/classic_10m.jpg','FinalProject4/src/main/webapp/resources/images/classic/classic_10L.jpg',to_date('2020/07/31','yyyy/mm/dd'),to_date('2020/07/31','yyyy/mm/dd'),1,'7세 이상','120분',default);
--롯데 콘서트홀
commit;

insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(11,1,6,'가을방학 정규 4집 발매 기념 공연[세상은 한 장의 손수건]','FinalProject4/src/main/webapp/resources/images/concert/concert_01m.jpg','FinalProject4/src/main/webapp/resources/images/concert/concert_01L.jpg',to_date('2020/06/01','yyyy/mm/dd'),to_date('2020/09/01','yyyy/mm/dd'),1,'12세 이상','100분',default);
--노들섬 라이브 하우스
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(12,2,8,'2020 WILD KARD IN SEOUL','FinalProject4/src/main/webapp/resources/images/concert/concert_02m.jpg','FinalProject4/src/main/webapp/resources/images/concert/concert_02L.jpg',to_date('2020/08/01','yyyy/mm/dd'),to_date('2020/08/01','yyyy/mm/dd'),1,'7세 이상','75분',default);
--노들섬 라이브 하우스
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(13,2,8,'2020 DMZPOP DRIVE IN CONECERT in CHOELWON','FinalProject4/src/main/webapp/resources/images/concert/concert_03m.jpg','FinalProject4/src/main/webapp/resources/images/concert/concert_03L.jpg',to_date('2020/08/09','yyyy/mm/dd'),to_date('2020/08/09','yyyy/mm/dd'),1,'8세 이상','120분',default);
--김화생활체육공원 특설무대
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(14,2,8,'SURL concert <Ah, ah, What can I do?>','FinalProject4/src/main/webapp/resources/images/concert/concert_04m.jpg','FinalProject4/src/main/webapp/resources/images/concert/concert_04L.jpg',to_date('2020/08/08','yyyy/mm/dd'),to_date('2020/08/08','yyyy/mm/dd'),1,'8세 이상','95분',default);
--노들섬 라이브 하우스
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(15,2,6,'팬텀싱어3 콘서트','FinalProject4/src/main/webapp/resources/images/concert/concert_05m.jpg','FinalProject4/src/main/webapp/resources/images/concert/concert_05L.jpg',to_date('2020/07/28','yyyy/mm/dd'),to_date('2020/12/22','yyyy/mm/dd'),1,'6세 이상','70분',default);
--부산 벡스코 제1전시장 1홀
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(16,2,8,'그랜드 민트 페스티벌2020<공식티켓>','FinalProject4/src/main/webapp/resources/images/concert/concert_06m.jpg','FinalProject4/src/main/webapp/resources/images/concert/concert_06L.jpg',to_date('2020/11/11','yyyy/mm/dd'),to_date('2020/11/15','yyyy/mm/dd'),1,'7세 이상','70분',default);
--세종문화회관 대극장
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(17,2,7,'팬타스틱 팬미팅 콘서트','FinalProject4/src/main/webapp/resources/images/concert/concert_07m.jpg','FinalProject4/src/main/webapp/resources/images/concert/concert_07L.jpg',to_date('2020/09/04','yyyy/mm/dd'),to_date('2020/09/05','yyyy/mm/dd'),1,'8세 이상','120분',default);
--노들섬 라이브 하우스
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(18,2,6,'포레스텔라 콘서트 <넬라판타지아>','FinalProject4/src/main/webapp/resources/images/concert/concert_08m.jpg','FinalProject4/src/main/webapp/resources/images/concert/concert_08L.jpg',to_date('2020/08/18','yyyy/mm/dd'),to_date('2020/08/22','yyyy/mm/dd'),1,'5세 이상','150분',default);
--세종문화회관 M씨어터
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(19,2,7,'엔니오 모리꼬네 시네콘서트','FinalProject4/src/main/webapp/resources/images/concert/concert_09m.jpg','FinalProject4/src/main/webapp/resources/images/concert/concert_09L.jpg',to_date('2020/01/04','yyyy/mm/dd'),to_date('2020/12/19','yyyy/mm/dd'),1,'성인','120분',default);
--예술의전당 오페라극장
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(20,2,8,'그린플러그드 경주 2020','FinalProject4/src/main/webapp/resources/images/concert/concert_10m.jpg','FinalProject4/src/main/webapp/resources/images/concert/concert_10L.jpg',to_date('2020/07/31','yyyy/mm/dd'),to_date('2020/07/31','yyyy/mm/dd'),1,'7세 이상','120분',default);
--롯데 콘서트홀
commit;

insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(21,3,12,'뮤지컬 [라 루미에르]','FinalProject4/src/main/webapp/resources/images/musical/musical_01m.jpg','FinalProject4/src/main/webapp/resources/images/musical/musical_01L.jpg',to_date('2020/06/01','yyyy/mm/dd'),to_date('2020/09/01','yyyy/mm/dd'),1,'12세 이상','100분',default);
--대학로 유니플렉스 2관
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(22,3,10,'뮤지컬 <머더발라드>','FinalProject4/src/main/webapp/resources/images/musical/musical_02m.jpg','FinalProject4/src/main/webapp/resources/images/musical/musical_02L.jpg',to_date('2020/08/01','yyyy/mm/dd'),to_date('2020/08/01','yyyy/mm/dd'),1,'7세 이상','75분',default);
--세종문화회관 S씨어터
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(23,3,11,'뮤지컬<더 모먼트>','FinalProject4/src/main/webapp/resources/images/musical/musical_03m.jpg','FinalProject4/src/main/webapp/resources/images/musical/musical_03L.jpg',to_date('2020/08/09','yyyy/mm/dd'),to_date('2020/08/09','yyyy/mm/dd'),1,'8세 이상','120분',default);
--대학로 유니플렉스 2관
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(24,3,12,'뮤지컬<베르테르>','FinalProject4/src/main/webapp/resources/images/musical/musical_04m.jpg','FinalProject4/src/main/webapp/resources/images/musical/musical_04L.jpg',to_date('2020/08/08','yyyy/mm/dd'),to_date('2020/08/08','yyyy/mm/dd'),1,'8세 이상','95분',default);
--광림아트센터 BBCH홀
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(25,3,11,'뮤지컬<캣츠> 40주년 내한공연 - 서울','FinalProject4/src/main/webapp/resources/images/musical/musical_05m.jpg','FinalProject4/src/main/webapp/resources/images/musical/musical_05L.jpg',to_date('2020/07/28','yyyy/mm/dd'),to_date('2020/12/22','yyyy/mm/dd'),1,'6세 이상','70분',default);
--샤롯데 씨어터
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(26,3,11,'뮤지컬 <오페라의 유령> 월드투어','FinalProject4/src/main/webapp/resources/images/musical/musical_06m.jpg','FinalProject4/src/main/webapp/resources/images/musical/musical_06L.jpg',to_date('2020/11/11','yyyy/mm/dd'),to_date('2020/11/15','yyyy/mm/dd'),1,'7세 이상','70분',default);
--블루스퀘어 인터파크홀
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(27,3,12,'뮤지컬 <어쩌면 해피엔딩> 2020','FinalProject4/src/main/webapp/resources/images/musical/musical_07m.jpg','FinalProject4/src/main/webapp/resources/images/musical/musical_07L.jpg',to_date('2020/09/04','yyyy/mm/dd'),to_date('2020/09/05','yyyy/mm/dd'),1,'8세 이상','120분',default);
--예스24스테이지 1관
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(28,3,11,'뮤지컬 펀홈(FUN HOME)','FinalProject4/src/main/webapp/resources/images/musical/musical_08m.jpg','FinalProject4/src/main/webapp/resources/images/musical/musical_08L.jpg',to_date('2020/08/18','yyyy/mm/dd'),to_date('2020/08/22','yyyy/mm/dd'),1,'5세 이상','150분',default);
--동국대학교 이해랑 예술극장
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(29,3,10,'Musical 유앤잇 <YOU & IT>','FinalProject4/src/main/webapp/resources/images/musical/musical_09m.jpg','FinalProject4/src/main/webapp/resources/images/musical/musical_09L.jpg',to_date('2020/01/04','yyyy/mm/dd'),to_date('2020/12/19','yyyy/mm/dd'),1,'성인','120분',default);
--대학로 드림아트센터 2관
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(30,3,11,'뮤지컬 <브로드웨이42번가>','FinalProject4/src/main/webapp/resources/images/musical/musical_10m.jpg','FinalProject4/src/main/webapp/resources/images/musical/musical_10L.jpg',to_date('2020/07/31','yyyy/mm/dd'),to_date('2020/07/31','yyyy/mm/dd'),1,'7세 이상','120분',default);
--부산 소향씨어터 신한카드홀
commit;

insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(31,4,15,'연극 [라스트 세션] Last Session','FinalProject4/src/main/webapp/resources/images/theater/theater_01m.jpg','FinalProject4/src/main/webapp/resources/images/theater/theater_01L.jpg',to_date('2020/06/01','yyyy/mm/dd'),to_date('2020/09/01','yyyy/mm/dd'),1,'12세 이상','100분',default);
--예스24스테이지 3관
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(32,4,16,'2020 밀양공연예술축제 [한 여름 밤의 꿈]','FinalProject4/src/main/webapp/resources/images/theater/theater_02m.jpg','FinalProject4/src/main/webapp/resources/images/theater/theater_02L.jpg',to_date('2020/08/01','yyyy/mm/dd'),to_date('2020/08/01','yyyy/mm/dd'),1,'7세 이상','75분',default);
--밀양아리랑아트센터 대극장
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(33,4,15,'연극 [연애하기좋은날]','FinalProject4/src/main/webapp/resources/images/theater/theater_03m.jpg','FinalProject4/src/main/webapp/resources/images/theater/theater_03L.jpg',to_date('2020/08/09','yyyy/mm/dd'),to_date('2020/08/09','yyyy/mm/dd'),1,'8세 이상','120분',default);
--BNK부산은행 조은극장 1관
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(34,4,15,'레미제라블','FinalProject4/src/main/webapp/resources/images/theater/theater_04m.jpg','FinalProject4/src/main/webapp/resources/images/theater/theater_04L.jpg',to_date('2020/08/08','yyyy/mm/dd'),to_date('2020/08/08','yyyy/mm/dd'),1,'8세 이상','95분',default);
--예술의전당 CJ 토월극장
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(35,4,16,'세종시문화재단 2020 공연장상주 단체 페스티벌','FinalProject4/src/main/webapp/resources/images/theater/theater_05m.jpg','FinalProject4/src/main/webapp/resources/images/theater/theater_05L.jpg',to_date('2020/07/28','yyyy/mm/dd'),to_date('2020/12/22','yyyy/mm/dd'),1,'6세 이상','70분',default);
--세종시문화예술회관
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(36,4,16,'2020 대한민국소극장 열전연극[인간의 무늬]','FinalProject4/src/main/webapp/resources/images/theater/theater_06m.jpg','FinalProject4/src/main/webapp/resources/images/theater/theater_06L.jpg',to_date('2020/11/11','yyyy/mm/dd'),to_date('2020/11/15','yyyy/mm/dd'),1,'7세 이상','70분',default);
--구미 소극장[공터_다]
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(37,4,15,'연극 [미래의 여름]','FinalProject4/src/main/webapp/resources/images/theater/theater_07m.jpg','FinalProject4/src/main/webapp/resources/images/theater/theater_07L.jpg',to_date('2020/09/04','yyyy/mm/dd'),to_date('2020/09/05','yyyy/mm/dd'),1,'8세 이상','120분',default);
--대학로 나온씨어터
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(38,4,15,'연극 [미스터얼간이]','FinalProject4/src/main/webapp/resources/images/theater/theater_08m.jpg','FinalProject4/src/main/webapp/resources/images/theater/theater_08L.jpg',to_date('2020/08/18','yyyy/mm/dd'),to_date('2020/08/22','yyyy/mm/dd'),1,'5세 이상','150분',default);
--BNK부산은행조은극장 2관
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(39,4,15,'나의 PS 파트너','FinalProject4/src/main/webapp/resources/images/theater/theater_09m.jpg','FinalProject4/src/main/webapp/resources/images/theater/theater_09L.jpg',to_date('2020/01/04','yyyy/mm/dd'),to_date('2020/12/19','yyyy/mm/dd'),1,'성인','120분',default);
--대구 여우별아트홀
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(40,4,15,'코믹추리극 행오버 - 해피씨어터','FinalProject4/src/main/webapp/resources/images/theater/theater_10m.jpg','FinalProject4/src/main/webapp/resources/images/theater/theater_10L.jpg',to_date('2020/07/31','yyyy/mm/dd'),to_date('2020/07/31','yyyy/mm/dd'),1,'7세 이상','120분',default);
--대학로 해피씨어터
commit;

insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(41,5,18,'완전한세상','FinalProject4/src/main/webapp/resources/images/exhibition/exhibition_01m.jpg','FinalProject4/src/main/webapp/resources/images/exhibition/exhibition_01L.jpg',to_date('2020/06/01','yyyy/mm/dd'),to_date('2020/09/01','yyyy/mm/dd'),1,'12세 이상','100분',default);
--뮤지엄 다
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(42,5,19,'[세종/전시] 브릭라이브 전시 체험','FinalProject4/src/main/webapp/resources/images/exhibition/exhibition_02m.jpg','FinalProject4/src/main/webapp/resources/images/exhibition/exhibition_02L.jpg',to_date('2020/08/01','yyyy/mm/dd'),to_date('2020/08/01','yyyy/mm/dd'),1,'7세 이상','75분',default);
--밀양아리랑아트센터 대극장
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(43,5,19,'암흑카페 1인 이용권','FinalProject4/src/main/webapp/resources/images/exhibition/exhibition_03m.jpg','FinalProject4/src/main/webapp/resources/images/exhibition/exhibition_03L.jpg',to_date('2020/08/09','yyyy/mm/dd'),to_date('2020/08/09','yyyy/mm/dd'),1,'8세 이상','120분',default);
--신촌 암흑카페
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(44,5,20,'양양 쏠비치 서핑스쿨 이용권','FinalProject4/src/main/webapp/resources/images/exhibition/exhibition_04m.jpg','FinalProject4/src/main/webapp/resources/images/exhibition/exhibition_04L.jpg',to_date('2020/08/08','yyyy/mm/dd'),to_date('2020/08/08','yyyy/mm/dd'),1,'8세 이상','95분',default);
--양양 쏠비치 아쿠아월드
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(45,5,18,'더에천 두번째 에피소드 삼강명탐정:죽은자들의 원혼','FinalProject4/src/main/webapp/resources/images/exhibition/exhibition_05m.jpg','FinalProject4/src/main/webapp/resources/images/exhibition/exhibition_05L.jpg',to_date('2020/07/28','yyyy/mm/dd'),to_date('2020/12/22','yyyy/mm/dd'),1,'6세 이상','70분',default);
--예천 삼강문화단지 내
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(46,5,18,'2020 경기전 왕과의 산책','FinalProject4/src/main/webapp/resources/images/exhibition/exhibition_06m.jpg','FinalProject4/src/main/webapp/resources/images/exhibition/exhibition_06L.jpg',to_date('2020/11/11','yyyy/mm/dd'),to_date('2020/11/15','yyyy/mm/dd'),1,'7세 이상','70분',default);
--전주학옥마을 경기전
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(47,5,20,'거제오션어드벤처','FinalProject4/src/main/webapp/resources/images/exhibition/exhibition_07m.jpg','FinalProject4/src/main/webapp/resources/images/exhibition/exhibition_07L.jpg',to_date('2020/09/04','yyyy/mm/dd'),to_date('2020/09/05','yyyy/mm/dd'),1,'8세 이상','120분',default);
--거제오션어드벤처
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(48,5,19,'경복궁의 인문학산책','FinalProject4/src/main/webapp/resources/images/exhibition/exhibition_08m.jpg','FinalProject4/src/main/webapp/resources/images/exhibition/exhibition_08L.jpg',to_date('2020/08/18','yyyy/mm/dd'),to_date('2020/08/22','yyyy/mm/dd'),1,'5세 이상','150분',default);
--경복궁
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(49,5,20,'경주대명아쿠아월드','FinalProject4/src/main/webapp/resources/images/exhibition/exhibition_09m.jpg','FinalProject4/src/main/webapp/resources/images/exhibition/exhibition_09L.jpg',to_date('2020/01/04','yyyy/mm/dd'),to_date('2020/12/19','yyyy/mm/dd'),1,'8세 이상','120분',default);
--경주대명아쿠아월드
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(50,5,19,'국가대표궁궐,경복궁','FinalProject4/src/main/webapp/resources/images/exhibition/exhibition_10m.jpg','FinalProject4/src/main/webapp/resources/images/exhibition/exhibition_10L.jpg',to_date('2020/07/31','yyyy/mm/dd'),to_date('2020/07/31','yyyy/mm/dd'),1,'7세 이상','120분',default);
--경복궁
commit;

insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(51,6,22,'완전한세상','FinalProject4/src/main/webapp/resources/images/theater/theater_01m.jpg','FinalProject4/src/main/webapp/resources/images/theater/theater_01L.jpg',to_date('2020/06/01','yyyy/mm/dd'),to_date('2020/09/01','yyyy/mm/dd'),1,'12세 이상','100분',default);
--뮤지엄 다
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(52,6,23,'[세종/전시] 브릭라이브 전시 체험','FinalProject4/src/main/webapp/resources/images/theater/theater_02m.jpg','FinalProject4/src/main/webapp/resources/images/theater/theater_02L.jpg',to_date('2020/08/01','yyyy/mm/dd'),to_date('2020/08/01','yyyy/mm/dd'),1,'7세 이상','75분',default);
--밀양아리랑아트센터 대극장
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(53,6,22,'암흑카페 1인 이용권','FinalProject4/src/main/webapp/resources/images/theater/theater_03m.jpg','FinalProject4/src/main/webapp/resources/images/theater/theater_03L.jpg',to_date('2020/08/09','yyyy/mm/dd'),to_date('2020/08/09','yyyy/mm/dd'),1,'8세 이상','120분',default);
--신촌 암흑카페
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(54,6,22,'양양 쏠비치 서핑스쿨 이용권','FinalProject4/src/main/webapp/resources/images/theater/theater_04m.jpg','FinalProject4/src/main/webapp/resources/images/theater/theater_04L.jpg',to_date('2020/08/08','yyyy/mm/dd'),to_date('2020/08/08','yyyy/mm/dd'),1,'8세 이상','95분',default);
--양양 쏠비치 아쿠아월드
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(55,6,23,'더에천 두번째 에피소드 삼강명탐정:죽은자들의 원혼','FinalProject4/src/main/webapp/resources/images/theater/theater_05m.jpg','FinalProject4/src/main/webapp/resources/images/theater/theater_05L.jpg',to_date('2020/07/28','yyyy/mm/dd'),to_date('2020/12/22','yyyy/mm/dd'),1,'6세 이상','70분',default);
--예천 삼강문화단지 내
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(56,6,22,'2020 경기전 왕과의 산책','FinalProject4/src/main/webapp/resources/images/theater/theater_06m.jpg','FinalProject4/src/main/webapp/resources/images/theater/theater_06L.jpg',to_date('2020/11/11','yyyy/mm/dd'),to_date('2020/11/15','yyyy/mm/dd'),1,'7세 이상','70분',default);
--전주한옥마을 경기전
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(57,6,23,'거제오션어드벤처','FinalProject4/src/main/webapp/resources/images/theater/theater_07m.jpg','FinalProject4/src/main/webapp/resources/images/theater/theater_07L.jpg',to_date('2020/09/04','yyyy/mm/dd'),to_date('2020/09/05','yyyy/mm/dd'),1,'8세 이상','120분',default);
--거제오션어드벤처
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(58,6,23,'경복궁의 인문학산책','FinalProject4/src/main/webapp/resources/images/theater/theater_08m.jpg','FinalProject4/src/main/webapp/resources/images/theater/theater_08L.jpg',to_date('2020/08/18','yyyy/mm/dd'),to_date('2020/08/22','yyyy/mm/dd'),1,'5세 이상','150분',default);
--경복궁
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(59,6,22,'경주대명아쿠아월드','FinalProject4/src/main/webapp/resources/images/theater/theater_09m.jpg','FinalProject4/src/main/webapp/resources/images/theater/theater_09L.jpg',to_date('2020/01/04','yyyy/mm/dd'),to_date('2020/12/19','yyyy/mm/dd'),1,'8세 이상','120분',default);
--경주대명아쿠아월드
insert into prod(prod_id, fk_category_id, fk_category_detail_id, prod_title,prod_img, prod_detail_img,info_open_date,
                 info_close_date,info_rev_status,info_grade,info_run_time,info_qnty)
values(60,6,22,'국가대표궁궐,경복궁','FinalProject4/src/main/webapp/resources/images/theater/theater_10m.jpg','FinalProject4/src/main/webapp/resources/images/theater/theater_10L.jpg',to_date('2020/07/31','yyyy/mm/dd'),to_date('2020/07/31','yyyy/mm/dd'),1,'7세 이상','120분',default);
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


create or replace view view_rev_showInfo
AS
select P.prod_id, P.prod_img, P.prod_title, P.info_grade, P.info_run_time, M.map_name
                               from prod P
JOIN yes_show_map M
ON P.map_id = M.map_id;