<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String ctxPath = request.getContextPath();
%> 

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<script type="text/javascript" src="<%= request.getContextPath()%>/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	
	$(document).ready(function(){
		
		// 찾기
		$(".FindBtn").click(function(){
			
			var useridVal = $("#userid").val().trim();
			var emailVal = $("#email").val().trim();
			
			if(useridVal != "" && emailVal != "") {
				var frm = document.pwdFindFrm;
				frm.method = "POST";
				frm.action = "<%= ctxPath%>/findPW.action";
				frm.submit();
			}
			else {
				alert("아이디와 이메일을 입력하세요!!");
				return;
			}
		}); // end of $("").click(function(){})
		
		
		var method = "${method}";
		var userid = "${userid}";
		var email = "${email}";
		var n = "${n}";
		
		if(method=="POST" && n==1) {
			$("#userid").val(userid);
			$("#email").val(email);
			$(".FindBtn").hide();
		}
		else {
			$(".FindBtn").show();
		}
		
		
		// 인증하기
		$("#btnConfirmCode").click(function(){
			var frm = document.verifyCertificationFrm;
			frm.userid.value = $("#userid").val();
			frm.userCertificationCode.value = $("#input_confirmCode").val();
			
			frm.action = "<%= ctxPath%>/verifyCertification.action";
			frm.method = "POST";
			frm.submit();
		}); // end of $("#btnConfirmCode").click(function(){})
		
		
	});
	
</script>

</head>
<body>

	<form name="pwdFindFrm">
	
		<label for="userid">아이디</label><br>
		<input type="text" name="userid" id="userid" value="" maxlength="20" required autofocus autocomplete="off" placeholder="아이디" />
		<br>
		<label for="email">이메일</label><br>
		<input type="text" name="email" id="email" value="" maxlength="20" required placeholder="abc@gmail.com" />
			
			
		<div id="div_findResult" align="center">
			<c:if test="${n == 1}">
				<span style="font-size: 10pt;">인증코드가 ${email}로 발송되었습니다.</span><br/>  
				<span style="font-size: 10pt;">인증코드를 입력해주세요</span><br/>
				<input type="text" name="input_confirmCode" id="input_confirmCode" required />
				<br/><br/>
				<button type="button" class="btn-info" id="btnConfirmCode">인증하기</button>
			</c:if> 
			
			<c:if test="${n == 0}">
				<span style="color: red;">사용자 정보가 없습니다.</span> 
			</c:if> 
			
			<c:if test="${n == -1}">
				<span style="color: red;">메일발송이 실패했습니다.</span>  
			</c:if> 
	   </div>   

	   <button type="button" class="FindBtn">SUBMIT</button>
					
	</form>



	<form name="verifyCertificationFrm">
		<input type="hidden" name="userid" />
		<input type="hidden" name="userCertificationCode" />
	</form>


</body>
</html>