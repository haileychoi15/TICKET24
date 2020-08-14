<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Main page</title>
    <link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/5342aa1b58.js" crossorigin="anonymous"></script>
    
</head>
<body>
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
                        <h3>${prodList.get }</h3>
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
<c:if test="${param.category == 2}">
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
</c:if>
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
<script src="resources/js/main.js"></script>
</body>
</html>