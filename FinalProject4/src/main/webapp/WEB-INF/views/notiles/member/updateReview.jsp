<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% String ctxPath = request.getContextPath(); %>    

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

	<link rel="stylesheet" type="text/css" href="resources/css/myTicket.css">
    <script src="https://kit.fontawesome.com/c3eca5a54c.js" crossorigin="anonymous"></script>
    <script src="resources/js/updateReview.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/resources/js/jquery-3.3.1.min.js"></script>
    
<title>리뷰수정</title>

<script type="text/javascript">
	
	$(document).ready(function(){
		
		$(".re-post-ok-button").click(function(){
			
			var frm = document.reviewEditFrm;
			frm.method = "POST";
			frm.action = "<%=ctxPath%>/updateReviewEnd.action";
			frm.submit();
			
			//alert($("#re-star").val());
			//self.close();
		});
		
		
		$(".close-revision-button").click(function(){
			self.close();
		});
		
	});

</script>

</head>
<body>


<section class="revision hide">
    <div class="revision-group">
        <form name="reviewEditFrm" class="revision-form">
	              <div class="revision-table">
	                  <div class="revision-title">
	                      <p class="re-title">리뷰 수정</p>
	                      <button type="button" class="close-revision-button" ><span>+</span></button>
	                  </div>
<!-- 	                  <div class="re-row re-datestar">
	                      <div class="re-table-title">관람일시</div>
	                      <div class="re-table-content">관람 내역이 없습니다.</div>
	                      
	                  </div> -->
                         <%-- <div class="row datestar">
                 <div class="table-title">작성자명</div>
                 <div class="table-content"><input type="text" name="name" value="${sessionScope.loginuser.name}" readonly /></div>
             </div> --%>
                <div class="re-row re-datestar">
                    <div class="re-table-title">별점</div>
                    <div class="re-table-content re-starlist">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <input type="hidden" name="re-star" id="re-star" value="" />
                    </div>
                </div>
                <div class="re-row">
                    <div class="re-table-title">관람후기</div>
                    <div class="re-table-content">
                        <textarea name="input-content" id="input-content" class="re-input-content" maxlength="2000" minlength="10" cols="30" rows="10" placeholder="내용을 작성해주세요.(최소 20byte/최대 2,000byte)"></textarea>
                    </div>
                </div>
            </div>
            <input type="hidden" name="review_id" id="review_id" value="${review_id }" />
        </form>
        <div class="re-post-buttons">
           <button type="button" class="re-post-ok-button" >수정</button>
        </div>
    </div>
</section>  


</body>
</html>