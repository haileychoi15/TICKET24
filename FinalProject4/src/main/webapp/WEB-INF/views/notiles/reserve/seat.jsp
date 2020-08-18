<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>YES24 공연 예매</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="http://tkfile.yes24.com/img/favicon.ico?ver=150825a" type="image/x-icon">
    <link rel="stylesheet" type="text/css" media="(max-width: 767px)" href="resources/css/seatMobile.css">
    <link rel="stylesheet" type="text/css" media="(min-width:768px)" href="resources/css/seatDesktop.css">
    <script src="https://kit.fontawesome.com/c3eca5a54c.js" crossorigin="anonymous"></script>
</head>
<body>
    <div id="container">
        <div id="step1" style="display: block"> <!--좌석 선택-->
            <div id="step1Grid">
                <div id="step1Top">
                    <div id="changeArea">
                        <span>관람일 변경</span>
                        <select id="changeDate">
                            <option>날짜 선택</option>
                        </select>
                        <span>회차 변경</span>
                        <select id="changeRound">
                            <option>회차 선택</option>
                        </select>
                    </div>
                    <div class="showName" id="mobileTitle"></div>
                </div>
                <div id="seatBox">
                    <div id="seatArea"></div>
                </div>
                <div id="seatInfo">
                    <h3 class="showName"></h3>
                    <p id="showInfoTitle">▾공연 정보</p>
                    <table id="showInfo">
                        <tr>
                            <th>장소</th>
                            <td id="showLocation"></td>
                        </tr>
                        <tr>
                            <th>관람 등급</th>
                            <td id="showGrade"></td>
                        </tr>
                        <tr>
                            <th>관람 시간</th>
                            <td id="showTime"></td>
                        </tr>
                    </table>
                    <p id="seatPriceTitle">▾좌석 등급/가격</p>
                    <div id="seatPrice">
                        <c:forEach var="seatType" items="${getSeatType}">
                        	<div class="seatPriceItem">
	                            <div class="gradeCol" style="background-color: ${seatType.seat_color}"></div>
	                            <p>&nbsp;${seatType.seat_type}석 ${seatType.seat_price}원</p>
                        	</div>
                        </c:forEach>
                    </div>
                    <div id="selectedSeatBox">
                        <p id="selectedSeatTitle">▾선택한 좌석</p>
                        <div id="selectedSeat"></div>
                    </div>
                    <div id="btnBox">
                        <button id="reset" onclick="reset()">좌석 다시 선택</button>
                        <button id="next" onclick="seatSelComplete()">좌석 선택 완료</button>
                    </div>
                    
                    <form name="convey" style="display: none">
                    	<input type="text" name="showdate" id="showdate" value="">
                    	<input type="text" name="showtime" id="showtime" value="">
                    </form>
                </div>
            </div>
        </div>

        <div id="fromStep2" style="display: none">
            <div id="fromStep2Grid">
                <div id="step2" style="display: none"> <!--할인/쿠폰-->
                    <div class="nStep">
                        <div class="nStepDiv">
                            <div class="gray"><span>&nbsp;STEP1&nbsp;</span>&nbsp;좌석 선택&nbsp;<img src="<%= request.getContextPath() %>/resources/images/arrowRight.png" alt="arrowRight">&nbsp;</div>
                            <div class="color"><span>&nbsp;STEP2&nbsp;</span>&nbsp;할인 선택&nbsp;</div>
                            <div class="gray"><img src="<%= request.getContextPath() %>/resources/images/arrowRight.png" alt="arrowRight">&nbsp;<span>&nbsp;STEP3&nbsp;</span>&nbsp;배송 방법&nbsp;</div>
                            <div class="gray"><img src="<%= request.getContextPath() %>/resources/images/arrowRight.png" alt="arrowRight">&nbsp;<span>&nbsp;STEP4&nbsp;</span>&nbsp;결제 방법</div>
                        </div>
                    </div>
                    <div class="content" id="saleArea">
                        <div id="discount">
                            <h3>할인을 선택하세요</h3>
                            <div id="discountTbl">
                                <table>
                                    <thead align="center">
                                    <tr>
                                        <td class="row1">할인명</td>
                                        <td class="row2">할인 금액</td>
                                        <td class="row3">선택</td>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td class="row1">국가유공자할인 (25% 할인)&nbsp;<em>[배송불가]</em></td>
                                        <td class="row2"><span style="display:none" id="dc1"></span><span id="dc1Display"></span></td>
                                        <td class="row3">
                                            <input type="checkbox" id="dcCheck1" onclick="changeDC()">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="row1">복지할인 (중증, 1~3급, 25% 할인)&nbsp;<em>[배송불가]</em></td>
                                        <td class="row2"><span style="display:none" id="dc2"></span><span id="dc2Display"></span></td>
                                        <td class="row3">
                                        	<input type="checkbox" id="dcCheck2" onclick="changeDC()">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="row1">복지할인 (경증, 4~6급, 15% 할인)&nbsp;<em>[배송불가]</em></td>
                                        <td class="row2"><span style="display:none" id="dc3"></span><span id="dc3Display"></span></td>
                                        <td class="row3">
                                            <input type="checkbox" id="dcCheck3" onclick="changeDC()">
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div id="coupon">
                            <h3>쿠폰을 선택하세요</h3>
                            <div id="couponTbl">
                                <table>
                                    <thead align="center">
                                    <tr>
                                        <td class="row1">쿠폰명</td>
                                        <td class="row2">할인 금액</td>
                                        <td class="row3">사용</td>
                                    </tr>
                                    </thead>
                                    <tbody class="couponList">
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <p><em>주의사항)</em> 할인은 자동선택 되지 않으니, <em>적용 받고자 하는 할인이 있는 경우 직접 선택</em>해주시기 바랍니다.</p>
                    </div>
                </div>

                <div id="step3" style="display: none"> <!--수령 방법-->
                    <div class="nStep">
                        <div class="nStepDiv">
                            <div class="gray"><span>&nbsp;STEP1&nbsp;</span>&nbsp;좌석 선택&nbsp;<img src="<%= request.getContextPath() %>/resources/images/arrowRight.png" alt="arrowRight">&nbsp;</div>
                            <div class="gray"><span>&nbsp;STEP2&nbsp;</span>&nbsp;할인 선택&nbsp;<img src="<%= request.getContextPath() %>/resources/images/arrowRight.png" alt="arrowRight">&nbsp;</div>
                            <div class="color"><span>&nbsp;STEP3&nbsp;</span>&nbsp;배송 방법&nbsp;</div>
                            <div class="gray"><img src="<%= request.getContextPath() %>/resources/images/arrowRight.png" alt="arrowRight">&nbsp;<span>&nbsp;STEP4&nbsp;</span>&nbsp;결제 방법</div>
                        </div>
                    </div>
                    <div class="content" id="deliveryArea">
                        <h3>수령 방법을 선택하세요</h3>
                        <div id="radioDiv">
                            <input type="radio" id="willCall" name="receive" value="0" onclick="deliverySel()" checked>&nbsp;<label for="willCall">현장수령</label>
                            <span id="deliverySpan"><input type="radio" id="delivery" name="receive" value="1" onclick="deliverySel()">&nbsp;<label for="delivery">배송(2,500원)</label></span>
                        </div>
                        <div class="selectInfo">
                            <div id="ordererInfo">
                                <div class="infoTitle">주문자 정보</div>
                                <div id="ordererName">
                                    <div class="ordererRow1">이름</div>
                                    <div class="ordererRow2"><input type="text" size="15" id="conveyName"></div>
                                </div>
                                <div id="ordererCall">
                                    <div class="ordererRow1">연락처</div>
                                    <div class="ordererRow2"><input type="text" size="3" maxlength="3" id="conveyHP1"> - <input type="text" size="4" maxlength="4" id="conveyHP2"> - <input type="text" size="4" maxlength="4" id="conveyHP3"></div>
                                </div>
                                <div id="ordererEmail">
                                    <div class="ordererRow1">이메일</div>
                                    <div class="ordererRow2"><input type="text" size="20" id="conveyEmail"></div>
                                </div>
                            </div><br>
                            <div id="deliveryInfo" style="display: none;">
                                <div class="infoTitle">배송지 정보 <span id="exclamation" onmouseenter="deliveryCaution()" onmouseleave="deliveryCautionEnd()">!</span>
                                    <div id="deliveryRadio">
                                        <input type="radio" id="same" name="address" onclick="ChangeAddressInfo(1)"><label for="same">주문자 정보와 동일</label>
                                        <input type="radio" id="new" name="address" onclick="ChangeAddressInfo(3)"><label for="new">새로 입력</label>
                                    </div>
                                </div>
                                <div id="deliveryName">
                                    <div class="deliveryRow1">받으시는 분</div>
                                    <div class="deliveryRow2"><input type="text" size="15" id="deliveryName" value=""></div>
                                </div>
                                <div id="deliveryCall">
                                    <div class="deliveryRow1">연락처</div>
                                    <div class="deliveryRow2"><input type="text" size="3" maxlength="3"> - <input type="text" size="4" maxlength="4"> - <input type="text" size="4" maxlength="4"></div>
                                </div>
                                <div id="deliveryAddress">
                                    <div class="deliveryRow1">주소</div>
                                    <div class="deliveryRow2">
                                        <input id="postNo" type="text" size="5" id="deliveryPostNo">&nbsp;
                                        <input id="address" type="text" size="25" id="deliveryAddress">&nbsp;
                                        <button class="btn" onclick="setAddress()">우편번호검색</button>
                                    </div>
                                </div>
                                <div id="deliveryDetailAddress">
                                    <div class="deliveryRow1">상세주소</div>
                                    <div class="deliveryRow2"><input id="detailAddress" type="text" size="20" id="deliveryDetailAddress"></div>
                                </div>
                            </div>
                            <div id="caution" style="display: none;">
                                <strong>주의사항</strong> * 부정확한 정보 입력으로 인한 문제 발생 시 예스24는 책임을 지지 않습니다. <br><br>
                                1) <em>배송 선택 시 티켓 수령자의 배송지 정보를 정확히 입력해주시기 바랍니다.</em><br>
                                2) <em>티켓은 유가증권으로 본인에게 직접 전달해야하며, 분실된 티켓은 재발권 되지 않습니다.</em><br>
                                3) <em>일괄배송의 경우 정해진 날짜에 티켓 배송이 시작되며, 주소 수정은 일괄배송일 2일 전까지 가능합니다.</em><br>
                                4) <em>예매 티켓 배송은 예매완료일, 혹은 일괄배송일로부터 4~5일(영업일 기준) 이내 수령 가능합니다.</em><br>
                                5) 긴급연락처는 공연 취소와 같은 유사 시 안내 받으실 연락처이므로 정확히 입력해주시기 바랍니다. <br>
                                6) 이메일 정보 미 입력 시 예매 관련 안내 메일을 받을 수 없으니 이메일 받기를 원하시는 경우 마이페이지에서 회원정보를 수정해주시기 바랍니다.
                            </div>
                        </div>
                    </div>
                </div>

                <div id="step4" style="display: none"> <!--결제 방법-->
                    <div class="nStep">
                        <div class="nStepDiv">
                            <div class="gray"><span>&nbsp;STEP1&nbsp;</span>&nbsp;좌석 선택&nbsp;<img src="<%= request.getContextPath() %>/resources/images/arrowRight.png" alt="arrowRight">&nbsp;</div>
                            <div class="gray"><span>&nbsp;STEP2&nbsp;</span>&nbsp;할인 선택&nbsp;<img src="<%= request.getContextPath() %>/resources/images/arrowRight.png" alt="arrowRight">&nbsp;</div>
                            <div class="gray"><span>&nbsp;STEP3&nbsp;</span>&nbsp;배송 방법&nbsp;<img src="<%= request.getContextPath() %>/resources/images/arrowRight.png" alt="arrowRight">&nbsp;</div>
                            <div class="color"><span>&nbsp;STEP4&nbsp;</span>&nbsp;결제 방법</div>
                        </div>
                    </div>
                    <div class="content" id="paymentArea">
                        <h3>결제 방법을 선택하세요</h3>
                        <div id="paymentDiv">
                            <div class="paymentCol1 paymentRow1">적립금</div>
                            <div class="paymentCol2 paymentRow1">
                                <input type="text" size="10" value="0"> 원&nbsp;
                                <input type="checkbox" id="allSel">
                                <label for="allSel">전액사용 (총 <span id="point"></span>원)</label>
                            </div>
                            <div class="paymentCol1 paymentRow2">결제방법</div>
                            <div class="paymentCol2 paymentRow2">
                                <input type="radio" name="paymentMethod" id="card"><label for="card"> 신용카드</label>&nbsp;&nbsp;&nbsp;
                                <input type="radio" name="paymentMethod" id="deposit"><label for="deposit"> 무통장 입금</label>
                                <select name="bank" id="bank">
                                    <option selected>입금은행 선택</option>
                                    <option value="국민은행">국민은행</option>
                                    <option value="신한은행">신한은행</option>
                                    <option value="농협중앙회">농협중앙회</option>
                                    <option value="우리은행">우리은행</option>
                                    <option value="우체국">우체국</option>
                                </select>
                            </div>
                        </div>
                        <h3>예매자 동의</h3>
                        <div id="refundAgree">
                            <div id="refundAgreeDiv">
                                <input type="checkbox" id="refundConfirm" name="confirm"><label for="refundConfirm">[필수] 예매 및 취소 수수료/취소기한을 확인하였으며 동의합니다.</label>&nbsp;
                            </div>
                            <table id="refundFee">
                                <tr>
                                    <td class="refundCol1 refundRow1">취소일</td>
                                    <td class="refundCol1 refundRow2">취소수수료</td>
                                </tr>
                                <tr>
                                    <td class="refundRow1">예매 후 7일 이내</td>
                                    <td class="refundRow2">없음</td>
                                </tr>
                                <tr>
                                    <td class="refundRow1">예매 후 8일 ~ 관람일 10일 전까지</td>
                                    <td class="refundRow2">장당 4,000원 (티켓 금액의 10% 한도)</td>
                                </tr>
                                <tr>
                                    <td class="refundRow1">관람일 9일 전 ~ 관람일 7일 전까지</td>
                                    <td class="refundRow2">티켓 금액의 10%</td>
                                </tr>
                                <tr>
                                    <td class="refundRow1">관람일 6일 전 ~ 관람일 3일 전까지</td>
                                    <td class="refundRow2">티켓 금액의 20%</td>
                                </tr>
                                <tr>
                                    <td class="refundRow1">관람일 2일 전 ~ 관람일 1일 전까지</td>
                                    <td class="refundRow2">티켓 금액의 30%</td>
                                </tr>
                            </table>
                            <div id="remarks">
                                - 취소 시 예매수수료는 예매 당일 밤 12시 이전까지만 환불됩니다.<br>
                                - 예매 후 7일 이내라도 취소시점이 관람일로부터 10일 이내라면 그에 해당하는 취소수수료가 부과됩니다.<br>
                                - 관람 당일 취소 가능 상품의 경우 관람 당일 취소 시 티켓금액의 90%가 취소수수수료로 부과됩니다.
                            </div>
                        </div>
                        <div class="agree">
                            <input type="checkbox" id="paymentConfirm" name="confirm"><label for="paymentConfirm">[필수] 결제대행 서비스 표준이용약관을 확인하였으며 동의합니다.</label>&nbsp;
                        </div>
                        <div class="agree">
                            <input type="checkbox" id="kakaoConfirm" name="confirm"><label for="kakaoConfirm">[필수] 카카오 전자금융 이용약관을 확인하였으며 동의합니다.</label>&nbsp;
                        </div>
                        <div class="agree">
                            <input type="checkbox" id="infoOfferConfirm" name="confirm"><label for="infoOfferConfirm">[필수] 개인정보 제3자 제공에 동의하며 주의사항을 확인하였습니다.</label>&nbsp;
                        </div>
                        <div class="agree">
                            <input type="checkbox" id="infoUseConfirm" name="confirm"><label for="infoUseConfirm">[필수] 개인정보 수집 및 이용에 동의합니다.</label>&nbsp;
                        </div>
                    </div>
                </div>

                <div id="sideBar" style="display: none">
                    <div id="logo">
                        <img src="<%= request.getContextPath() %>/resources/images/TICKET24.png" alt="ticket24Logo" width="35px">&nbsp;<h2>TICKET24</h2>
                    </div>
                    <div id="sideInfo">
                        <div class="showName"></div>
                        <div id="bkgShowInfoTitle">예매 정보</div>
                        <div id="bkgShowInfo">
                            <div id="showDate">
                                <span id="showDate1"></span>&nbsp;<span id="showDate2"></span>
                            </div>
                            <div id="seatNum">총 <span id="ticketLength"></span>석 선택</div>
                            <div id="seat"></div>
                        </div>

                        <div id="payment">
                            <div id="paymentTitle">결제 금액</div>
                            <div id="paymentStmt">
                                <table>
                                    <tr>
                                        <td class="stmtRow1 plusPrice">티켓금액</td>
                                        <td class="stmtRow2 plusPrice"><span style="display:none" id="ticketPrice"></span><span id="ticketPriceDisplay"></span></td>
                                    </tr>
                                    <tr>
                                        <td class="stmtRow1">가격할인</td>
                                        <td class="stmtRow2"><span style="display:none" id="dcPrice"></span><span id="dcPriceDisplay">0</span></td>
                                    </tr>
                                    <tr>
                                        <td class="stmtRow1">쿠폰할인</td>
                                        <td class="stmtRow2"><span style="display:none" id="dcCoupon"></span><span id="dcCouponDisplay">0</span></td>
                                    </tr>
                                    <tr>
                                        <td class="stmtRow1">적립금</td>
                                        <td class="stmtRow2"><span style="display:none" id="dcPoint"></span><span id="dcPointDisplay">0</span></td>
                                    </tr>
                                    <tr>
                                        <td class="stmtRow1 plusPrice">예매수수료</td>
                                        <td class="stmtRow2 plusPrice"><span style="display:none" id="ticketCommission">1000</span>1,000</td>
                                    </tr>
                                    <tr>
                                        <td class="stmtRow1 plusPrice">배송료</td>
                                        <td class="stmtRow2 plusPrice"><span style="display:none" id="deliveryFee"></span><span id="deliveryFeeDisplay">0</span></td>
                                    </tr>
                                </table>
                                <div id="totalPriceDiv">
                                    <div id="totalPriceRow1">총 결제금액</div>
                                    <div id="total"><span style="display:none" id="totalPrice"></span><span id="totalPriceDisplay"></span>&nbsp;<span>원</span></div>
                                </div>
                            </div>
                        </div>

                        <div id="refundDeadline">
                            <div id="refundDeadlineTitle">취소 기한 :&nbsp;</div><div id="deadline">2020년 8월 26일(수) 24:00</div>
                        </div>
                        <div id="sideBarBtn">
                            <button id="prevStep" onclick="change(step1)">이전 단계</button>
                            <button id="nextStep" onclick="change(step3)">다음 단계</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- <div class="inipay_modal" id="inipay_modal">
   		<iframe id="inipay_iframe" src="payPopUp.action" class="inipay_iframe" scrolling="yes"></iframe>
    </div> -->
    
    <form name="payFrm">
    	<input type="hidden" name="payShowName" value="${getShowRsvInfo.prod_id}"/>
    	<input type="hidden" name="paySum" value="" id="paySum" />
    	<input type="hidden" name="payNum" value="" id="payNum" />
    	<input type="hidden" name="seatIdes" value="" id="seatIdes" />
    	<input type="hidden" name="Email" value="" id="Email"/>
    	<input type="hidden" name="showDay" value="" id="showDay"/>
    	<input type="hidden" name="showRound" value="" id="showRound"/>
    	
    </form>
</body>
<jsp:include page="../../../../resources/js/seatSelScript.jsp"/>
</html>