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
                <input name="search-word" type="text" class="search-word">
                <button type="button" class="search-button">검색</button>
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
                                구분
                            </span>
                            <span class="table-title">
                                제목
                            </span>
                            <span class="table-date">
                                날짜
                            </span>
                            <span class="table-view">
                                조회수
                            </span>
                            <span class="table-file">
                                첨부파일
                            </span>
                        </div>
                    </div>
                    <div class="tbody">
                        <div class="row">
                            <span class="table-category">
                                티켓오픈
                            </span>
                            <span class="table-title">
                                <a href="#">
                                    TICKET24 서비스 이용약관 변경 안내
                                </a>
                            </span>
                            <span class="table-date">
                                2020-07-15
                            </span>
                            <span class="table-view">
                                0
                            </span>
                            <span class="table-file yes">

                            </span>
                        </div>
                        <div class="row">
                            <span class="table-category">
                                티켓오픈
                            </span>
                            <span class="table-title">
                                <a href="#">
                                    TICKET24 Drive DB 교체 작업으로 인한 드라이브 서비스 이용 제한 안내
                                </a>
                            </span>
                            <span class="table-date">
                                2020-06-30
                            </span>
                            <span class="table-view">
                                0
                            </span>
                            <span class="table-file yes">

                            </span>
                        </div>
                        <div class="row">
                            <span class="table-category">
                                티켓오픈
                            </span>
                            <span class="table-title">
                                <a href="#">
                                    TICKET24 비정기 업데이트 소식
                                </a>
                            </span>
                            <span class="table-date">
                                2020-06-21
                            </span>
                            <span class="table-view">
                                0
                            </span>
                            <span class="table-file">

                            </span>
                        </div>
                        <div class="row">
                            <span class="table-category">
                                티켓오픈
                            </span>
                            <span class="table-title">
                                <a href="#">
                                    TICKET24 점검 안내 1차
                                </a>
                            </span>
                            <span class="table-date">
                                2020-06-18
                            </span>
                            <span class="table-view">
                                0
                            </span>
                            <span class="table-file">

                            </span>
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
</body>
</html>