<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>반응형상세</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;700&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="../css/grid.min.css" />
    <link rel="stylesheet" href="../css/respstyle.css">
    <script src="https://kit.fontawesome.com/3625c042d9.js" crossorigin="anonymous"></script>
</head>
<body>
<section class="landing">
    <div class="container">
        <div class="row">
            <div class="col-12">
               <div class="landing-content">
                    <!--이전페이지주소로이동-->
                   <a href="#" class="landing-category">
                       <span>콘서트</span>><span>국내뮤지션</span>
                   </a>

                   <div class="landing-info">

                       <h1 class="landing-title">
                           [부산] 팬텀싱어3 콘서트
                       </h1>
                       <strong class="landing-date">
                           2020.08.28~2020.09.27
                       </strong>
                       <a href="#map" class="landing-place">
                           <i class="fas fa-map-marker-alt"></i>
                           부산 벡스코 제 1전시장 1홀
                       </a>

                   </div>

                   <div class="landing-share">

                       <button type="button" class="share-button" id="shareButton" aria-label="Share this product"></button>

                       <div class="share-box show">
                           <a href="https://www.facebook.com/">
                               <i class="fab fa-facebook"></i>
                           </a>
                           <a href="https://twitter.com/?lang=ko">
                               <i class="fab fa-twitter-square"></i>
                           </a>
                           <a href="https://www.instagram.com/?hl=ko">
                               <i class="fab fa-instagram"></i>
                           </a>
                           <button type="button" class="share-button" id="close-button" aria-label="Share this product"></button>
                       </div>

                   </div>

               </div>
            </div>
        </div>
    </div>
</section>
<section class="main">
    <div class="container">
        <div class="row">

            <div class="col-12 col-md-5">
                <div class="main-image">
                    <img src="../assets/phantomsinger.jpg" alt="팬텀싱어3콘서트"/>
                </div>

                <div class="main-rate">
                    <div class="main-likes">
                        <i class="far fa-heart noncolored-heart"></i>
                        <i class="fas fa-heart colored-heart"></i>
                        <strong class="main-likes-number">
                            118
                        </strong>
                    </div>
                    <div class="main-reviews">
                        <a href="#review" class="main-review-link">
                            <strong>
                                4.94
                            </strong>
                            <span>
                                (203)
                            </span>
                        </a>
                    </div>
                </div>
            </div>

            <div class="col-12 col-md-7">
                <div class="main-detail-top">
                    <dl>
                        <div>
                            <dt>등급</dt>
                            <dd>8세이상</dd>
                        </div>
                        <div>
                            <dt>관람시간</dt>
                            <dd>110분</dd>
                        </div>
                      <!--  <div>
                            <dt>출연</dt>
                            <dd>라포엠</dd>
                        </div>-->
                        <div>
                            <dt>가격</dt>
                            <dd>
                                <div class="main-price">
                                    <span>R석</span><span>121,000원</span><br>
                                    <span>S석</span><span>110,000원</span>
                                </div>
                            </dd>
                        </div>
                    </dl>
                </div>

                <div class="main-detail-bottom">
                    <dl>
                        <div>
                            <dt>공연시간안내</dt>
                            <dd>
                                <span>"2020년 8월 29일(토) 오후 6시"</span><br>
                                <span>"2020년 8월 20일(일) 오후 5시"</span>
                            </dd>
                        </div>
                        <div>
                            <dt>배송정보</dt>
                            <dd><!--예매 테이블 수령방법 컬럼-->
                                <span>본 상품은 일괄배송 상품으로 2020년 08월 10일부터 순차 배송됩니다.</span>
                            </dd>
                        </div>
                    </dl>
                </div>
            </div>
        </div>
    </div>
