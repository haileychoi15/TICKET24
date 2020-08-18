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
    <link rel="stylesheet" type="text/css" href="resources/css/myPage.css">
    <script src="https://kit.fontawesome.com/c3eca5a54c.js" crossorigin="anonymous"></script>
    
    <script type="text/javascript" src="<%= request.getContextPath()%>/resources/js/jquery-3.3.1.min.js"></script>
    
    <script type="text/javascript">
    
    	$(document).ready(function(){
    		
    	});	
    
    	
    	
    </script>
    
</head>
<body>
    <div id="container">
        <div id="top">
            <div class="myInfo">
                <div class="imgDiv"><i class="fas fa-user-cog" style="font-size: 40pt;"></i></div>
                <div id="idDiv">
                    <div class="myInfo">
                        <div id="myID">${sessionScope.loginuser.userid} </div>
                        <div id="logout"><button type="button" onclick="location.href='<%=ctxPath%>/logout.action'">로그아웃</button></div>
                    </div>
                    <div class="aDiv"><a href="<%=ctxPath%>/modifyInfo.action" id="modifyInfo">&nbsp;정보 수정</a></div>
                </div>
            </div>
            <div id="myPoint">
                <img src="resources/images/point.png" alt="pointImg" width="30px">
                <div class="title">포인트</div>
                <div class="emDiv"><span class="em" id="point"><fmt:formatNumber value="${sessionScope.loginuser.point}" pattern="###,###" /></span>원</div>
            </div>
            <div id="myCoupon">
                <img src="resources/images/coupon.png" alt="couponImg" width="30px">
                <div class="title">쿠폰</div>
                <div class="emDiv"><span class="em" id="coupon">${couponCount}</span>개</div>
            </div>
            <div id="myQNA">
                <img src="resources/images/question.png" alt="qnaImg" width="30px">
                <div class="title">나의 문의</div>
                <div class="emDiv"><span class="em" id="qna">${qnaCount}</span>개</div>
            </div>
        </div>

        <div id="pointDiv">

            <div class="tableTitle">회원관리</div>

           <table>
                <thead>
                <tr>
                    <th width="20%">적립일</th>
                    <th width="55%">내용</th>
                    <th width="10%">예매번호</th>
                    <th width="15%">적립포인트</th>
                </tr>
                </thead>
                <tbody>
 					<c:forEach var="point" items="${pointList}" varStatus="status">
						<tr>
							<td>${point.fk_rev_date} </td>
							<td class="left">${point.content}</td>
							<td>${point.fk_rev_id }</td>
							<td class="point"><fmt:formatNumber value="${point.point }" pattern="###,###" />원</td>
						</tr>
					</c:forEach>
                </tbody>
            </table>

            <div class="pageBar">
                <a href="" class="pageBtn prevFist"></a>
                <a href="" class="pageBtn prev"></a>
                <em class="pageLink">1</em>
                <a href="" class="pageLink">2</a>
                <a href="" class="pageLink">3</a>
                <a href="" class="pageBtn next"></a>
                <a href="" class="pageBtn nextLast"></a>
            </div>
        </div>

        <div id="couponDiv">
            <div class="tableTitle">예매관리</div>

            <table>
                <thead>
                <tr>
                    <th width="40%">쿠폰명</th>
                    <th width="15%">혜택</th>
                    <th width="25%">사용조건</th>
                    <th width="20%">사용기한</th>
                </tr>
                </thead>
                <tbody>
	                
	                <c:forEach var="coupon" items="${couponList}" varStatus="status">
						<tr>
		                    <td class="left name">${coupon.coupon_name }</td>
		                    <td class="point"><fmt:formatNumber value="${coupon.coupon_dc }" pattern="###,###" />원 할인</td>
		                    <td>${coupon.coupon_condition }</td>
		                    <td>${coupon.coupon_olddate} 까지</td>
		                </tr>
					</c:forEach>
                </tbody>
            </table>

            <div class="pageBar">
                <a href="" class="pageBtn prevFist"></a>
                <a href="" class="pageBtn prev"></a>
                <em class="pageLink">1</em>
                <a href="" class="pageLink">2</a>
                <a href="" class="pageLink">3</a>
                <a href="" class="pageBtn next"></a>
                <a href="" class="pageBtn nextLast"></a>
            </div>
        </div>

        <div id="qnaDiv">
            <div class="tableTitle">배송관리</div>

            <table>
                <thead>
                <tr>
                    <th width="20%">카테고리</th>
                    <th width="50%">제목</th>
                    <th width="10%">등록일</th>
                    <th width="20%">상태</th>
                </tr>
                </thead>
                <tbody>
	                <c:forEach var="qna" items="${qnaList}" varStatus="status">
						<tr>
							<td>${qna.qna_cate_name} </td>
							<td class="left"><span onclick="modal('${status.index}')">${qna.subject}</span></td>
							<td>${qna.regDate }</td>
							<c:if test="${qna.adminans == '0' }">
								<td class="point">답변대기</td>
							</c:if>
							<c:if test="${qna.adminans == '1' }">
								<td class="point" style="color:#568ade;">답변완료</td>
							</c:if>
						</tr>
					 </c:forEach>
                </tbody>
            </table>

            <div class="pageBar">
                <a href="" class="pageBtn prevFist"></a>
                <a href="" class="pageBtn prev"></a>
                <em class="pageLink">1</em>
                <a href="" class="pageLink">2</a>
                <a href="" class="pageLink">3</a>
                <a href="" class="pageBtn next"></a>
                <a href="" class="pageBtn nextLast"></a>
            </div>


			<c:forEach var="qna2" items="${qnaList2}" varStatus="status" >
	            <div class="modalBack" style="display: none">
	                <div class="modal">
	                    <div class="modalTitle">
	                        <div class="questionTitle">${qna2.user_subject}</div>
	                        <div class="closeBtn" onclick="closeModal('${status.index}')"></div>
	                        <div class="modalDate">${qna2.user_regDate }</div>
	                    </div>
	                    <div class="questionContent">${qna2.user_content }</div>
	                
	                 	<c:if test="${qna2.admin_content != null}">   
		                    <div class="modalTitle answerDiv">
		                        <div class="answerTitle"><img src="resources/images/TICKET24.png" alt="TICKET24" width="20px">&nbsp;TICKET24 고객센터</div>
		                        <div class="modalDate">${qna2.admin_regDate }</div>
		                    </div>
		                    <br>
		                    <div id="answerContent">${qna2.admin_content }</div>
						</c:if>
						
						<c:if test="${qna2.admin_content == null}">   
		                    <div class="modalTitle answerDiv">
		                        <div class="answerTitle"><img src="resources/images/TICKET24.png" alt="TICKET24" width="20px">&nbsp;TICKET24 고객센터</div>
		                        <%-- <div class="modalDate">${qna2.admin_regDate }</div> --%>
		                    </div>
		                    <br>
		                    <div id="answerContent">답변 대기중입니다.</div>
						</c:if>		                
	                </div>
	            </div>
			</c:forEach>

			<div id="prodDiv">

            <div class="tableTitle">공연관리</div>

            <table>
                <thead>
                <tr>
                    <th width="20%">적립일</th>
                    <th width="55%">내용</th>
                    <th width="10%">예매번호</th>
                    <th width="15%">적립포인트</th>
                </tr>
                </thead>
                <tbody>
 					<c:forEach var="point" items="${pointList}" varStatus="status">
						<tr>
							<td>${point.fk_rev_date} </td>
							<td class="left">${point.content}</td>
							<td>${point.fk_rev_id }</td>
							<td class="point"><fmt:formatNumber value="${point.point }" pattern="###,###" />원</td>
						</tr>
					</c:forEach>
                </tbody>
            </table>

            <div class="pageBar">
                <a href="" class="pageBtn prevFist"></a>
                <a href="" class="pageBtn prev"></a>
                <em class="pageLink">1</em>
                <a href="" class="pageLink">2</a>
                <a href="" class="pageLink">3</a>
                <a href="" class="pageBtn next"></a>
                <a href="" class="pageBtn nextLast"></a>
            </div>
         </div>
         
          <div class="tableTitle">문의관리</div>

            <table>
                <thead>
                <tr>
                    <th width="20%">적립일</th>
                    <th width="55%">내용</th>
                    <th width="10%">예매번호</th>
                    <th width="15%">적립포인트</th>
                </tr>
                </thead>
                <tbody>
 					<c:forEach var="point" items="${pointList}" varStatus="status">
						<tr>
							<td>${point.fk_rev_date} </td>
							<td class="left">${point.content}</td>
							<td>${point.fk_rev_id }</td>
							<td class="point"><fmt:formatNumber value="${point.point }" pattern="###,###" />원</td>
						</tr>
					</c:forEach>
                </tbody>
            </table>

            <div class="pageBar">
                <a href="" class="pageBtn prevFist"></a>
                <a href="" class="pageBtn prev"></a>
                <em class="pageLink">1</em>
                <a href="" class="pageLink">2</a>
                <a href="" class="pageLink">3</a>
                <a href="" class="pageBtn next"></a>
                <a href="" class="pageBtn nextLast"></a>
            </div>
         </div>


            <!-- <div class="modalBack" style="display: none">
                <div class="modal">
                    <div class="modalTitle">
                        <div class="questionTitle">캣츠 예매 관련하여 문의합니다.</div>
                        <div class="closeBtn" onclick="closeModal()"></div>
                        <div class="modalDate">2020.08.15</div>
                    </div>
                    <div class="questionContent">공연 관람 당일 취소가 가능한가요?</div>
                    <div class="modalTitle answerDiv">
                        <div class="answerTitle"><img src="resources/images/TICKET24.png" alt="TICKET24" width="20px">&nbsp;TICKET24 고객센터</div>
                        <div class="modalDate">2020.08.16</div>
                    </div>
                    <div id="answerContent">기본적으로 공연 관람 당일 취소는 불가합니다.<br>
                        (관람일 당일 취소가 가능한 일부 공연의 경우 티켓 금액의 90%가 취소수수료로 부과됩니다.)<br>
                        공연의 특성에 따라 취소마감시간/취소수수료 정책이 달라질 수 있으니 예매 시 반드시 각 공연 상세페이지를 확인해주시기 바랍니다.</div>
                </div>
            </div> --> 
            
            
        </div>
    </div>
</body>

<script>
    function modal(index) {
        let modal = document.getElementsByClassName('modalBack')[index];
        modal.style.display = 'block';
    }

    function closeModal(index) {
        let modal = document.getElementsByClassName('modalBack')[index];
        modal.style.display = 'none';
    }

    window.onclick = function(event) {
        let modal = document.getElementsByClassName('modalBack');
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
</script>

</html>