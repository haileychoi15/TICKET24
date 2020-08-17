<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>예매 상세</title>
    <link rel="stylesheet" type="text/css" href="bookingInfo.css">
    <script src="https://kit.fontawesome.com/c3eca5a54c.js" crossorigin="anonymous"></script>
</head>
<body>
    <div id="container">
        <div id="showInfoBox">
            <img src="https://cdnticket.melon.co.kr/resource/image/upload/product/2020/05/20200528104334ce28c4f9-534e-45c0-8f1a-e75a7e18abe3.jpg" alt="poster" height="250px">
            <div id="showInfo">
                <div id="showName">뮤지컬 〈캣츠〉 40주년 내한공연－서울（Musical CATS）</div>
                <div id="showInfoText">
                    <dl>
                        <dt>예매번호</dt>
                        <dd class="color">1234567</dd>
                        <dt>공연장</dt>
                        <dd>세종문화회관 대극장</dd>
                    </dl>
                    <dl>
                        <dt>예매일시</dt>
                        <dd>2020.08.20</dd>
                        <dt>예매자</dt>
                        <dd>이호연</dd>
                    </dl>
                    <dl>
                        <dt>관람일시</dt>
                        <dd>2020.08.15(화) 19:00</dd>
                        <dt>취소가능일</dt>
                        <dd>2020.08.14 23:59까지</dd>
                    </dl>
                    <dl>
                        <dt>매수</dt>
                        <dd>1매</dd>
                        <dt>상태</dt>
                        <dd>예매완료</dd>
                    </dl>
                </div>
            </div>
        </div>

        <div class="title seat">좌석 정보</div>
        <div class="seat allSel"><input type="checkbox" id="all"><label for="all">전체 선택</label></div>
        <div id="seatInfo">
            <table>
                <tr id="tblTop">
                    <td width="15%">좌석등급</td>
                    <td width="15%">좌석번호</td>
                    <td width="40%">가격등급</td>
                    <td width="15%">구매</td>
                    <td width="15%">예매/취소</td>
                </tr>
                <tr class="tblContent">
                    <td>A석</td>
                    <td>2층 A열 19번</td>
                    <td>일반(금토일)</td>
                    <td>80,000원</td>
                    <td><label for="cancel1">취소 가능</label><input type="checkbox" id="cancel1"></td>
                </tr>
                <tr class="tblContent">
                    <td>A석</td>
                    <td>2층 A열 19번</td>
                    <td>일반(금토일)</td>
                    <td>80,000원</td>
                    <td><label for="cancel2">취소 가능</label><input type="checkbox" id="cancel2"></td>
                </tr>
                <tr class="cancelBtn">
                    <td colspan="4">
                        <p id="cancelTime">2020년 08월 13일 17시 00분까지 예매취소가능</p>
                        <em>*예매일 이후 취소 시 예매 수수료는 환불되지 않습니다. (단, 예매 당일 밤 12시 이전 취소 시에는 취소수수료 없음)</em>
                    </td>
                    <td><button>예매취소 요청</button></td>
                </tr>
            </table>
        </div>

        <div class="title">구매 내역</div>
        <div id="receipt">
            <div class="receiptItem">
                <dl>
                    <dt>티켓금액</dt>
                    <dd>80,000</dd>
                    <dt class="small">기본가</dt>
                    <dd class="small">80,000</dd>
                    <dt class="small">가격할인</dt>
                    <dd class="small">0</dd>
                    <dt class="small">쿠폰할인</dt>
                    <dd class="small">0</dd>
                    <dt class="small">포인트</dt>
                    <dd class="small">0</dd>
                </dl>
            </div>
            <div class="receiptItem plus"></div>
            <div class="receiptItem">
                <dl>
                    <dt>예매수수료</dt>
                    <dd>1,000</dd>
                    <dt>배송료</dt>
                    <dd></dd>
                </dl>
            </div>
            <div class="receiptItem equals"></div>
            <div class="receiptItem">
                <dl>
                    <dt class="color">총 구매금액</dt>
                    <dd class="big color">81,000</dd>
                </dl>
            </div>
        </div>

        <div class="title">유의사항</div>
        <div id="caution">
            <ul>
                <li>취소마감시간 이후 또는 관람일 당일 예매하신 건에 대해서는 취소/변경/환불이 불가합니다.</li>
                <li>예매수수료는 예매 당일 밤 12시 이전까지 취소 시 환불 가능합니다.</li>
                <li>배송이 시작된 경우 취소마감시간이전까지 멜론티켓 고객센터로 티켓을 반환해주셔야 환불이 가능하며, 도착한 일자 기준으로 취소수수료가 부과됩니다.<br>
                    (* 단, 반환된 티켓의 배송료는 환불되지 않으며 일괄배송 상품의 경우 취소에 대한 자세한 문의는 고객센터로 문의해 주시기 바랍니다.)</li>
                <li>지역 및 배송서비스 사정에 따라 배송사가 변경될 수 있으며, 배송일이 추가적으로 소요될 수 있습니다. (CJ대한통운, 우체국 외 1개 업체)</li>
                <li>일괄배송의 경우 공연 별로 배송일자가 상이하며 지정된 배송일자 기준으로 배송이 시작됩니다.<br>
                    (* 지정된 배송일자는 상세정보 및 예매공지사항에서 확인할 수 있습니다.)</li>
                <li>구매한 모바일티켓을 타인에게 전달한 경우, 구매자 본인에게 티켓이 회수된 후에 예매취소가 가능합니다.</li>
                <li>예매취소 시점과 결제 시 사용하신 신용카드사의 환불 처리기준에 따라 취소금액의 환급방법과 환급일은 다소 차이가 있을 수 있습니다.</li>
                <li>신용카드 할부결제로 구매하신 과티켓 수량의 일부를 취소하실 경우, 신용카드사의 사정에 따라 혜택(무이자 할부 등)의 적용 여부가 달라질 수 있음을 유의하시기 바랍니다.</li>
                <li>기타 문의사항은 이용안내를 참조하시거나 고객센터 1899-0042 혹은 1:1문의를 이용하시기 바랍니다.</li>
            </ul>
        </div>

        <div id="listBtn">
            <button>목록</button>
        </div>
    </div>
</body>
</html>