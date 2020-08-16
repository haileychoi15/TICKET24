<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notice page</title>
    <link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="resources/css/grid.min.css"> <%--###--%>
    <link rel="stylesheet" href="resources/css/reset.css"> <%--###--%>
    <link rel="stylesheet" href="resources/css/notice.css"> <%--###--%>
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
                    <button type="button" value="1" class="selected">등록순</button>
                    <button type="button" value="2" >티켓오픈데이</button>
                    <button type="button" value="3" >조회수</button>
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
                        <span class="table-date">
                                티켓오픈일자
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
        
        <%-- ### admin 으로 로그인했을 때만 공지등록 버튼 표시 --%>
        <c:if test="${sessionScope.loginuser.userid == 'admin'}">
	        <div>
	        	<button type="button" style="float:right;" onclick="location.href='noticeAdd.action'">공지등록</button>
	        </div>
        </c:if>
        
    </div>
</section>
<script src="resources/js/notice.js"></script> <%-- ### --%>
</body>
</html>