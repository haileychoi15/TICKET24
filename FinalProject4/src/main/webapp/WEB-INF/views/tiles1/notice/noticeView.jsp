<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
	String ctxPath = request.getContextPath();
	//		/finalproject4
%>

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="resources/css/grid.min.css">
    <link rel="stylesheet" href="resources/css/reset.css">
    <link rel="stylesheet" href="resources/css/noticedetail.css">
    <script src="https://kit.fontawesome.com/5342aa1b58.js" crossorigin="anonymous"></script>


<style type="text/css">
/* 
	body{margin-top: 116px;}
	
	.noti-tit-tag01 {
		border: 1px solid orange;
		color: orange; 
		font-size: 10pt;
		padding: 5px 10px;
		margin: 0 15px 35px 0;
		text-align: right;
	}
	
	.noti-content {
		margin: 0px auto;
		padding: 0;
		width: 80%;
		word-wrap: break-word; 
	}
	
	.noti-vt-open {
		line-height: 1;
		margin: 30px 0 0 0;
		padding: 20px 0 0 0;
		font-style: normal;
		vertical-align: baseline;
		outline: none;
		background: #fbe5d5;
		border: 1px solid #999;
		margin-top: -1px;
		height: 58px;
		font-size: 17px;
		font-weight: 700;
		vertical-align: middle;
	}
	
	.noti-vt-open > span:nth-child(1) em {
		inline-block;
	    height: 22px;
	    line-height: 22px;
	    padding-left: 32px;
	    color: #ec7d2c;
		background: url('http://tkfile.yes24.com/imgNew/sub/ico-rp-tko1.png') no-repeat;
		background-size: auto 100%;
	}
	
	.noti-vt-open > span {
		margin: 0px 44px;
		padding: 14px 0 0 0;
		vertical-align: middle;
	}
	
	.noti-view-date, .noti-view-date > span { 
		text-align: right;
		height: 30px;
		line-height: 30px;
		margin-bottom: 30px;
	}

	.noti-content img {
		text-align: center;
	}

	table, th, td, input, textarea {border: solid gray 1px;}
	
	#table, #table2 {border-collapse: collapse;
	 		         width: 900px;
	 		        }
	#table th, #table td{padding: 5px;}
	#table th{width: 120px; background-color: #DDDDDD;}
	#table td{width: 750px;}
	
	.long {width: 470px;}
	.short {width: 120px;}
	
	.move {cursor: pointer;}
	.moveColor {color: #660029; font-weight: bold;}
	
	a {text-decoration: none !important;}
	
	#star_grade a{
        text-decoration: none;
        color: gray;
    }
    
    #star_grade a.on{
        color: red;
    } */
    
    <%-- 
    .star-rating { width:205px; }
	.star-rating,.star-rating span { display:inline-block; height:39px; overflow:hidden; background:url(<%= ctxPath%>/resources/images/star.png)no-repeat; color: blue;}
	.star-rating span{ background-position:left bottom; line-height:0; vertical-align:top; }
     --%>
    <%-- .star-rating { width:103px; }
	.star-rating,.star-rating span { display:inline-block; height:19px; overflow:hidden; background:url(<%= ctxPath%>/resources/images/star_resize.png)no-repeat; color: blue;}
	.star-rating span{ background-position:left bottom; line-height:0; vertical-align:top; } --%>
	
</style>
<body>
    <section class="notice-header">
        <h1>공지사항</h1>
        <div class="container">
            <div class="row">
                <div class="col-12 col-md-6">
                    <div class="notice-title-group">
                        <strong>${notivo.no_cate_name}</strong>
                        <h2>${notivo.subject}</h2>
                    </div>
                </div>
                <div class="col-12 col-md-6">
                    <div class="notice-info">
                        <dl>
                            <dt>등록일</dt>
                            <dd>${notivo.regDate}</dd>
                        </dl>
                        <dl>
                            <dt>조회수</dt>
                            <dd>${notivo.readCount}</dd>
                        </dl>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <main class="main">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <c:if test="${notivo.orgFilename != null}">
                        <a href="download.action?seq=${notivo.notice_id}" class="notice-file-group">
                            <dl>
                                <dt>첨부파일</dt>
                                <dd>${notivo.orgFilename}</dd>
                                <dd>
                                    <c:if test="${notivo.fileSize >= 1048576}">
                                        <fmt:formatNumber value="${notivo.fileSize/(1024*1024)}" pattern=".00" /> mb
                                    </c:if>
                                    <c:if test="${notivo.fileSize >= 1024 && notivo.fileSize < 1048576}">
                                        <fmt:formatNumber value="${notivo.fileSize/1024}" pattern=".00" /> kb
                                    </c:if>
                                    <c:if test="${notivo.fileSize < 1024}">
                                        ${notivo.fileSize} bytes
                                    </c:if>
                                </dd>
                            </dl>
                        </a>
                    </c:if>
                </div>
            </div>
            <c:if test="${notivo.ticketopenday != ' '}">
                <div class="row product-group">
                    <div class="col-12 col-md-3">
                        <div class="ticket-open-image">
                        	<img src="resources/images/${notivo.prod_img}" alt="${notivo.subject}">
                            <%-- <c:if test="notivo.prod_id == '0'">
                        		<img src="http://tkfile.yes24.com/upload2/BoardNotice/202008/20200805/20200805-200.jpg" alt="${notivo.subject}">
                        	</c:if> --%>
                        </div>
                    </div>
                    <div class="col-12 col-md-9">
                        <div class="ticket-open-group">
                            <strong class="ticket-open-title">
                                <!-- 2020 서울드럼페스티벌 티켓오픈 안내 -->
                                ${notivo.prod_title}
                            </strong>
                            <div class="ticket-open-bar">
                                <!-- <p>2020.08.10(월) 오후 3:00</p> -->
                                <p>${notivo.ticketopenday}</p>
                            </div>
                            <div class="button-group">
                                <a href="detail.action?seq=${notivo.prod_id}" role="button">상세보기</a>
                                <button>티켓오픈 알림</button>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>
            <div class="row">
                <div class="col-12">
                    <div class="notice-content">
                        ${notivo.content}
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <div class="move-button-group">
                        <a href="?seq=${notivo.previousseq}">이전글&nbsp;<strong>${notivo.previoussubject}</strong></a>
                        <a href="?seq=${notivo.nextseq}">다음글&nbsp;<strong>${notivo.nextsubject}</strong></a>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <div class="list-button-group">
                        <a href="<%=ctxPath%>/noticeMain.action" role="button">전체목록</a>
                        <a href="<%=ctxPath%>/noticeMain.action" role="button">목록보기</a>
                        <c:if test="${sessionScope.loginuser.userid eq 'admin'}">
                            <a href="<%=ctxPath%>/noticeEdit.action?seq=${notivo.notice_id}" role="button">수정</a>
                            <a href="<%=ctxPath%>/noticeDel.action?seq=${notivo.notice_id}" role="button">삭제</a>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </main>
</body>
