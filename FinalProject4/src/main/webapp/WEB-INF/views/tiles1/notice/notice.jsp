<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notice page</title>
    <link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="resources/css/grid.min.css">
    <link rel="stylesheet" href="resources/css/reset.css">
    <link rel="stylesheet" href="resources/css/notice.css">
    <script src="https://kit.fontawesome.com/5342aa1b58.js" crossorigin="anonymous"></script>
</head>
<body>
    <section class="search">
        <div class="search-group">
            <h1>공지사항</h1>
            <p>
                TICKET24의 업데이트 정보(서비스, 약관), 점검 공지 등 <br />
                다양한 소식들을 알려드립니다.
            </p>
            <form class="search-form">
                <input name="search-word" type="text">
                <button type="submit">검색</button>
            </form>
        </div>
    </section>
    <section class="qna">
        <div class="container">
            <div class="col-12">
                <h1>자주찾는 FAQ</h1>
            </div>
            <div class="col-12">
                <div class="table">
                    <div class="thead">
                        <div class="row">
                        	<span class="table-category">
                                카테고리
                            </span>
                            <span class="table-title">
                                제목
                            </span>
                            <span class="table-date">
                                날짜
                            </span>
                            <span class="table-readcount">
                                조회수
                            </span>
                            <span class="table-addfile">
                                첨부파일
                            </span>
                        </div>
                    </div>
                    <div class="tbody">
                        <div class="row">
                        	<span class="table-category">
                                [안내] 
                            </span>
                            <span class="table-title">
                                TICKET24 서비스 이용약관 변경 안내
                            </span>
                            <span class="table-date">
                                2020-07-15
                            </span>
                            <span class="table-readcount">
                                0
                            </span>
                            <span class="table-addfile">
                               	없음
                            </span>
                            <div class="table-content">
                                TICKET24를 이용해주시는 회원 여러분께 감사 드리며, TICKET24 이용약관의 개정과 관련하여 안내 말씀 드립니다.
                                지난 4월 2일 ‘개인정보취급방침’ 변경과 관련해서 공지를 해드린 것 처럼 Works Mobile Corporation 신설 및 업무 조정에 따라 2020년 7월 1일자로 서비스 제공 법인이 TICKET24 주식회사에서 TICKET24 Corporation으로 변경되었습니다.
                            </div>
                        </div>
                        <div class="row">
                        	<span class="table-category">
                                [안내] 
                            </span>
                            <span class="table-title">
                                TICKET24 Drive DB 교체 작업으로 인한 드라이브 서비스 이용 제한 안내
                            </span>
                            <span class="table-date">
                                2020-06-30
                            </span>
                            <span class="table-readcount">
                                0
                            </span>
                            <span class="table-addfile">
                               	없음
                            </span>
                            <div class="table-content">
                                TICKET24의 점검으로 인해 해당 시간 동안 서비스 이용이 제한되어 알려드립니다.
                                <br/>
                                1. 점검 시간  :  2020년 7월 10일 (화) 19:00~22:00
                                <br/>
                                2. 점검 내용: NAVER Works 서비스 정기 점검
                            </div>
                        </div>
                        <div class="row">
                            <span class="table-title">
                                [안내] TICKET24 비정기 업데이트 소식
                            </span>
                            <span class="table-date">
                                2020-06-21
                            </span>
                            <div class="table-content">
                                예매 건의 좌석 변경을 원하실 경우 재예매 하신 후 기존 예매를 취소해주셔야 합니다. 단, 취소 마감시간 전까지만 가능하며, 취소 시점에 따라 예매수수료가 환불되지 않으며 취소 수수료가 부과될 수있습니다.
                            </div>
                        </div>
                        <div class="row">
                            <span class="table-title">
                                [안내] TICKET24 점검 안내 1차
                            </span>
                            <span class="table-date">
                                2020-06-18
                            </span>
                            <div class="table-content">
                                TICKET24의 점검으로 인해 해당 시간 동안 Works 서비스 이용이 제한되어 알려드립니다.
                                <br/>
                                1. 점검 시간  :  2020년 7월 10일 (화) 19:00~22:00
                                <br/>
                                2. 점검 내용: NAVER Works 서비스 정기 점검
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-12">
                <div class="page-group">
                    <button type="button" class="page-button selected" aria-label="Go to page1">1</button>
                    <button type="button" class="page-button" aria-label="Go to page2">2</button>
                    <button type="button" class="page-button" aria-label="Go to page3">3</button>
                </div>
            </div>
        </div>
    </section>
    <script src="resources/js/notice.js"></script>
</body>
</html>