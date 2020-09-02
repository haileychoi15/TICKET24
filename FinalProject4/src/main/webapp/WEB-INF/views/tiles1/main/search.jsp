<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
    <link rel="stylesheet" type="text/css" href="resources/css/search.css">
    <script src="https://kit.fontawesome.com/c3eca5a54c.js" crossorigin="anonymous"></script>

<div id="container">
    <div id="title">검색 결과</div>

    <div id="content">
    	<c:forEach var="item" items="${searchShowList}">
    		<div class="searchContainer">
	            <div class="searchItem poster">
	                <img src="resources/images/${item.prod_img}" alt="poster" width="100px">
	            </div>
	            <div class="searchItem title">
	                <div class="status soldIn"></div>
	                <div class="showTitle">${item.prod_title}</div>
	            </div>
	            <div class="searchItem term">
	                <div>${item.date_start} ~ ${item.date_end}</div>
	            </div>
	            <div class="searchItem place">
	                <div>${item.map_name}</div>
	            </div>
	        </div>
    	</c:forEach>
        
        <!-- <div class="searchContainer">
            <div class="searchItem poster">
                <img src="https://cdnticket.melon.co.kr/resource/image/upload/product/2020/05/20200528104334ce28c4f9-534e-45c0-8f1a-e75a7e18abe3.jpg" alt="poster" width="100px">
            </div>
            <div class="searchItem title">
                <div class="status soldOut"></div>
                <div class="showTitle">플루티스트 이예린의 Music For You</div>
            </div>
            <div class="searchItem term">
                <div>2020.07.21 ~ 2020.08.13</div>
            </div>
            <div class="searchItem place">
                <div>예술의 전당 리사이틀 홀</div>
            </div>
        </div> -->
    </div>       

    <!-- 페이징
    <div id="pageBar">
        <a href="" class="pageBtn" id="prevFist"></a>
        <a href="" class="pageBtn" id="prev"></a>
        <em class="pageLink">1</em>
        <a href="" class="pageLink">2</a>
        <a href="" class="pageLink">3</a>
        <a href="" class="pageLink">4</a>
        <a href="" class="pageLink">5</a>
        <a href="" class="pageBtn" id="next"></a>
        <a href="" class="pageBtn" id="nextLast"></a>
    </div>
    -->
</div>
