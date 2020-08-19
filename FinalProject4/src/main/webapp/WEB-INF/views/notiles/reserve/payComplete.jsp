<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="resources/css/seatComplete.css">
    <div id="container">
        <div id="title">결제가 정상적으로 완료되었습니다.</div>
        <div id="caution">무통장입금 <em>2020년 8월 14일 23시 59분</em>까지 농협은행 230-910059-41205 입금 되어야 결제가 완료됩니다.<br>
        예매 상세 내역은 마이티켓 > 예매확인/취소에서 확인하실 수 있습니다.</div>
        <table>
            <tr>
                <td class="row1">예매번호</td>
                <td class="row2">${reserveInfoMap.revId}</td>
            </tr>
            <tr>
                <td class="row1">공연명</td>
                <td class="row2">${reserveInfoMap.payShowName}</td>
            </tr>
            <tr>
                <td class="row1">공연장</td>
                <td class="row2">${mapName}</td>
            </tr>
            <tr>
                <td class="row1">좌석</td>
                <td class="row2">
				<c:foreach var="seatvo" items="${seatArr}">
					${seatvo}<br/>
				</c:foreach>
                </td>
            </tr>
            <tr>
                <td class="row1">수령방법</td>
                <td class="row2">
                	<c:if test="${receiveMethod == 1}">
                		현장수령
                	</c:if>
                	<c:if test="${receiveMethod == 2}">
                		배송
                	</c:if>
				</td>
            </tr>
            <tr>
                <td class="row1">결제수단</td>
                <td class="row2">${payMethod}</td>
            </tr>
            <tr>
                <td class="row1">취소가능일시</td>
                <td class="row2">2020년 8월 28일 12시 00분까지</td>
            </tr>
        </table>

        <div id="btnArea">
            <a id="move" href="">예매내역확인</a>
            <a id="close" href="javascript: self.close();">닫기</a>
        </div>
    </div>
    
    
    
    
    
    
    
    
    
    
    
    
    
    