</section>
<section class="ticketing">
    <div class="container">
        <div class="row">
            <!--달력-->
            <div class="col-12 col-md-7">
                <div class="ticketing-choice">
                <h2>날짜/시간 선택</h2>
                </div>
                <div class="ticketing-desc">
                    <div class="datepicker">
                    </div>
                    <div class="ticketing-detailtime">
                        <!--회차정보-->
                        <a href="#" class="ticketing-button">
                            <span>1회</span>
                            오후 7시 00분
                        </a>
                       <!-- <a href="#" class="ticketing-button">
                            <span>2회</span>
                            오후 9시 00분
                        </a>-->
                    </div>
                </div>
            </div>


            <!--예매가능좌석-->
            <div class="col-12 col-md-5">
                <h2 class="ticketing-title">예매 가능 좌석</h2>
                <div class="ticketing-seat">
                    <div class="ticketing-seat-list">
                        <dl>
                            <dt>스탠딩석</dt>
                            <dd>
                                77,000원<br>
                            <span>(잔여:17석)</span>
                            </dd>


                            <dt>지정석</dt>
                            <dd>
                                87,000원<br>
                            <span>(잔여:20석)</span>
                            </dd>
                        </dl>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<section class="booking">
<div class="container">
    <div class="row">
        <div class="col-12">
            <a href="#" class="booking-button">예매하기</a>
            <a href="#" class="booking-button-invert">Booking</a>
        </div>
    </div>
</div>
</section>
<section class="maincategory">
<div class="container">
    <div class="row">
        <div class="col-12"> <!--선택된 배너에 orange 효과주기-->
            <div class="mainlinks">
            <span class="info">상세정보</span>
            <a href="#review" class="post" >관람후기</a>
            <span class="cancel">예매/취소안내</span>
            </div>
        </div>
    </div>
</div>
</section>
<section class="caution">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <h1 class="caution-title">유의사항</h1>
                <p class="caution-desc">
                    ※ 본 공연은 네이버 쿠폰이 적용되지 않습니다.<br>
                    ※ 본 공연은 YES24공연에서 진행하는 할인쿠폰이벤트 대상에서 제외됩니다.<br>
                    ※ 매수제한 : 회차별 1인 4매
                </p>
            </div>
        </div>
    </div>
</section>
<section class="detail">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="detail-image">
                    <img src="../assets/phantomsingerdetail.jpg" alt="상세설명1">
                    <img src="../assets/phantomsingerdetail2.jpg" alt="상세설명2">
                    <img src="../assets/phantomsingerdetail3.jpg" alt="상세설명3">
                </div>
            </div>
        </div>
    </div>
</section>
<section class="refund">
    <div class="container">
        <div class="row">
            <div class="col-12 justify-content-center">
                <div class="refund-table">
                    <table>
                        <thead>
                            <tr>
                                <th class="refund-title">
                                    취소/환불방법
                                </th>
                            </tr>
                        </thead>

                        <tbody>
                            <tr>
                                <td>
                                    <div class="refund-desc">
                                        <p>
                                            취소 일자에 따라 아래와 같이 취소수수료가 부과됩니다. 예매일보다 관람일 기준이 우선 적용되오니 유의해주시기 바랍니다.
                                            <br>
                                            단, 예매 후 7일 이내라도 취소시점이 공연일로부터 10일 이내라면 그에 해당하는 취소수수료가 부과됩니다.
                                            <br>
                                            (단, 상품에 따라 취소 정책이 달라질 수 있고, 각 공연이 공지하는 취소 정책이 우선 적용되므로, 예매 시 참고하시기 바랍니다.)
                                        </p>

                                        <div class="refund-detail-table">
                                            <table>
                                                <caption></caption>
                                                <colgroup>
                                                    <col width="50%">
                                                    <col width="50%">
                                                </colgroup>
                                                <tbody>
                                                <tr>
                                                    <th scope="col">취소일</th>
                                                    <th scope="col">취소수수료</th>
                                                </tr>
                                                <tr>
                                                    <td>예매 후 7일 이내</td>
                                                    <td>없음</td>
                                                </tr>
                                                <tr>
                                                    <td>예매 후 7일 이내</td>
                                                    <td>없음</td>
                                                </tr>
                                                <tr>
                                                    <td>예매 후 8일~관람일 10일 전까지</td>
                                                    <td>장당 4,000원(단,티켓 금액의 10% 이내)</td>
                                                </tr>
                                                <tr>
                                                    <td>관람일 9일 전~관람일 7일 전까지</td>
                                                    <td>티켓 금액의 10%</td>
                                                </tr>
                                                <tr>
                                                    <td>관람일 6일 전~관람일 3일 전까지</td>
                                                    <td>티켓 금액의 20%</td>
                                                </tr>
                                                <tr>
                                                    <td>관람일 2일 전~취소마감일시까지</td>
                                                    <td>티켓 금액의 30%</td>
                                                </tr>
                                                </tbody>
                                            </table>
                                        </div>


                                        <p>
                                            예매수수료는 예매 당일 밤 12시 이전 취소 시에만 환불되며, 그 이후 기간에는 환불되지 않습니다.
                                            <br>
                                            취소는 MY공연&gt;예매확인/취소 에서 직접 취소 또는 고객센터(1544-6399)를 통해 취소 가능합니다.
                                            <br>
                                            티켓이 배송된 후에는 PC/모바일 취소가 불가, 취소마감시간 이전에 예스24 고객센터로 티켓이 반송되어야 취소 가능합니다.
                                            <br>
                                            (취소수수료는 티켓 도착일 기준으로 부과되며, 배송비는 환불되지 않습니다.)
                                        </p>
                                    </div> <!--div desc-->
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</section>
<section class="map" id="map">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <strong class="map-title">
                    <i class="fas fa-map-marker-alt"></i>
                    예스24스테이지3관
                </strong>
                <div class="map-desc">

                </div>
            </div>
        </div>
    </div>
