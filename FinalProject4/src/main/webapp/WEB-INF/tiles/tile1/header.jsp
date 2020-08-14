<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
%>

<script src="resources/js/header.js"></script>
<script src="https://kit.fontawesome.com/5342aa1b58.js" crossorigin="anonymous"></script>
<script>
	function reservePopUp() {
		var url = "<%=ctxPath%>/reservePopUp.action";
		var option = "width = 971, height = 635, top = 200, left = 500, location = no, scrollbars = yes, toolbars = no, status = no";
		window.open(url, "", option);
	}
</script>

<header class="header">
    <nav class="header-menu">
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
                <a href="?category=1" class="category-link">콘서트</a>
                <ul class="header-sub-category list-group">
                    <li class="header-sub-category-item">
                        <a href="#">전체보기</a>
                    </li>
                    <li class="header-sub-category-item">
                        <a href="#">국내뮤지션</a>
                    </li>
                    <li class="header-sub-category-item">
                        <a href="#">해외뮤지션</a>
                    </li>
                    <li class="header-sub-category-item">
                        <a href="#">페스티벌</a>
                    </li>
                </ul>
            </li>
            <c:if test="${param.category == 2}">
                <li class="header-category-item active">
            </c:if>
            <c:if test="${param.category != 2}">
                <li class="header-category-item">
            </c:if>
                <a href="?category=2
                " class="category-link">뮤지컬</a>
                <ul class="header-sub-category list-group">
                    <li class="header-sub-category-item">
                        <a href="#">전체보기</a>
                    </li>
                    <li class="header-sub-category-item">
                        <a href="#">라이센스</a>
                    </li>
                    <li class="header-sub-category-item">
                        <a href="#">오리지널</a>
                    </li>
                    <li class="header-sub-category-item">
                        <a href="#">창작</a>
                    </li>
                    <li class="header-sub-category-item">
                        <a href="#">넌버벌 퍼포먼스</a>
                    </li>
                </ul>
            </li>
            <c:if test="${param.category == 3}">
                <li class="header-category-item active">
            </c:if>
            <c:if test="${param.category != 3}">
                <li class="header-category-item">
            </c:if>
                <a href="?category=3" class="category-link">연극</a>
                <ul class="header-sub-category list-group">
                    <li class="header-sub-category-item">
                        <a href="#">전체보기</a>
                    </li>
                    <li class="header-sub-category-item">
                        <a href="#">대학로</a>
                    </li>
                    <li class="header-sub-category-item">
                        <a href="#">기타지역</a>
                    </li>
                </ul>
            </li>
            <c:if test="${param.category == 4}">
                <li class="header-category-item active">
            </c:if>
            <c:if test="${param.category != 4}">
                <li class="header-category-item">
            </c:if>
                <a href="?category=4" class="category-link">클래식</a>
                <ul class="header-sub-category list-group">
                    <li class="header-sub-category-item">
                        <a href="#">전체보기</a>
                    </li>
                    <li class="header-sub-category-item">
                        <a href="#">클래식</a>
                    </li>
                    <li class="header-sub-category-item">
                        <a href="#">발레/무용</a>
                    </li>
                    <li class="header-sub-category-item">
                        <a href="#">국악</a>
                    </li>
                </ul>
            </li>
            <c:if test="${param.category == 5}">
                <li class="header-category-item active">
            </c:if>
            <c:if test="${param.category != 5}">
                <li class="header-category-item">
            </c:if>
                <a href="?category=5" class="category-link">전시</a>
                <ul class="header-sub-category list-group">
                    <li class="header-sub-category-item">
                        <a href="#">전체보기</a>
                    </li>
                    <li class="header-sub-category-item">
                        <a href="#">전시</a>
                    </li>
                    <li class="header-sub-category-item">
                        <a href="#">체험/행사</a>
                    </li>
                    <li class="header-sub-category-item">
                        <a href="#">워터파크/스파</a>
                    </li>
                </ul>
            </li>
            <c:if test="${param.category == 6}">
                <li class="header-category-item active">
            </c:if>
            <c:if test="${param.category != 6}">
                <li class="header-category-item">
            </c:if>
                <a href="?category=6" class="category-link">아동</a>
                <ul class="header-sub-category list-group">
                    <li class="header-sub-category-item">
                        <a href="#">전체보기</a>
                    </li>
                    <li class="header-sub-category-item">
                        <a href="#">뮤지컬</a>
                    </li>
                    <li class="header-sub-category-item">
                        <a href="#">연극</a>
                    </li>
                    <li class="header-sub-category-item">
                        <a href="#">기타</a>
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
                <span></span>
                <ul class="user-box hide">
                    <li class="user-box-item">
                        <a href=""> 회원가입 </a>
                    </li>
                    <li class="user-box-item">
                        <c:if test="${sessionScope.loginuser == null}">
            				<a href="<%=ctxPath%>/login.action">로그인</a>
            			</c:if>
               			<c:if test="${sessionScope.loginuser != null}">
            				<a href="<%=ctxPath%>/logout.action">로그아웃</a>
            			</c:if>
                    </li>
                    <li class="user-box-item">
                        <a href=""> 마이티켓 </a>
                    </li>
                    <li class="user-box-item">
                        <a href="<%=ctxPath%>/modifyInfo.action"> 마이페이지 </a>
                    </li>
                    <li class="user-box-item">
                        <a href=""> 고객센터 </a>
                    </li>
                </ul>
            </button>
        </div>
    </nav>
</header>