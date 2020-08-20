<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String ctxPath = request.getContextPath();
%>
<header class="header">
    <div class="link-bar">
    <c:if test="${sessionScope.loginuser.userid == 'admin'}">
    	<a href="<%=ctxPath%>/qnaListMain.action">Admin</a>
   	</c:if>
        <a href="<%=ctxPath%>/coupon.action">이벤트</a>
        <a href="<%=ctxPath%>/noticeMain.action">공지사항</a>
        <a href="<%=ctxPath%>/qna.action">FAQ</a>
    </div>
    <nav class="header-menu fold">
        <h1>
            <a href="<%=ctxPath%>/yes24.action">
                TICKET24
            </a>
        </h1>
        <ul class="header-category list-group">
            <c:if test="${param.category == 1 || category == 1}">
            <li class="header-category-item active">
                </c:if>
                <c:if test="${param.category != 1 && category != 1}">
            <li class="header-category-item">
                </c:if>
                <a href="<%=request.getContextPath()%>/yes24.action?category=1" class="category-link">콘서트</a>
                <ul class="header-sub-category list-group">
                    <li class="header-sub-category-item">
                        <a href="<%= request.getContextPath()%>/category.action?category=1&categoryDetail=1">전체보기</a>
                    </li>
                    <li class="header-sub-category-item">
                        <a href="<%= request.getContextPath()%>/category.action?category=1&categoryDetail=2">국내뮤지션</a>
                    </li>
                    <li class="header-sub-category-item">
                        <a href="<%= request.getContextPath()%>/category.action?category=1&categoryDetail=3">해외뮤지션</a>
                    </li>
                    <li class="header-sub-category-item">
                        <a href="<%= request.getContextPath()%>/category.action?category=1&categoryDetail=4">페스티벌</a>
                    </li>
                </ul>
            </li>
            <c:if test="${param.category == 2}">
            <li class="header-category-item active">
                </c:if>
                <c:if test="${param.category != 2}">
            <li class="header-category-item">
                </c:if>
                <a href="<%=request.getContextPath()%>/yes24.action?category=2" class="category-link">뮤지컬</a>
                <ul class="header-sub-category list-group">
                    <li class="header-sub-category-item">
                        <a href="<%= request.getContextPath()%>/category.action?category=2&categoryDetail=5">전체보기</a>
                    </li>
                    <li class="header-sub-category-item">
                        <a href="<%= request.getContextPath()%>/category.action?category=2&categoryDetail=6">라이센스</a>
                    </li>
                    <li class="header-sub-category-item">
                        <a href="<%= request.getContextPath()%>/category.action?category=2&categoryDetail=7">오리지널</a>
                    </li>
                    <li class="header-sub-category-item">
                        <a href="<%= request.getContextPath()%>/category.action?category=2&categoryDetail=8">창작</a>
                    </li>
                    <li class="header-sub-category-item">
                        <a href="<%= request.getContextPath()%>/category.action?category=2&categoryDetail=9">넌버벌 퍼포먼스</a>
                    </li>
                </ul>
            </li>
            <c:if test="${param.category == 3}">
            <li class="header-category-item active">
                </c:if>
                <c:if test="${param.category != 3}">
            <li class="header-category-item">
                </c:if>
                <a href="<%=request.getContextPath()%>/yes24.action?category=3" class="category-link">연극</a>
                <ul class="header-sub-category list-group">
                    <li class="header-sub-category-item">
                        <a href="<%= request.getContextPath()%>/category.action?category=3&categoryDetail=10">전체보기</a>
                    </li>
                    <li class="header-sub-category-item">
                        <a href="<%= request.getContextPath()%>/category.action?category=3&categoryDetail=11">대학로</a>
                    </li>
                    <li class="header-sub-category-item">
                        <a href="<%= request.getContextPath()%>/category.action?category=3&categoryDetail=12">기타지역</a>
                    </li>
                </ul>
            </li>
            <c:if test="${param.category == 4}">
            <li class="header-category-item active">
                </c:if>
                <c:if test="${param.category != 4}">
            <li class="header-category-item">
                </c:if>
                <a href="<%=request.getContextPath()%>/yes24.action?category=4" class="category-link">클래식</a>
                <ul class="header-sub-category list-group">
                    <li class="header-sub-category-item">
                        <a href="<%= request.getContextPath()%>/category.action?category=4&categoryDetail=13">전체보기</a>
                    </li>
                    <li class="header-sub-category-item">
                        <a href="<%= request.getContextPath()%>/category.action?category=4&categoryDetail=14">클래식</a>
                    </li>
                    <li class="header-sub-category-item">
                        <a href="<%= request.getContextPath()%>/category.action?category=4&categoryDetail=15">발레/무용</a>
                    </li>
                    <li class="header-sub-category-item">
                        <a href="<%= request.getContextPath()%>/category.action?category=4&categoryDetail=16">국악</a>
                    </li>
                </ul>
            </li>
            <c:if test="${param.category == 5}">
            <li class="header-category-item active">
                </c:if>
                <c:if test="${param.category != 5}">
            <li class="header-category-item">
                </c:if>
                <a href="<%=request.getContextPath()%>/yes24.action?category=5" class="category-link">전시</a>
                <ul class="header-sub-category list-group">
                    <li class="header-sub-category-item">
                        <a href="<%= request.getContextPath()%>/category.action?category=5&categoryDetail=17">전체보기</a>
                    </li>
                    <li class="header-sub-category-item">
                        <a href="<%= request.getContextPath()%>/category.action?category=5&categoryDetail=18">전시</a>
                    </li>
                    <li class="header-sub-category-item">
                        <a href="<%= request.getContextPath()%>/category.action?category=5&categoryDetail=19">체험/행사</a>
                    </li>
                    <li class="header-sub-category-item">
                        <a href="<%= request.getContextPath()%>/category.action?category=5&categoryDetail=20">워터파크/스파</a>
                    </li>
                </ul>
            </li>
            <c:if test="${param.category == 6}">
            <li class="header-category-item active">
                </c:if>
                <c:if test="${param.category != 6}">
            <li class="header-category-item">
                </c:if>
                <a href="<%=request.getContextPath()%>/yes24.action?category=6" class="category-link">아동</a>
                <ul class="header-sub-category list-group">
                    <li class="header-sub-category-item">
                        <a href="<%= request.getContextPath()%>/category.action?category=6&categoryDetail=21">전체보기</a>
                    </li>
                    <li class="header-sub-category-item">
                        <a href="<%= request.getContextPath()%>/category.action?category=6&categoryDetail=22">뮤지컬</a>
                    </li>
                    <li class="header-sub-category-item">
                        <a href="<%= request.getContextPath()%>/category.action?category=6&categoryDetail=23">연극</a>
                    </li>
                    <li class="header-sub-category-item">
                        <a href="<%= request.getContextPath()%>/category.action?category=6&categoryDetail=24">기타</a>
                    </li>
                </ul>
            </li>
        </ul>
        <div class="search-group">
            <form action="#" method="GET" class="search-form">
                <input type="text" placeholder="">
                <button type="submit" aria-label="Search"></button>
            </form>
            <button type="button" class="user-button" aria-label="User account">
                <c:if test="${sessionScope.loginuser == null}">
                    <span class="no-user"></span>
                </c:if>
                <c:if test="${sessionScope.loginuser != null}">
                    <span class="yes-user"></span>
                </c:if>
                <ul class="user-box hide">
                    <c:if test="${sessionScope.loginuser == null}">
                        <li class="user-box-item">
                            <a href="<%=ctxPath%>/register.action"> 회원가입 </a>
                        </li>
                    </c:if>
                    <li class="user-box-item">
                        <c:if test="${sessionScope.loginuser == null}">
                            <a href="<%=ctxPath%>/login.action">로그인</a>
                        </c:if>
                        <c:if test="${sessionScope.loginuser != null}">
                            <a href="<%=ctxPath%>/logout.action">로그아웃</a>
                        </c:if>
                    </li>
                    <li class="user-box-item">
                        <a href="<%=ctxPath%>/myTicket.action"> 마이티켓 </a>
                    </li>
                    <li class="user-box-item">
                        <a href="<%=ctxPath%>/myPage.action"> 마이페이지 </a>
                    </li>
                </ul>
            </button>
        </div>
    </nav>
</header>
<script src="resources/js/header.js"></script>