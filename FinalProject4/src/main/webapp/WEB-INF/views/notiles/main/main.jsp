<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath();%>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>YES24 티켓</title>
    <link rel="shortcut icon" href="http://tkfile.yes24.com/img/favicon.ico?ver=150825a" type="image/x-icon">
    <link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="resources/css/grid.min.css">
    <link rel="stylesheet" href="resources/css/reset.css">
    <link rel="stylesheet" href="resources/css/main.css">
    <script src="https://kit.fontawesome.com/5342aa1b58.js" crossorigin="anonymous"></script>
    <script>
	    function reservePopUp() {
			var url = "<%= request.getContextPath()%>/reservePopUp.action";
			var option = "width = 971, height = 635, top = 200, left = 500, location = no, scrollbars = yes, toolbars = no, status = no";
			window.open(url, "", option);
		}
    </script>
</head>
<body>
    <header class="header">
        <div class="header-top">
            <div class="header-site-group">
                <a href="http://www.yes24.com/Main/default.aspx" target="_blank">YES24</a>
                <a href="https://movie.yes24.com/" target="_blank">영화</a>
                <a href="http://www.yes24.com/Mall/Main/Music/003?CategoryNumber=003" target="_blank">CD/LP</a>
                <a href="http://www.yes24.com/Mall/Main/Dvd/004?CategoryNumber=004" target="_blank">DVD/BD</a>
                <span>|</span>
                <a href="https://yes24livehall.com/" target="_blank">예스24라이브홀</a>
                <a href="https://yes24stage.com/" target="_blank">예스24스테이지</a>
            </div>
            <div class="header-login-group">
            	<c:if test="${sessionScope.loginuser == null}">
            		<a href="<%=ctxPath%>/login.action">로그인</a>
            	</c:if>
               	<c:if test="${sessionScope.loginuser != null}">
            		<a href="<%=ctxPath%>/logout.action">로그아웃</a>
            	</c:if>
                
                <a href="#">마이페이지</a>
                <a href="#">고객센터</a>
            </div>
        </div>
        <nav class="header-menu">
            <h1>
                <a href="#">YES24 티켓</a>
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
                        <li class="header-sub-category-item" onclick="javascript:reservePopUp();">
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
                    <button type="submit">검색</button>
                </form>
                <a href="#">
                    <strong class="icon-desc">MY 티켓</strong>
                </a>
                <a href="#">
                    <strong class="icon-desc">GLOBAL</strong>
                </a>
            </div>
        </nav>
    </header>
    <section class="promotion">
        <h1>프로모션 공연</h1>
        <div class="promotion-area">
            <ul class="promotion-group list-group">
                <li class="promotion-item">
                    <a href>
                        <div class="promotion-item-image">
                            <img src="http://tkfile.yes24.com/Upload2/Display/202007/20200721/genre_big_gmf2020.jpg/dims/quality/70/" alt="그랜드민트 페스티벌 2020">
                        </div>
                        <div class="promotion-item-content">
                            <h3>그랜드민트 페스티벌 2020</h3>
                            <p>2020.10.24 ~ 2020.10.25 올림픽공원</p>
                        </div>
                    </a>
                </li>
                <li class="promotion-item">
                    <a href>
                        <div class="promotion-item-image">
                            <img src="http://tkfile.yes24.com/Upload2/Display/202006/20200630/gmain_top_Werther.jpg/dims/quality/70/" alt="뮤지컬 &lt;베르테르&gt;">
                        </div>
                        <div class="promotion-item-content">
                            <h3>뮤지컬 &lt;베르테르&gt;</h3>
                            <p>2020.08.28 ~ 2020.11.01 광림아트센터 BBCH홀</p>
                        </div>
                    </a>
                </li>
                <li class="promotion-item">
                    <a href>
                        <div class="promotion-item-image">
                            <img src="http://tkfile.yes24.com/Upload2/Display/201910/20191029/gmain_top_trot.jpg/dims/quality/70/" alt="내일은 미스트롯">
                        </div>
                        <div class="promotion-item-content">
                            <h3>내일은 미스트롯</h3>
                            <p>전국투어</p>
                        </div>
                    </a>
                </li>
                <li class="promotion-item">
                    <a href>
                        <div class="promotion-item-image">
                            <img src="http://tkfile.yes24.com/Upload2/Display/202007/20200716/gmain_top_36995.jpg/dims/quality/70/" alt="뻔하지않은듯뻔한페스티벌">
                        </div>
                        <div class="promotion-item-content">
                            <h3>뻔하지않은듯뻔한페스티벌</h3>
                            <p>2020.08.22 연세대학교 노천극장</p>
                        </div>
                    </a>
                </li>
            </ul>
            <button type="button" class="prev-button" aria-label="Previous slide"></button>
            <button type="button" class="next-button" aria-label="Next slide"></button>
        </div>
    </section>
    <section class="product">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <h2 class="section-title">WHAT'S HOT</h2>
                </div>
            </div>
            <div class="row">
                <div class="col12 col-md-6">
                    <ul class="card-list list-group">
                        <li class="card">
                            <a href="">
                                <div class="card-image common-image">
                                    <img src="http://tkfile.yes24.com/upload2/perfblog/202007/20200722/20200722-37219_1.jpg/dims/quality/70/" alt="겨울방학 정규 4집 발매 기념 공연" />
                                </div>
                                <div class="card-desc">
                                    <h3 class="card-title common-title">겨울방학 정규 4집 발매 기념 공연</h3>
                                    <strong class="card-content common-content">노들섬 라이브 하우스</strong>
                                </div>
                            </a>
                        </li>
                        <li class="card">
                            <a href="">
                                <div class="card-image common-image">
                                    <img src="http://tkfile.yes24.com/upload2/perfblog/202005/20200525/20200525-36897_1.jpg/dims/quality/70/" alt="서울 숲재즈 페스티벌 2020" />
                                    <span class="sr-only">Discount rate</span>
                                    <strong class="notice-sticker">30%</strong>
                                </div>
                                <div class="card-desc">
                                    <h3 class="card-title common-title">서울 숲재즈 페스티벌 2020</h3>
                                    <strong class="card-content common-content">서울 숲 공원</strong>
                                </div>
                            </a>
                        </li>
                    </ul>
                </div>
                <div class="col12 col-md-6">
                    <ul class="card-list list-group">
                        <li class="card">
                            <a href="">
                                <div class="card-image common-image">
                                    <img src="http://tkfile.yes24.com/upload2/perfblog/202007/20200722/20200722-37219_1.jpg/dims/quality/70/" alt="" />
                                </div>
                                <div class="card-desc">
                                    <h3 class="card-title common-title">겨울방학 정규 4집 발매 기념 공연</h3>
                                    <strong class="card-content common-content">노들섬 라이브 하우스</strong>
                                </div>
                            </a>
                        </li>
                        <li class="card">
                            <a href="">
                                <div class="card-image common-image">
                                    <img src="http://tkfile.yes24.com/upload2/perfblog/202005/20200525/20200525-36897_1.jpg/dims/quality/70/" alt="" />
                                </div>
                                <div class="card-desc">
                                    <h3 class="card-title common-title">서울 숲재즈 페스티벌 2020</h3>
                                    <strong class="card-content common-content">서울 숲 공원</strong>
                                </div>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="row">
                <div class="col12 col-md-6">
                    <ul class="card-list list-group">
                        <li class="card">
                            <a href="">
                                <div class="card-image common-image">
                                    <img src="http://tkfile.yes24.com/upload2/perfblog/202007/20200722/20200722-37219_1.jpg/dims/quality/70/" alt="" />
                                </div>
                                <h3 class="card-title common-title">겨울방학 정규 4집 발매 기념 공연</h3>
                                <strong class="card-content common-content">노들섬 라이브 하우스</strong>
                            </a>
                        </li>
                        <li class="card">
                            <a href="">
                                <div class="card-image common-image">
                                    <img src="http://tkfile.yes24.com/upload2/perfblog/202005/20200525/20200525-36897_1.jpg/dims/quality/70/" alt="" />
                                    <span class="sr-only">Discount rate</span>
                                    <strong class="notice-sticker">30%</strong>
                                </div>
                                <div class="card-desc">
                                    <h3 class="card-title common-title">서울 숲재즈 페스티벌 2020</h3>
                                    <strong class="card-content common-content">서울 숲 공원</strong>
                                </div>
                            </a>
                        </li>
                    </ul>
                </div>
                <div class="col12 col-md-6">
                    <ul class="card-list list-group">
                        <li class="card">
                            <a href="">
                                <div class="card-image common-image">
                                    <img src="http://tkfile.yes24.com/upload2/perfblog/202007/20200722/20200722-37219_1.jpg/dims/quality/70/" alt="" />
                                </div>
                                <div class="card-desc">
                                    <h3 class="card-title common-title">겨울방학 정규 4집 발매 기념 공연</h3>
                                    <strong class="card-content common-content">노들섬 라이브 하우스</strong>
                                </div>
                            </a>
                        </li>
                        <li class="card">
                            <a href="">
                                <div class="card-image common-image">
                                    <img src="http://tkfile.yes24.com/upload2/perfblog/202005/20200525/20200525-36897_1.jpg/dims/quality/70/" alt="" />
                                </div>
                                <div class="card-desc">
                                    <h3 class="card-title common-title">서울 숲재즈 페스티벌 2020</h3>
                                    <strong class="card-content common-content">서울 숲 공원</strong>
                                </div>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </section>
    <section class="musical-only">
        <div class="musical-content">
            <h3>
                <a href="#">
                    뮤지컬 </br> 오페라의 유령
                </a>
            </h3>
            <div class="musical-content-desc">
                <strong>7년만의 내한공연</strong>
                <strong>쿠폰증정</strong>
            </div>
            <div class="info-box">
                <a href="#">
                    <div class="info-box-image" role="img" aria-label="뮤지컬 오페라의 공연 이미지"></div>
                    <div class="info-box-desc">
                        <p>관련 공연</p>
                        <p>뮤지컬 </br>오페라의 공연</p>
                    </div>
                </a>
            </div>
        </div>
        <div class="musical-video">
            <div class="musical-video-content">
                <iframe width="560" height="315" src="https://www.youtube.com/embed/knh13N7k-TY" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen aria-label="뮤지컬 오페라의 공연 트레일러"></iframe>
            </div>
        </div>
    </section>
    <section class="ranking">
        <div class="container">
            <div class="row">
                <div class="col-12 col-md-5">
                    <div class="area ranking-area">
                        <header class="ranking-header">
                            <h3 class="area-title">WEEKLY RANKING</h3>
                            <a href="#">
                                <button class="more-ranking-button" type="button">더보기</button>
                            </a>
                        </header>
                        <ol class="ranking-item-group">
                            <li class="ranking-item on">
                                <a href="#">
                                    <dl>
                                        <dt class="ranking-item-ranking">1위</dt>
                                        <dd class="ranking-item-image hide">
                                            <img src="http://tkfile.yes24.com/upload2/PerfBlog/202006/20200625/20200625-37085_1.jpg" alt="[부산]팬텀싱어">
                                        </dd>
                                        <dd class="ranking-item-content">
                                            <strong class="ranking-item-title">[부산]팬텀싱어</strong>
                                            <p class="common-detail hide">2020.08.07 ~ 2020.08.09</p>
                                            <p class="common-detail hide">노들섬 라이브하우스</p>
                                        </dd>
                                    </dl>
                                </a>
                            </li>
                            <li  class="ranking-item">
                                <a href="#">
                                    <dl>
                                        <dt class="ranking-item-ranking">2위</dt>
                                        <dd class="ranking-item-image hide">
                                            <img src="http://tkfile.yes24.com/upload2/PerfBlog/202007/20200722/20200722-37256_1.jpg" alt="2020 DMZPOP DRIVE IN CONCERT in CHEOLWON［무료공연]">
                                        </dd>
                                        <dd class="ranking-item-content">
                                            <strong class="ranking-item-title">2020 DMZPOP DRIVE IN CONCERT in CHEOLWON［무료공연]</strong>
                                            <p class="common-detail hide">2020.08.07 ~ 2020.08.09</p>
                                            <p class="common-detail hide">노들섬 라이브하우스</p>
                                        </dd>
                                    </dl>
                                </a>
                            </li>
                            <li  class="ranking-item">
                                <a href="#">
                                    <dl>
                                        <dt class="ranking-item-ranking">3위</dt>
                                        <dd class="ranking-item-image hide">
                                            <img src="http://tkfile.yes24.com/upload2/PerfBlog/202007/20200730/20200730-37311_11.jpg" alt="Someday Festival 2020 공식티켓">
                                        </dd>
                                        <dd class="ranking-item-content">
                                            <strong class="ranking-item-title">Someday Festival 2020 공식티켓</strong>
                                            <p class="common-detail hide">2020.09.05 ~ 2020.09.06</p>
                                            <p class="common-detail hide">난지한강공원</p>
                                        </dd>
                                    </dl>
                                </a>
                            </li>
                            <li  class="ranking-item">
                                <a href="#">
                                    <dl>
                                        <dt class="ranking-item-ranking">4위</dt>
                                        <dd class="ranking-item-image hide">
                                            <img src="http://tkfile.yes24.com/upload2/PerfBlog/202006/20200625/20200625-37085_1.jpg" alt="[부산]팬텀싱어">
                                        </dd>
                                        <dd class="ranking-item-content">
                                            <strong class="ranking-item-title">[부산]팬텀싱어</strong>
                                            <p class="common-detail hide">2020.08.07 ~ 2020.08.09</p>
                                            <p class="common-detail hide">노들섬 라이브하우스</p>
                                        </dd>
                                    </dl>
                                </a>
                            </li>
                            <li  class="ranking-item">
                                <a href="#">
                                    <dl>
                                        <dt class="ranking-item-ranking">5위</dt>
                                        <dd class="ranking-item-image hide">
                                            <img src="http://tkfile.yes24.com/upload2/PerfBlog/202007/20200730/20200730-37311_11.jpg" alt="Someday Festival 2020 공식티켓">
                                        </dd>
                                        <dd class="ranking-item-content">
                                            <strong class="ranking-item-title">Someday Festival 2020 공식티켓</strong>
                                            <p class="common-detail hide">2020.09.05 ~ 2020.09.06</p>
                                            <p class="common-detail hide">난지한강공원</p>
                                        </dd>
                                    </dl>
                                </a>
                            </li>
                        </ol>
                    </div>
                </div>
                <div class="col-12 col-md-7">
                    <div class="area place-area">
                        <h3 class="area-title">지역별 추천</h3>
                        <ul class="place-item-group list-group">
                            <li class="place-item image-transition">
                                <a href="">
                                    <div class="place-item-image">
                                        <img src="http://tkfile.yes24.com/upload2/perfblog/202007/20200727/20200727-37268_12.jpg/dims/quality/70/" alt="2020 울산 서머 페스티벌">
                                        <strong class="place-sticker">울산</strong>
                                    </div>
                                    <strong class="place-item-title">2020 울산 서머 페스티벌</strong>
                                    <p class="common-detail">2020.08.07 ~ 2020.08.09</p>
                                    <p class="common-detail">범서생활체육공원</p>
                                </a>
                            </li>
                            <li class="place-item image-transition">
                                <a href="">
                                    <div class="place-item-image">
                                        <img src="http://tkfile.yes24.com/upload2/perfblog/202007/20200727/20200727-37268_12.jpg/dims/quality/70/" alt="2020 울산 서머 페스티벌">
                                        <strong class="place-sticker">광주</strong>
                                    </div>
                                    <strong class="place-item-title">2020 울산 서머 페스티벌</strong>
                                    <p class="common-detail hide">2020.08.07 ~ 2020.08.09</p>
                                    <p class="common-detail">범서생활체육공원</p>
                                </a>
                            </li>
                            <li class="place-item image-transition">
                                <a href="">
                                    <div class="place-item-image">
                                        <img src="http://tkfile.yes24.com/upload2/perfblog/202007/20200727/20200727-37268_12.jpg/dims/quality/70/" alt="2020 울산 서머 페스티벌">
                                        <strong class="place-sticker">부산</strong>
                                    </div>
                                    <strong class="place-item-title">2020 울산 서머 페스티벌</strong>
                                    <p class="common-detail hide">2020.08.07 ~ 2020.08.09</p>
                                    <p class="common-detail">범서생활체육공원</p>
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <aside class="recommendation">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <h2 class="section-title">YES24's PICKS</h2>
                </div>
            </div>
            <div class="row">
                <div class="col-12 col-md-6">
                    <ul class="card-list list-group">
                        <li class="card image-transition">
                            <a href="#">
                                <div class="card-image common-image">
                                    <img src="http://tkfile.yes24.com/upload2/PerfBlog/202006/20200604/20200604-36820_011.jpg" alt="2020 빅3 &quot;행복한 만남&quot;(진성,김용임,강진)">
                                </div>
                                <div class="card-desc">
                                    <h3 class="card-title common-title">2020 빅3 &quot;행복한 만남&quot;(진성,김용임,강진)</h3>
                                    <p class="card-place common-content">KBS부산홀</p>
                                </div>
                            </a>
                        </li>
                        <li class="card image-transition">
                            <a href="#">
                                <div class="card-image common-image">
                                    <img src="http://tkfile.yes24.com/upload2/PerfBlog/202007/20200708/20200708-37126_1.jpg" alt="그린플러그드 경주 2020">
                                </div>
                                <div class="card-desc">
                                    <h3 class="card-title common-title">그린플러그드 경주 2020</h3>
                                    <p class="card-place common-content">경주 세계문화 엑스포 공원일대</p>
                                </div>
                            </a>
                        </li>
                    </ul>
                </div>
                <div class="col-12 col-md-6">
                    <ul class="card-list list-group">
                        <li class="card image-transition">
                            <a href="#">
                                <div class="card-image common-image">
                                    <img src="http://tkfile.yes24.com/upload2/PerfBlog/202007/20200722/20200722-37255_1.jpg" alt="">
                                </div>
                                <div class="card-desc">
                                    <h3 class="card-title common-title">〈엔니오 모리꼬네 시네콘서트〉 : 영화음악의 거장, 그를 추억하며</h3>
                                    <p class="card-place common-content">예술의전당 오페라극장</p>
                                </div>
                            </a>
                        </li>
                        <li class="card image-transition">
                            <a href="#">
                                <div class="card-image common-image">
                                    <img src="http://tkfile.yes24.com/upload2/PerfBlog/202001/20200130/20200130-36324_12.jpg" alt="">
                                </div>
                                <div class="card-desc">
                                    <h3 class="card-title common-title">사람：너와 나 사이의 거리 - 9월의 랑데북 - 수원</h3>
                                    <p class="card-place common-content">경기아트센터 소극장</p>
                                </div>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </aside>
    <footer class="footer">
        <div class="container">
            <div class="row">
                <div class="col-12 col-md-9">
                    <ul class="footer-category list-group">
                        <li class="footer-category-item">
                            <a href="#">회사소개</a>
                        </li>
                        <span class="category-border">|</span>
                        <li class="footer-category-item">
                            <a href="#">이용약관</a>
                        </li>
                        <span class="category-border">|</span>
                        <li class="footer-category-item">
                            <a href="#">개인정보처리방침</a>
                        </li>
                        <span class="category-border style-border">|</span>
                        <li class="footer-category-item">
                            <a href="#">청소년보호정책</a>
                        </li>
                        <span class="category-border">|</span>
                        <li class="footer-category-item">
                            <a href="#">이용안내</a>
                        </li>
                        <span class="category-border">|</span>
                        <li class="footer-category-item">
                            <a href="#">티켓판매안내</a>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="row">
                <div class="col-12 col-md-2">
                    <strong class="footer-logo">
                        <a href="#">YES24 티켓</a>
                    </strong>
                </div>
                <div class="col-12 col-md-7">
                    <strong class="footer-title">예스이십사(주)</strong>
                    <p class="footer-desc common-detail">
                        서울시 영등포구 은행로 11, 5층~6층(여의도동,일신빌딩) </br>
                        대표 김석환  |  개인정보보호책임자 : 권민석 yes24help@yes24.com </br>
                        사업자등록번호 229-81-37000  | 통신판매업신고 제 2005-02682호 사업자 정보확인 </br>
                        호스팅 서비스사업자 : 예스이십사㈜
                    </p>
                    <p class="footer-copyright common-detail">
                        Copyright © YES24 Corp. All Rights Reserved.
                    </p>
                </div>
                <div class="col-12 col-md-3">
                    <p class="footer-notice">
                        고객님은 안전거래를 위한 현금 등으로 결제 시 </br>
                        저희 쇼핑몰에서 가입한 구매안전서비스를 </br>
                        이용하실 수 있습니다.
                    </p>
                    <button type="button" class="return-top-button" aria-label="Back to top">
                        <img src="resources/images/arrow-icon.png" alt="">
                    </button>
                </div>
            </div>
        </div>
    </footer>
    <script src="resources/js/main.js"></script>
</body>
</html>