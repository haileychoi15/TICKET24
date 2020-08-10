<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.InetAddress"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- ======= #27. tile1 중 header 페이지 만들기  ======= --%>
<%
	String ctxPath = request.getContextPath();
%>


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
            <a href="#">
                TICKET24
            </a>
        </h1>
        <ul class="header-category list-group">
            <li class="header-category-item active">
                <a href="#" class="category-link">콘서트</a>
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
            <li class="header-category-item">
                <a href="#" class="category-link">뮤지컬</a>
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
            <li class="header-category-item">
                <a href="#" class="category-link">연극</a>
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
            <li class="header-category-item">
                <a href="#" class="category-link">클래식</a>
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
            <li class="header-category-item">
                <a href="#" class="category-link">전시</a>
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
            <li class="header-category-item">
                <a href="#" class="category-link">아동</a>
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
                        <a href="">
                            회원가입
                        </a>
                    </li>
                    <li class="user-box-item">
                        <a href="">
                            로그인
                        </a>
                    </li>
                    <li class="user-box-item">
                        <a href="">
                            마이티켓
                        </a>
                    </li>
                    <li class="user-box-item">
                        <a href="">
                            마이페이지
                        </a>
                    </li>
                    <li class="user-box-item">
                        <a href="">
                            고객센터
                        </a>
                    </li>
                </ul>
            </button>
        </div>
    </nav>
</header>
	
	
	<!-- === #49. 로그인이 성공되어지면 로그인되어진 사용자의 이메일 주소를 출력하기 === -->
	<c:if test="${sessionScope.loginuser != null}">
		<div style="float: right; margin-top: 0.5%; border: solid 0px red;">
		  <span style="color: navy; font-weight: bold; font-size: 10pt;">${sessionScope.loginuser.email}</span> 님 로그인중.. 
		</div>
	</c:if>
	