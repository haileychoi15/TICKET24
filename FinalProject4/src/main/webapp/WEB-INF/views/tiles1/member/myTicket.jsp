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
    <link rel="stylesheet" type="text/css" href="resources/css/myTicket.css">
    <script src="https://kit.fontawesome.com/c3eca5a54c.js" crossorigin="anonymous"></script>
    
    <script type="text/javascript" src="<%= request.getContextPath()%>/resources/js/jquery-3.3.1.min.js"></script>
    
    <script type="text/javascript">
    
    
    
    	$(document).ready(function(){
    		
    	});	
    
    	function updateReview(review_id){
    		
    		//console.log("review_id : ", review_id);
    		window.open('/finalproject4/updateReview.action?review_id='+review_id, '리뷰수정', 'width=800, height=600');
    		
    	}
    	
    </script>
    
</head>
<body>
<div id="container">
    <div id="top">
        <div class="myInfo">
            <div class="imgDiv"><img src="resources/images/myInfo.png" alt="myInfoImg" width="80px"></div>
            <div id="idDiv">
                <div class="myInfo">
                    <div id="myID">${sessionScope.loginuser.userid }</div>
                    <div id="logout"><button type="button" onclick="location.href='<%=ctxPath%>/logout.action'">로그아웃</button></div>
                </div>
                <div class="aDiv"><a href="<%=ctxPath%>/modifyInfo.action" id="modifyInfo">&nbsp;정보 수정</a></div>
            </div>
        </div>
        <div id="myBooking">
            <img src="resources/images/stage.png" alt="stage" width="30px">
            <div class="title">예매</div>
            <div class="emDiv"><span class="em" id="booking">${reserveCount }</span>매</div>
        </div>
        <div id="myReview">
            <img src="resources/images/review.png" alt="review" width="30px">
            <div class="title">리뷰</div>
            <div class="emDiv"><span class="em" id="review">${reviewCount }</span>개</div>
        </div>
        <div id="myPreferredShow">
            <img src="resources/images/heart.png" alt="heart" width="30px">
            <div class="title">선호공연</div>
            <div class="emDiv"><span class="em" id="preferred">${likeCount }</span>개</div>
        </div>
    </div>

    <div id="bookingDiv">
        <div class="tableTitle bookingTitle">최근 예매/취소</div>

        <table>
            <thead>
            <tr>
                <th id="bookingDate">예매일</th>
                <th id="showInfo">공연정보</th>
                <th id="bookingInfo">예매정보</th>
                <th id="bookingStatus">상태</th>
            </tr>
            </thead>
            <tbody>
	            <c:forEach var="my" items="${myReserveList}" varStatus="status">
	            	<tr>
		                <td class="bookingDate">${my.rev_date}</td>
		                <td>
		                    <div class="showInfoBox">
		                        <div class="show_poster">
		                            <img src="resources/images/${my.prod_img }" alt="poster" width="90px" onclick="location.href='<%=ctxPath%>/detail.action?seq=${my.prod_id }'">
		                        </div>
		                        <div class="showInfoText">
		                            <div class="showTitle">${my.prod_title }</div>
		                            <div class="showDate">${my.date_start } - ${my.date_end }</div>
		                            <div class="showPlace">${my.map_name }</div>
		                        </div>
		                    </div>
		                </td>
		                <td>
		                	<c:if test="${my.status == '1' || my.status == '2' }">
			                    <dl>
			                        <dt>예매번호</dt>
			                        <dd class="bookingNo">${my.rev_id }</dd>
			                    </dl>
		                    </c:if>
		                    <c:if test="${my.status == '0' }">
		                       	<dl>
			                        <dt>예매번호</dt>
	                        		<dd class="bookingNo">[취소] <del>${my.rev_id }</del></dd>
			                    </dl>
		                    </c:if>
		                    <dl>
		                        <dt>관람일</dt>
		                        <dd>${my.date_showday }</dd>
		                    </dl>
		                    <dl>
		                        <dt>매수</dt>
		                        <dd>${my.rev_qnty }매</dd>
		                    </dl>
		                    <dl>
		                        <dt>취소가능일</dt>
		                        <dd>${my.cancel_day } 까지</dd>
		                    </dl>
		                </td>
		                <c:if test="${my.status == '1' }">
			                <td class="bookingStatus">
			                    <p>예매완료</p>
			                    <button class="bookingDetail">예매 상세</button>
			                </td>
		                </c:if>
		                <c:if test="${my.status == '0' }">
			                <td class="bookingStatus">
			                    <p>취소완료</p>
			                    <button class="bookingDetail">취소 상세</button>
			                </td>
		                </c:if>
		                <c:if test="${my.status == '2' }">
			                <td class="bookingStatus">
			                    <p>입금 대기</p>
			                    <button class="bookingDetail">예매 상세</button>
			                </td>
		                </c:if>
		            </tr>
	            </c:forEach>
            </tbody>
        </table>
    </div>

    <div id="reviewDiv">
        <div class="tableTitle">나의 리뷰</div>

        <div id="content">
        	<c:forEach varStatus="status" var="review" items="${myReviewList}">
	            <div class="reviewBox">
	                <img src="resources/images/${review.prod_img }" alt="poster" height="110px" onclick="location.href='<%=ctxPath%>/detail.action?seq=${review.prod_id }'">
	                <div class="review">
	                    <h3>${review.prod_title }</h3>
	                    <div class="date">${review.regDate }</div>
	                    <div class="reviewText">${review.content }</div>
	                    <div class="btnArea">
	                    	<input type="hidden" name="review_id" value="${review.review_id }"/>
	                        <button class="modify" onclick="updateReview('${review.review_id }');">수정</button>
	                        <button class="delete" onclick="location.href='<%=ctxPath%>/myReviewDelete.action?review_id=${review.review_id }'">삭제</button>
	                    </div>
	                </div>
	            </div>
        	</c:forEach>
        </div>
        
 
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

    <div id="preferredDiv">
        <div class="tableTitle">선호 공연</div>

        <div id="preferredArea">
        	<c:forEach var="like" items="${myLikeList }" varStatus="status">
        		<div class="preferredItem">
        			<img src="resources/images/${like.prod_img }" alt="poster" height="110px" onclick="location.href='<%=ctxPath%>/detail.action?seq=${like.prod_id }'">
   					<input type="hidden" name="prod_id" value="${like.prod_id }"/>
        		</div>
        	</c:forEach>
        </div>

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

</div>
</body>

</html>