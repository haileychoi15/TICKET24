<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% String ctxPath = request.getContextPath(); %>    

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>예매 상세</title>
    <link rel="stylesheet" type="text/css" href="resources/css/bookingInfo.css">
    <script src="https://kit.fontawesome.com/c3eca5a54c.js" crossorigin="anonymous"></script>
        
    <script type="text/javascript" src="<%= request.getContextPath()%>/resources/js/jquery-3.3.1.min.js"></script>
    
    <script type="text/javascript">
    
    	$(document).ready(function(){
    		
    	});	
    
    	
    	
    </script>
    
</head>
<body>
    <div id="container">
        <div id="showInfoBox">
            <img src="resources/images/${infoList.prod_img }" alt="poster" height="250px">
            <div id="showInfo">
                <div id="showName">${infoList.prod_title}</div>
                <div id="showInfoText">
                    <dl>
                        <dt>예매번호</dt>
                        <dd class="color">${infoList.rev_id }</dd>
                        <dt>공연장</dt>
                        <dd>${infoList.map_name }</dd>
                    </dl>
                    <dl>
                        <dt>예매일시</dt>
                        <dd>${infoList.rev_date }</dd>
                        <dt>예매자</dt>
                        <dd>${sessionScope.loginuser.name }</dd>
                    </dl>
                    <dl>
                        <dt>관람일시</dt>
                        <dd>${infoList.date_showday }</dd>
                        <dt>취소가능일</dt>
                        <dd>${infoList.cancel_day }까지</dd>
                    </dl>
                    <dl>
                        <dt>매수</dt>
                        <dd>${infoList.rev_qnty }매</dd>
                        <dt>상태</dt>
                        <c:if test="${infoList.status == '1' }">
							<dd>예매완료</dd>
		                </c:if>
		                <c:if test="${infoList.status == '0' }">
							<dd>취소완료</dd>
		                </c:if>
		                <c:if test="${infoList.status == '2' }">
							<dd>입금대기</dd>
		                </c:if>
                        
                        
                    </dl>
                </div>
            </div>
        </div>

        <div class="title">티켓수령방법</div>
        <table class="contentTbl">
            <tr>
                <td class="contentTd">수령방법</td>
                <td class="contentTd2">배송 <a href="">배송 상세</a></td> <!-- css 추후 적용 -->
                <!-- 또는 ///  현장수령 | 공연 당일 현장 교부처에서 예매번호 및 본인 확인 후 티켓을 수령하여 입장이 가능합니다. -->
            </tr>
        </table>

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
                
                <c:forEach var="seat" items="${seatInfoList}" varStatus="status">
	                <tr class="tblContent">
	                    <td>${seat.seat_type}석</td>
	                    <td>${seat.seat_name }</td>
	                    <td>일반(금토일)</td>
	                    <td><fmt:formatNumber value="${seat.seat_price}" pattern="###,###" /> 원</td>
	                    <c:if test="${seat.seat_status == '1'}">
	                    	<td><label for="cancel1">취소 가능</label><input type="checkbox" id="cancel1"></td>
	                    </c:if>
	                    <c:if test="${seat.seat_status == '0'}">
	                    	<td><label for="cancel1">취소 완료</label></td>
	                    </c:if>
	                </tr>
                </c:forEach>

                <tr class="cancelBtn">
                    <td colspan="4">
                        <p id="cancelTime">${infoList.cancel_day } 까지 예매취소가능</p>
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

        <div class="title">결제 내역</div>
        <table class="contentTbl">
            <tr>
                <td class="contentTd">결제방법</td>
                <td class="contentTd2"></td> <!-- 신용카드/무통장입금 -->
            </tr>
            <!-- 아래 부분은 카드결제시 안나오게 -->
            <tr>
                <td class="contentTd">입금마감시간</td>
                <td class="contentTd2"></td>
            </tr>
            <tr>
                <td class="contentTd">입금계좌</td>
                <td class="contentTd2"></td>
            </tr>
            <tr>
                <td class="contentTd">예금주명</td>
                <td class="contentTd2"></td>
            </tr>
            <tr>
                <td class="contentTd">입금상태</td>
                <td class="contentTd2"></td>
            </tr>
        </table>

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
            <button onclick="location.href='<%=ctxPath%>/myTicket.action'">목록</button>
        </div>
    </div>
</body>
</html>