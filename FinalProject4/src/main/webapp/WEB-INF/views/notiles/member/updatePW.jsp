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
<title>비밀번호 변경</title>
<script type="text/javascript" src="<%= request.getContextPath()%>/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		$(".updateBtn").click(function(){
			
			var frm = document.updatePWFrm;
			frm.method = "POST";
			frm.action = "<%= ctxPath%>/updatePW.action";
			frm.submit();	
			
		});
		
	});

</script>

</head>
<body>

	<form name="updatePWFrm">
			<ul class="login">
				<li>
					<label for="pwd">새로운 비밀번호</label><br>
					<input type="password" name="pwd" id="pwd" maxlength="20" required autofocus autocomplete="off" placeholder="새 비밀번호" />
					  
				</li>
				<li>
					<label for="pwd2">새로운 비밀번호 확인</label><br>
					<input type="password" name="pwd2" id="pwd2"  maxlength="20" required placeholder="새 비밀번호 확인" />
				</li>
			</ul>
			<input type="hidden" name="userid" id="userid" value="${userid}" />
		</form>
			
		<button type="button" class="updateBtn">SUBMIT</button>
<%-- 			
			<c:if test="${method.equals('POST') && n==1 }">
				<div id="div_confirmResult" align="center">
					ID : ${userid}님의 암호가 새로이 변경되었습니다.<br/>
				</div>
			</c:if> --%>
				
			
				
			

</body>
</html>