</section>
<section class="review" id="review">
    <div class="container">
        <div class="row">
            <div class="col-12">

                <div class="review-title">
                    <i class="far fa-comment-dots"></i>
                    <strong>
                        관람후기
                    </strong>
                </div>

                <div class="review-desc">
                    <p class="cautionpara">
                        <span class="caution-red">매매,욕설 등 예스 24 게시판 운영 규정에 위반되는 글은 사전 통보없이 삭제될 수 있습니다.</span>
                        <br>
                        개인정보가 포함된 내용은 삼가 주시기 바라며,게시물로 인해 발생하는 문제는 작성자 본인에게 책임이 있습니다.
                    </p>
                    <div class="review-register">
                        <dl>
                            <dt>평점</dt>
                            <dd class="star">4.94</dd>
                        </dl>
                        <dl>
                            <dt>리뷰</dt>
                            <dd>108</dd>
                        </dl>
                        <span class="review-ok-button">
                            리뷰작성
                        </span>
                    </div>
                    <section class="modal hide">
                        <div class="modal-group">
                            <form class="modal-form">
                                <div class="modal-table">
                                    <div class="modal-title">
                                        <p class="post-title">세상은 한 장의 손수건</p>
                                        <button type="button" class="close-button"><span>+</span></button>
                                    </div>
                                    <div class="row datestar">
                                        <div class="table-title">관람일시</div>
                                        <div class="table-content">관람 내역이 없습니다.</div>
                                    </div>
                                    <div class="row datestar">
                                        <div class="table-title">별점</div>
                                        <div class="table-content starlist">
                                            <span><i class="fas fa-star"></i></span>
                                            <span><i class="fas fa-star"></i></span>
                                            <span><i class="fas fa-star"></i></span>
                                            <span><i class="fas fa-star"></i></span>
                                            <span><i class="fas fa-star"></i></span>
                                            <input type="hidden" name="star" id="star" value="" />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="table-title">관람후기</div>
                                        <div class="table-content">
                                            <textarea name="input-content" class="input-content" maxlength="2000" minlength="50" cols="30" rows="10" placeholder="내용을 작성해주세요.(최소 20byte/최대 2,000byte)"></textarea>
                                        </div>
                                    </div>
                                </div>
                                <div class="post-buttons">
                                    <button type="submit" class="post-ok-button">등록</button>
                                </div>
                            </form>
                        </div>
                    </section>

                </div>
                <div class="review-comments">
                    <ul class="review-comments-list">
                        <li>
                            <div class="review-comment-badge">
                                <span class="reservationbadge">예매자</span>
                                <span class="writerself">본인</span>
                            </div>
                            <div class="review-comment-star">
                                <span>nokwon**</span>
                                <span>2020.08.01</span>
                                <span>
                                    <img src="../assets/icon-orangestar.svg" alt="별점">
                                    <img src="../assets/icon-orangestar.svg" alt="별점">
                                    <img src="../assets/icon-orangestar.svg" alt="별점">
                                    <img src="../assets/icon-orangestar.svg" alt="별점">
                                    <img src="../assets/icon-orangestar.svg" alt="별점">
                                </span>
                            </div>
                            <div class="review-comment-desc">
                                <span>(관람일:2020.08.02)</span>
                                <p>
                                    무대 배경이 되는 프로이트의 서재의 디테일에 놀랐습니다.엔틱하고 다양한 종교상들이 옹기종기~~ 서로의 이야기에 조금씩 공감하는 부분은 있지만 결국 둘은 자신의 소신을 지키는 걸로~~ 작년 ‘에쿠우스’에서 받은 느낌이 강렬해 이석준 배우님 연기도 보고 싶네요. 다른 페어는 어떨까 궁금해지는 공연입니다.
                                </p>
                            </div>
                            <div class="review-comment-bottom">
                                <div class="review-comment-like">
                                    <button type="button" class="like-button" aria-label="Like this property"></button>
                                    <strong class="main-likes-number">
                                        118
                                    </strong>
                                </div>
                                <div class="review-comment-revision">
                                    <span class="revision">수정</span>
                                    <span class="revision">삭제</span>
                                </div>
                            </div>
                        </li>
                        <li>
                            <div class="review-comment-badge">
                                <span class="reservationbadge">예매자</span>
                                <span class="writerself">본인</span>
                            </div>
                            <div class="review-comment-star">
                                <span>nokwon**</span>
                                <span>2020.08.01</span>
                                <span>
                                    <img src="../assets/icon-orangestar.svg" alt="별점">
                                    <img src="../assets/icon-orangestar.svg" alt="별점">
                                    <img src="../assets/icon-orangestar.svg" alt="별점">
                                    <img src="../assets/icon-orangestar.svg" alt="별점">
                                    <img src="../assets/icon-orangestar.svg" alt="별점">
                                </span>
                            </div>
                            <div class="review-comment-desc">
                                <span>(관람일:2020.08.02)</span>
                                <p>
                                    무대 배경이 되는 프로이트의 서재의 디테일에 놀랐습니다.엔틱하고 다양한 종교상들이 옹기종기~~ 서로의 이야기에 조금씩 공감하는 부분은 있지만 결국 둘은 자신의 소신을 지키는 걸로~~ 작년 ‘에쿠우스’에서 받은 느낌이 강렬해 이석준 배우님 연기도 보고 싶네요. 다른 페어는 어떨까 궁금해지는 공연입니다.
                                </p>
                            </div>
                            <div class="review-comment-bottom">
                                <div class="review-comment-like">
                                    <button type="button" class="like-button" aria-label="Like this property"></button>
                                    <strong class="main-likes-number">
                                        118
                                    </strong>
                                </div>
                                <div class="review-comment-revision">
                                    <span class="revision">수정</span>
                                    <span class="revision">삭제</span>
                                </div>
                            </div>
                        </li>
                        <li>
                            <div class="review-comment-badge">
                                <span class="reservationbadge">예매자</span>
                                <span class="writerself">본인</span>
                            </div>
                            <div class="review-comment-star">
                                <span>nokwon**</span>
                                <span>2020.08.01</span>
                                <span>
                                    <img src="../assets/icon-orangestar.svg" alt="별점">
                                    <img src="../assets/icon-orangestar.svg" alt="별점">
                                    <img src="../assets/icon-orangestar.svg" alt="별점">
                                    <img src="../assets/icon-orangestar.svg" alt="별점">
                                    <img src="../assets/icon-orangestar.svg" alt="별점">
                                </span>
                            </div>
                            <div class="review-comment-desc">
                                <span>(관람일:2020.08.02)</span>
                                <p>
                                    무대 배경이 되는 프로이트의 서재의 디테일에 놀랐습니다.엔틱하고 다양한 종교상들이 옹기종기~~ 서로의 이야기에 조금씩 공감하는 부분은 있지만 결국 둘은 자신의 소신을 지키는 걸로~~ 작년 ‘에쿠우스’에서 받은 느낌이 강렬해 이석준 배우님 연기도 보고 싶네요. 다른 페어는 어떨까 궁금해지는 공연입니다.
                                </p>
                            </div>
                            <div class="review-comment-bottom">
                                <div class="review-comment-like">
                                    <button type="button" class="like-button" aria-label="Like this property"></button>
                                    <strong class="main-likes-number">
                                        118
                                    </strong>
                                </div>
                                <div class="review-comment-revision">
                                    <span class="revision">수정</span>
                                    <span class="revision">삭제</span>
                                </div>
                            </div>
                        </li>
                        <li>
                            <div class="review-comment-badge">
                                <span class="reservationbadge">예매자</span>
                                <span class="writerself">본인</span>
                            </div>
                            <div class="review-comment-star">
                                <span>nokwon**</span>
                                <span>2020.08.01</span>
                                <span>
                                    <img src="../assets/icon-orangestar.svg" alt="별점">
                                    <img src="../assets/icon-orangestar.svg" alt="별점">
                                    <img src="../assets/icon-orangestar.svg" alt="별점">
                                    <img src="../assets/icon-orangestar.svg" alt="별점">
                                    <img src="../assets/icon-orangestar.svg" alt="별점">
                                </span>
                            </div>
                            <div class="review-comment-desc">
                                <span>(관람일:2020.08.02)</span>
                                <p>
                                    무대 배경이 되는 프로이트의 서재의 디테일에 놀랐습니다.엔틱하고 다양한 종교상들이 옹기종기~~ 서로의 이야기에 조금씩 공감하는 부분은 있지만 결국 둘은 자신의 소신을 지키는 걸로~~ 작년 ‘에쿠우스’에서 받은 느낌이 강렬해 이석준 배우님 연기도 보고 싶네요. 다른 페어는 어떨까 궁금해지는 공연입니다.
                                </p>
                            </div>
                            <div class="review-comment-bottom">
                                <div class="review-comment-like">
                                    <button type="button" class="like-button" aria-label="Like this property"></button>
                                    <strong class="main-likes-number">
                                        118
                                    </strong>
                                </div>
                                <div class="review-comment-revision">
                                    <span class="revision">수정</span>
                                    <span class="revision">삭제</span>
                                </div>
                            </div>
                        </li>
                        <li>
                            <div class="review-comment-badge">
                                <span class="reservationbadge">예매자</span>
                                <span class="writerself">본인</span>
                            </div>
                            <div class="review-comment-star">
                                <span>nokwon**</span>
                                <span>2020.08.01</span>
                                <span>
                                    <img src="../assets/icon-orangestar.svg" alt="별점">
                                    <img src="../assets/icon-orangestar.svg" alt="별점">
                                    <img src="../assets/icon-orangestar.svg" alt="별점">
                                    <img src="../assets/icon-orangestar.svg" alt="별점">
                                    <img src="../assets/icon-orangestar.svg" alt="별점">
                                </span>
                            </div>
                            <div class="review-comment-desc">
                                <span>(관람일:2020.08.02)</span>
                                <p>
                                    무대 배경이 되는 프로이트의 서재의 디테일에 놀랐습니다.엔틱하고 다양한 종교상들이 옹기종기~~ 서로의 이야기에 조금씩 공감하는 부분은 있지만 결국 둘은 자신의 소신을 지키는 걸로~~ 작년 ‘에쿠우스’에서 받은 느낌이 강렬해 이석준 배우님 연기도 보고 싶네요. 다른 페어는 어떨까 궁금해지는 공연입니다.
                                </p>
                            </div>
                            <div class="review-comment-bottom">
                                <div class="review-comment-like">
                                    <button type="button" class="like-button" aria-label="Like this property"></button>
                                    <strong class="main-likes-number">
                                        118
                                    </strong>
                                </div>
                                <div class="review-comment-revision">
                                    <span class="revision">수정</span>
                                    <span class="revision">삭제</span>
                                </div>
                            </div>
                        </li>
                        <li>
                            <div class="review-comment-badge">
                                <span class="reservationbadge">예매자</span>
                                <span class="writerself">본인</span>
                            </div>
                            <div class="review-comment-star">
                                <span>nokwon**</span>
                                <span>2020.08.01</span>
                                <span>
                                    <img src="../assets/icon-orangestar.svg" alt="별점">
                                    <img src="../assets/icon-orangestar.svg" alt="별점">
                                    <img src="../assets/icon-orangestar.svg" alt="별점">
                                    <img src="../assets/icon-orangestar.svg" alt="별점">
                                    <img src="../assets/icon-orangestar.svg" alt="별점">
                                </span>
                            </div>
                            <div class="review-comment-desc">
                                <span>(관람일:2020.08.02)</span>
                                <p>
                                    무대 배경이 되는 프로이트의 서재의 디테일에 놀랐습니다.엔틱하고 다양한 종교상들이 옹기종기~~ 서로의 이야기에 조금씩 공감하는 부분은 있지만 결국 둘은 자신의 소신을 지키는 걸로~~ 작년 ‘에쿠우스’에서 받은 느낌이 강렬해 이석준 배우님 연기도 보고 싶네요. 다른 페어는 어떨까 궁금해지는 공연입니다.
                                </p>
                            </div>
                            <div class="review-comment-bottom">
                                <div class="review-comment-like">
                                    <button type="button" class="like-button" aria-label="Like this property"></button>
                                    <strong class="main-likes-number">
                                        118
                                    </strong>
                                </div>
                                <div class="review-comment-revision">
                                    <span class="revision">수정</span>
                                    <span class="revision">삭제</span>
                                </div>
                            </div>
                        </li>
                        <li>
                            <div class="review-comment-badge">
                                <span class="reservationbadge">예매자</span>
                                <span class="writerself">본인</span>
                            </div>
                            <div class="review-comment-star">
                                <span>nokwon**</span>
                                <span>2020.08.01</span>
                                <span>
                                    <img src="../assets/icon-orangestar.svg" alt="별점">
                                    <img src="../assets/icon-orangestar.svg" alt="별점">
                                    <img src="../assets/icon-orangestar.svg" alt="별점">
                                    <img src="../assets/icon-orangestar.svg" alt="별점">
                                    <img src="../assets/icon-orangestar.svg" alt="별점">
                                </span>
                            </div>
                            <div class="review-comment-desc">
                                <span>(관람일:2020.08.02)</span>
                                <p>
                                    무대 배경이 되는 프로이트의 서재의 디테일에 놀랐습니다.엔틱하고 다양한 종교상들이 옹기종기~~ 서로의 이야기에 조금씩 공감하는 부분은 있지만 결국 둘은 자신의 소신을 지키는 걸로~~ 작년 ‘에쿠우스’에서 받은 느낌이 강렬해 이석준 배우님 연기도 보고 싶네요. 다른 페어는 어떨까 궁금해지는 공연입니다.
                                </p>
                            </div>
                            <div class="review-comment-bottom">
                                <div class="review-comment-like">
                                    <button type="button" class="like-button" aria-label="Like this property"></button>
                                    <strong class="main-likes-number">
                                        118
                                    </strong>
                                </div>
                                <div class="review-comment-revision">
                                    <span class="revision">수정</span>
                                    <span class="revision">삭제</span>
                                </div>
                            </div>
                        </li>
                        <li>
                            <div class="review-comment-badge">
                                <span class="reservationbadge">예매자</span>
                                <span class="writerself">본인</span>
                            </div>
                            <div class="review-comment-star">
                                <span>nokwon**</span>
                                <span>2020.08.01</span>
                                <span>
                                    <img src="../assets/icon-orangestar.svg" alt="별점">
                                    <img src="../assets/icon-orangestar.svg" alt="별점">
                                    <img src="../assets/icon-orangestar.svg" alt="별점">
                                    <img src="../assets/icon-orangestar.svg" alt="별점">
                                    <img src="../assets/icon-orangestar.svg" alt="별점">
                                </span>
                            </div>
                            <div class="review-comment-desc">
                                <span>(관람일:2020.08.02)</span>
                                <p>
                                    무대 배경이 되는 프로이트의 서재의 디테일에 놀랐습니다.엔틱하고 다양한 종교상들이 옹기종기~~ 서로의 이야기에 조금씩 공감하는 부분은 있지만 결국 둘은 자신의 소신을 지키는 걸로~~ 작년 ‘에쿠우스’에서 받은 느낌이 강렬해 이석준 배우님 연기도 보고 싶네요. 다른 페어는 어떨까 궁금해지는 공연입니다.
                                </p>
                            </div>
                            <div class="review-comment-bottom">
                                <div class="review-comment-like">
                                    <button type="button" class="like-button" aria-label="Like this property"></button>
                                    <strong class="main-likes-number">
                                        118
                                    </strong>
                                </div>
                                <div class="review-comment-revision">
                                    <span class="revision">수정</span>
                                    <span class="revision">삭제</span>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
                <div class="review-pagination">
                    <a href="#">
                        <i class="fas fa-chevron-left"></i>
                    </a>
                    <div>
                        <a href="#">
                            <span>1</span>
                        </a>
                        <a href="#">
                            <span>2</span>
                        </a>
                        <a href="#">
                            <span>3</span>
                        </a>
                        <a href="#">
                            <span>4</span>
                        </a>
                        <a href="#">
                            <span>5</span>
                        </a>
                        <a href="#">
                            <span>6</span>
                        </a>
                        <a href="#">
                            <span>7</span>
                        </a>
                        <a href="#">
                            <span>8</span>
                        </a>
                        <a href="#">
                            <span>9</span>
                        </a>
                        <a href="#">
                            <span>10</span>
                        </a>
                    </div>
                    <a href="#">
                        <i class="fas fa-chevron-right"></i>
                    </a>
                </div>
            </div>
        </div>
    </div>
