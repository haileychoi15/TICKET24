<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% String ctxPath = request.getContextPath(); %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QNA page</title>
    <link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="resources/css/grid.min.css"> <%--###--%>
    <link rel="stylesheet" href="resources/css/reset.css"> <%--###--%>
    <link rel="stylesheet" href="resources/css/qnaList.css"> <%--###--%>
    <script src="https://kit.fontawesome.com/5342aa1b58.js" crossorigin="anonymous"></script>
</head>
<body>

<section class="search">
    <div class="search-group">
        <h1>QNA 게시판</h1>
        <p>
            TICKET24의 업데이트 정보(서비스, 약관), 점검 공지 등 <br />
            다양한 소식들을 알려드립니다.
        </p>
        <div class="search-form">
            <input name="search-word" type="text" class="search-word">
            <button type="button" class="search-button">검색</button>
        </div>
    </div>
</section>
<section class="qna">
    <div class="container">
        <div class="col-12">
            <h1>자주찾는 FAQ</h1>
        </div>
        <div class="col-12">
            <h1>자주찾는 FAQ</h1>
            <div class="category">
                <div class="category-group">
                    <button type="button" value="0" class="selected">전체</button>
                    <button type="button" value="1" >예매/결제</button>
                    <button type="button" value="2" >티켓수령</button>
                    <button type="button" value="3" >취소/환불</button>
                    <button type="button" value="4" >기타</button>
                </div>
            </div>
        </div>
        <div class="col-12">
            <div class="table">
                <div class="no-result-notice hide">
                    <strong>검색 결과가 없습니다.</strong>
                </div>
                <div class="thead show">
                    <div class="row">
                        <span class="table-category">
                                구분
                        </span>
                        <span class="table-title">
                                제목
                        </span>
                        <span class="table-product">
                             예매공연
                        </span>
                        <span class="table-writer">
                                작성자
                        </span>
                        <span class="table-date">
                                문의일자
                        </span>
                        <span class="table-is-read">
                                읽음여부
                        </span>
                        <span class="table-is-answer">
                                답변여부
                        </span>
                
                    </div>
                </div>
                <div class="tbody">
                    <%--<div class="row">
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
                    </div>--%>
                </div>
            </div>
        </div>
        <div class="col-12">
            <div class="page-group">
                <span class="prev-group"></span>
                <span class="page-list">
                       <%-- <button type="button" class="page-button selected" aria-label="Go to page1">1</button>
                       <button type="button" class="page-button" aria-label="Go to page2">2</button>
                       <button type="button" class="page-button" aria-label="Go to page3">3</button> --%>
                   </span>
                <span class="next-group"></span>
            </div>
        </div>
    </div>
</section>


<script src="resources/js/qnaList.js"></script> <%--###--%>
</body>
</html>