<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>YES24 공연 예매</title>
    <link rel="stylesheet" type="text/css" href="resources/css/desktop2.css">
</head>
<body>
    <div id="container" style="width:1000px;">
        <div id="step1" style="display: block"> <!--좌석 선택-->
            <div id="step1Grid">
                <div id="top">
                    <div id="changeArea">
                        <span>관람일 변경</span>
                        <select id="changeDate">
                            <option selected>날짜 선택</option>
                        </select>
                        <span>회차 변경</span>
                        <select id="changeRound">
                            <option selected>회차 선택</option>
                        </select>
                    </div>
                </div>
                <div id="seatArea"></div>
                <div id="seatInfo">
                    <h3 id="showName"></h3>
                    <p>▾공연 정보</p>
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
                    <p>▾좌석 등급/가격</p>
                    <div id="seatPrice">
                        <div class="seatPriceItem">
                            <div class="gradeCol" style="background-color: indianred"></div>
                            <p>&nbsp;VIP석 120,000원</p><br>
                        </div>
                        <div class="seatPriceItem">
                            <div class="gradeCol" style="background-color: darkslateblue"></div>
                            <p>&nbsp;R석 100,000원</p><br>
                        </div>
                        <div class="seatPriceItem">
                            <div class="gradeCol" style="background-color: mediumpurple"></div>
                            <p>&nbsp;S석 80,000원</p>
                        </div>
                    </div>
                    <p>▾선택한 좌석</p>
                    <div id="selectedSeat"></div>
                    <button id="reset" onclick="reset()"><img src="<%= request.getContextPath() %>/resources/images/resetIcon.png" width="10px">  좌석 다시 선택</button>
                    <button id="next" onclick="seatSelComplete()">좌석 선택 완료</button>
                </div>
            </div>
        </div>

        <div id="step2" style="display: none"> <!--할인/쿠폰-->
            <div class="receiptArea" id="saleArea">
                <div id="discount">
                    <div class="part">
                        <h3>할인 선택</h3>
                        <div id="discountTbl">
                            <table>
                                <thead align="center">
                                    <tr>
                                        <td class="row1">할인명</td>
                                        <td class="row2">할인 금액</td>
                                        <td class="row3">매수</td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td class="row1">국가유공자할인 (본인만)</td>
                                        <td class="row2">28,000원</td>
                                        <td class="row3">
                                            <select style="font-size: 12px">
                                                <option value="0">0매</option>
                                                <option value="1">1매</option>
                                            </select>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div id="coupon">
                    <div class="part">
                        <h3>쿠폰 선택</h3>
                        <div id="couponTbl">
                            <table>
                                <thead align="center">
                                <tr>
                                    <td class="row1">할인명</td>
                                    <td class="row2">할인 금액</td>
                                    <td class="row3">사용</td>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td class="row1">[YES마니아] 예매수수료 면제쿠폰 (예매수수료 면제)</td>
                                    <td class="row2">0원</td>
                                    <td class="row3">
                                        <input type="checkbox">
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                        <p><em>주의사항)</em> 할인은 자동선택 되지 않으니, <em>적용 받고자 하는 할인이 있는 경우 직접 선택</em>해주시기 바랍니다.</p>
                    </div>
                </div>
            </div>
        </div>

        <div id="step3" style="display: none"> <!--수령 방법-->
            <div class="receiptArea" id="deliveryArea">
                <div class="part">
                    <h3>수령방법</h3>
                </div>
                <div class="selectInfo">
                    <table>
                        <tr>
                            <th class="deliveryCol1">수령방법선택</th>
                            <td class="radioHeight" id="receiveMethod">
                                &nbsp;<input type="radio" id="willCall" name="receive" value="0" onclick="deliverySel()" checked><label for="willCall">현장수령</label>
                                &nbsp;<input type="radio" id="delivery" name="receive" value="1" onclick="deliverySel()"><label for="delivery">배송(2,500원)</label>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdBlank" colspan="2"></td>
                        </tr>
                        <tr>
                            <th class="deliveryCol1 underLine" colspan="2">주문자확인</th>
                        </tr>
                        <tr>
                            <td class="deliveryRow1 deliveryCol2 tdInterval">이름</td>
                            <td class="deliveryRow2"><input type="text" size="15"></td>
                        <tr>
                            <td class="deliveryCol2 tdInterval">긴급연락처</td>
                            <td><input type="text" size="3" maxlength="3"> - <input type="text" size="4" maxlength="4"> - <input type="text" size="4" maxlength="4"></td>
                        </tr>
                        <tr>
                            <td class="deliveryCol2 tdInterval">이메일</td>
                            <td><input type="text" size="10"> @ <input type="text" size="13"></td>
                        </tr>
                        <tr>
                            <td class="tdBlank" colspan="2"></td>
                        </tr>
                    </table>
                    <div id="deliveryInfo" style="display: none">
                        <table>
                            <tr>
                                <th class="deliveryCol1 underLine" colspan="2">배송지정보</th>
                            </tr>
                            <tr>
                                <td class="deliveryRow1 deliveryCol2 tdInterval">받으시는 분</td>
                                <td class="deliveryRow2">
                                    <input type="text" size="10">
                                    <input type="radio" id="same" name="address"><label for="same">주문자정보와동일</label>
                                    <input type="radio" id="latest" name="address"><label for="latest">최근배송지</label>
                                    <input type="radio" id="new" name="address"><label for="new">새로입력</label>
                                </td>
                            </tr>
                            <tr>
                                <td class="deliveryCol2 tdInterval">연락처</td>
                                <td><input type="text" size="3" maxlength="3"> - <input type="text" size="4" maxlength="4"> - <input type="text" size="4" maxlength="4"></td>
                            </tr>
                            <tr>
                                <td class="deliveryCol2 tdInterval">주소</td>
                                <td>
                                    <input type="text" size="5">&nbsp;
                                    <input type="text" size="25">&nbsp;
                                    <button class="btn">우편번호검색</button>
                                </td>
                            </tr>
                            <tr>
                                <td class="deliveryCol2 tdInterval">상세주소</td>
                                <td><input type="text" size="35"></td>
                            </tr>
                        </table>
                    </div>
                    <div id="caution">
                        <strong>주의사항</strong> * 부정확한 정보 입력으로 인한 문제 발생 시 예스24는 책임을 지지 않습니다. <br><br>
                        1) <em>배송 선택 시 티켓 수령자의 배송지 정보를 정확히 입력해주시기 바랍니다.</em><br>
                        2) <em>티켓은 유가증권으로 본인에게 직접 전달해야하며, 분실된 티켓은 재발권 되지 않습니다.</em><br>
                        3) <em>일괄배송의 경우 정해진 날짜에 티켓 배송이 시작되며, 주소 수정은 일괄배송일 2일 전까지 <br>&nbsp;&nbsp;&nbsp;가능합니다.</em><br>
                        4) <em>예매 티켓 배송은 예매완료일, 혹은 일괄배송일로부터 4~5일(영업일 기준) 이내 수령 가능합니다.</em><br>
                        5) 긴급연락처는 공연 취소와 같은 유사 시 안내 받으실 연락처이므로 정확히 입력해주시기 바랍니다. <br>
                        6) 이메일 정보 미 입력 시 예매 관련 안내 메일을 받을 수 없으니 이메일 받기를 원하시는 경우 <br>&nbsp;&nbsp;&nbsp;마이페이지에서 회원정보를 수정해주시기 바랍니다.
                    </div>
                </div>
            </div>
        </div>

        <div id="step4" style="display: none"> <!--결제 방법-->
            <div class="receiptArea" id="paymentArea">
                <div class="part">
                    <h3>결제방법</h3>
                </div>
                <div class="selectInfo">
                    <div class="paymentCol1 paymentRow1">적립금</div>
                    <div class="paymentCol2 paymentRow1">
                            <input type="text" size="10" value="0"> 원&nbsp;
                            <input type="checkbox" id="allSel">
                            <label for="allSel">전액사용 (총 <span id="point"></span>원)</label>
                    </div>
                    <div class="paymentCol1 paymentRow2" style="color: #ec7d2c">결제방법선택</div>
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

                    <div id="refundTime"><strong>취소 가능 마감 시간 : </strong><em><span id="timeLimit"></span></em></div>

                    <table id="refundFee">
                        <tr>
                            <th class="refundCol1 refundRow1">내용</th>
                            <th class="refundCol1 refundRow2">취소 수수료</th>
                            <th class="refundCol1">비고</th>
                        </tr>
                        <tr>
                            <td class="refundRow1">예매 후 7일 이내</td>
                            <td class="refundRow2">없음</td>
                            <td class="refundRow3" rowspan="5">
                                - 취소 시 예매수수료는 예매 당일 밤 12시 이전까지만 환불됩니다. <br>
                                - 예매 후 7일 이내라도 취소시점이 관람일로부터 10일 이내라면 그에 해당하는 취소수수료가 부과됩니다. <br>
                                - 관람 당일 취소 가능 상품의 경우 관람 당일 취소 시 티켓금액의 90%가 취소수수수료로 부과됩니다. <br>
                            </td>
                        </tr>
                        <tr>
                            <td class="refundRow1">예매 후 8일 ~ 관람일 10일 전까지</td>
                            <td class="refundRow2">뮤지컬, 콘서트, 클래식 등 :<br>장당 4,000원<br>
                                연극, 전시 등 :<br>장당 2,000원<br>
                                (단, 티켓 금액의 10% 이내)</td>
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

                    <div id="agree">
                        <input type="checkbox" id="refundConfirm" name="confirm"><label for="refundConfirm">취소수수료 및 취소기한을 확인하였으며, 동의합니다.</label>&nbsp;
                        <input type="checkbox" id="infoConfirm" name="confirm"><label for="infoConfirm">제3자 정보제공 내용에 동의합니다.</label>
                    </div>
                </div>
            </div>
        </div>

        <div id="bookingInfo" style="display: none">
            <div id="bkgShowInfo">
                <table>
                    <tr>
                        <td rowspan="2">
                            <img src='http://tkfile.yes24.com/upload2/PerfBlog/202006/20200625/20200625-37085_1.jpg' width='75px' height='105px'>
                        </td>
                        <td><h4>${showvo.prod_title}</h4></td>
                    </tr>
                    <tr>
                        <td>2020.08.20 ~ 2020.09.10<br>블루스퀘어 인터파크홀</td>
                    </tr>
                </table>
            </div>
            <div id="selectStmt">
                <div class="stmt">선택 내역</div>
                <table id="selectStmtTbl">
                    <tr>
                        <td class="stmtRow1">날짜</td>
                        <td class="stmtRow2">2020.08.20(목)</td>
                    </tr>
                    <tr>
                        <td class="stmtRow1">시간</td>
                        <td class="stmtRow2">[1회] 20시 00분</td>
                    </tr>
                    <tr>
                        <td class="stmtRow1">매수</td>
                        <td class="stmtRow2" id="ticketLength"></td>
                    </tr>
                    <tr>
                        <td class="stmtCol4 stmtRow1">
                            <div class="seatNum">좌석</div>
                        </td>
                        <td class="stmtCol4 stmtRow2">
                            <div class="seatNum" id="seat"></div>
                        </td>
                    </tr>
                </table>
            </div>
            <div id="paymentStmt">
                <div class="stmt">결제 내역</div>
                <table id="paymentStmtTbl">
                        <td class="stmtRow1">티켓금액</td>
                        <td class="stmtRow2" id="ticketPrice">140000</td>
                    </tr>
                    <tr>
                        <td class="stmtRow1">예매수수료</td>
                        <td class="stmtRow2" id="ticketCommission">1000</td>
                    </tr>
                    <tr>
                        <td class="stmtRow1">배송료</td>
                        <td class="stmtRow2" id="deliveryFee">0</td>
                    </tr>
                    <tr>
                        <td class="stmtRow1"><strong>총 금액(+)</strong></td>
                        <td class="stmtRow2" id="totalTicketPrice"></td>
                    </tr>
                    <tr>
                        <td class="stmtRow1">할인금액</td>
                        <td class="stmtRow2" id="dcPrice">28000</td>
                    </tr>
                    <tr>
                        <td class="stmtRow1">할인쿠폰</td>
                        <td class="stmtRow2" id="dcCoupon">0</td>
                    </tr>
                    <tr>
                        <td class="stmtRow1">적립금</td>
                        <td class="stmtRow2" id="dcPoint">0</td>
                    </tr>
                    <tr>
                        <td class="stmtRow1"><strong>총 할인금액(-)</strong></td>
                        <td class="stmtRow2" id="totalDiscount"></td>
                    </tr>
                </table>
            </div>
            <div id="totalPriceDiv">
                <div id="totalPriceRow1">최종 결제금액</div>
                <div id="total"><span id="totalPrice"></span>&nbsp;<span>원</span></div>
            </div>
            <button id="prevStep" onclick="change(step3)">이전 단계</button>
            <button id="nextStep" onclick="payment()">다음 단계</button>
        </div>
    </div>
    <!-- <script src="resources/js/seatSelScript2.js"></script> -->
    <jsp:include page="../../../../resources/js/seatSelScript.jsp"/>
</body>
</html>