</section>
<section class="notice hide">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="info-1">
                    <div class="info-1-title">
                       <h2> 예매 </h2>
                    </div>
                    <div class="info-1-desc">
                        <p>
                            예매는 PC, 모바일, 고객센터 를 통해 신용카드, 가상계좌(무통장 입금), YES머니, YES상품권, 예치금 등으로 예매하실 수 있습니다.
                            <br>
                            (단, 상품마다 사용 가능한 결제 수단이 다르게 적용될 수 있으니 상품 상세페이지 안내 사항을 확인해주세요.)
                            <br>
                            무통장입금 결제 선택 시 입금 마감시간은 예매일 익일 밤 11시 29분까지
                            입니다. 입금 마감시간 내 미입금 된 경우 예매가 자동 취소됩니다.
                            <br>
                            (단, 상품에 따라 예매 당일 밤 11시 29분에 마감되는 경우가 있으니 예매 전후 반드시 확인해주시기 바랍니다.)
                            <br>
                            예매수수료는 다음과 같습니다.
                        </p>
                        <table>
                            <thead>
                                <tr>
                                    <th>장르</th>
                                    <th>pc/모바일</th>
                                    <th>전화예매</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>콘서트,뮤지컬,클래식,국악,무용</td>
                                    <td>장당 1,000원</td>
                                    <td rowspan="3">장당 2,000원</td>
                                </tr>
                                <tr>
                                    <td>연극,전시</td>
                                    <td>장당 500원</td>
                                </tr>
                                <tr>
                                    <td>체험,행사</td>
                                    <td>장당 300원</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<button type="button" class="return-top-button" aria-label="Back to top">
    <img src="../assets/curvey.jpg" alt="">
</button>
<script src="../script/detailpage.js"></script>
</body>
</html>
    