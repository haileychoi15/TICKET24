<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Category page</title>
    <link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="resources/css/category.css">
    <script src="https://kit.fontawesome.com/5342aa1b58.js" crossorigin="anonymous"></script>
</head>
<body>
<section class="category">
    <header class="category-header">
        <h1 class="main-category">${categoryName}</h1>
        <h2 class="sub-category">
            <div type="button" class="category-box-button">
                <button class="sub-category-title" value="${categoryDetail}">${categoryDetailName}</button>
                <ul class="sub-category-box hide">
                    <c:forEach var="item" items="${detailCategoryNameList}">
                        <li class="sub-category-box-item">
                            <button type="button" value="${item.category_detail_id}">
                                    ${item.category_detail_name}
                            </button>
                        </li>
                    </c:forEach>
                    <%-- 주석 처리 시작 --%>
                    <!-- <li class="sub-category-box-item">
                        <button type="button" value="1">
                            전체보기
                        </button>
                    </li>
                    <li class="sub-category-box-item">
                        <button type="button" value="2">
                            국내뮤지션
                        </button>
                    </li>
                    <li class="sub-category-box-item">
                        <button type="button" value="3">
                            해외뮤지션
                        </button>
                    </li>
                    <li class="sub-category-box-item">
                        <button type="button" value="4">
                            페스티벌
                        </button>
                    </li> -->
                        <%-- 주석 처리 끝 --%>
                </ul>
            </div>
        </h2>
    </header>
    <div class="container">
        <div class="row">
            <div class="col-12 col-md-12">
                <div class="order">
                    <div class="order-group">
                        <button type="button" class="selected" value="1">주간랭킹순</button>
                        <button type="button" value="2">신상품순</button>
                        <button type="button" value="3">종료임박순</button>
                        <button type="button" value="4">상품명순</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<main class="product">
    <h2 class="main-title">상품리스트</h2>
    <div class="container product-group">
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
    <div class="container">
        <div class="row">
            <div class="col-12">
                <button class="more-button">더보기</button>
                <input type="text" class="until-prod-count" value="0">
                <input type="text" class="total-prod-count" value="0">
            </div>
        </div>
    </div>
</main>
<script src="resources/js/category1.js"></script>