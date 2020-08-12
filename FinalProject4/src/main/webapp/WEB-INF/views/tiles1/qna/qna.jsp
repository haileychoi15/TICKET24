<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QNA page</title>
    <link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="resources/css/grid.min.css">
    <link rel="stylesheet" href="resources/css/reset.css">
    <link rel="stylesheet" href="resources/css/qna.css">
    <script src="https://kit.fontawesome.com/5342aa1b58.js" crossorigin="anonymous"></script>
</head>
<body>
    <section class="search">
        <div class="search-group">
            <h1>자주찾는 FAQ</h1>
            <p>
                TICKET24에 자주 묻는 질문들을 모아 답변과 함께 알려드립니다.
                    <br />
                찾으시는 답변이 없으면 1:1 문의를 이용해주세요.
            </p>
            <form class="search-form">
                <input name="search-word" class="search-word" type="text">
                <button type="button" class="search-button">검색</button>
            </form>
        </div>
    </section>
    <main class="qna">
        <div class="container">
            <div class="col-12">
                <h1>자주찾는 FAQ</h1>
                <div class="category">
                    <div class="category-group">
                        <button type="button" value="0" class="selected">전체</button>
                        <button type="button" value="1" >예매/결제</button>
                        <button type="button" value="2" >티켓수령</button>
                        <button type="button" value="3" >취소/환불</button>
                        <button type="button" value="4" >기타</button>
                    </div>
                </div>
            </div>
            <div class="col-12">
                <div class="table">
                    <div class="thead">
                        <div class="row">
                            <span class="table-category">
                                구분
                            </span>
                            <span class="table-title">
                                제목
                            </span>
                        </div>
                    </div>
                    <div class="tbody">
                        <div class="row">
                            <span class="table-category">
                                예매/결제
                            </span>
                            <span class="table-title">
                                예매한 공연의 날짜와 시간을 변경할 수 있나요?
                            </span>
                            <div class="table-content">
                                예매 건의 날짜, 시간, 좌석 등의 일부 변경을 원하실 경우 재예매 하신 후 기존 예매를 취소해 주셔야 합니다. 단, 취소 마감시간 전까지만 가능하며, 취소 시점에 따라 예매수수료가 환불 되지 않으며 취소 수수료가 부과될수 있습니다.
                            </div>
                        </div>
                        <div class="row">
                            <span class="table-category">
                                예매/결제
                            </span>
                            <span class="table-title">
                                한 번 예매할 때 최대 몇 장까지 예매할 수 있나요?
                            </span>
                            <div class="table-content">
                                예매 건의 좌석 변경을 원하실 경우 재예매 하신 후 기존 예매를 취소해주셔야 합니다. 단, 취소 마감시간 전까지만 가능하며, 취소 시점에 따라 예매수수료가 환불되지 않으며 취소 수수료가 부과될 수있습니다.
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-12">
                <div class="page-group">
                    <button type="button" class="page-button selected" aria-label="Go to page1">1</button>
                    <button type="button" class="page-button" aria-label="Go to page2">2</button>
                    <button type="button" class="page-button" aria-label="Go to page3">3</button>
                </div>
            </div>
            <div class="col-12">
                <button type="button" class="qna-button">
                    <p>
                        찾으시는 답변이 없나요? <strong>1:1문의하기</strong>
                    </p>
                </button>
            </div>
        </div>
    </main>
    <section class="modal">
        <div class="modal-group">
            <header class="modal-header">
                <button type="button" class="close-button" aria-label="Close this modal">+</button>
                <h1>1:1 문의쓰기</h1>
            </header>
            <div class="modal-content">
                <form class="modal-form" onsubmit="return validateForm();">
                    <div class="modal-table">
                        <div class="row sort">
                            <div class="table-title">구분</div>
                            <div class="table-content">
                                <div class="modal-input-group">
                                    <input name="qna-category" id="category1" type="radio" value="1"/>
                                    <label for="category1">예매/결제</label>
                                    <input name="qna-category" id="category2" type="radio" value="2"/>
                                    <label for="category2">티켓수령</label>
                                    <input name="qna-category" id="category3" type="radio" value="3"/>
                                    <label for="category3">취소/환불</label>
                                    <input name="qna-category" id="category4" type="radio" value="4"/>
                                    <label for="category4">기타</label>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="table-title">공연</div>
                            <div class="table-content">
                                <select name="qna-product">
                                    <option value="0" class="qna-product-default" selected>해당사항 없음</option>
                                    <option value="">오페라의 유령</option>
                                    <option value="">엄마를 부탁해</option>
                                </select>
                            </div>
                        </div>
                        <div class="row">
                            <div class="table-title">성명</div>
                            <div class="table-content">최유영</div>
                        </div>
                        <div class="row">
                            <div class="table-title">아이디</div>
                            <div class="table-content">imdud0612</div>
                        </div>
                        <div class="row title">
                            <div class="table-title">제목</div>
                            <div class="table-content">
                                <input name="qna-title" class="qna-title" type="text" placeholder="제목을 입력해주세요."/>
                            </div>
                        </div>
                        <div class="row content">
                            <div class="table-title">내용</div>
                            <div class="table-content">
                                <textarea name="qna-content" class="qna-content" maxlength="500" cols="30" rows="3" placeholder="최대 500자까지 입력가능합니다."></textarea>
                            </div>
                        </div>
                    </div>
                    <button type="submit" class="qna-ok-button">등록하기</button>
                </form>
            </div>
        </div>
    </section>
    <script src="resources/js/qna.js"></script>
</body>
</html>