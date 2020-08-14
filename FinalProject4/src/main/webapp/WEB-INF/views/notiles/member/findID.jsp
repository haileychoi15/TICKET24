<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String ctxPath = request.getContextPath();
%>        
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<script type="text/javascript" src="<%= request.getContextPath()%>/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		
		$("#FindBtn").click(function(){
			
			var frm = document.findIDFrm;
			frm.action = "<%= ctxPath%>/findID.action";
			frm.method = "POST";
			frm.submit();
		});
	});
	
</script>

</head>
<body>
	<form name="findIDFrm">
		<label for="name">성명</label><br>
		<input type="text" name="name" id="name" value="" maxlength="20" required autofocus autocomplete="off" placeholder="성명" />
		<br>
		<label for="mobile">휴대전화</label><br>
		<input type="text" name="mobile" id="mobile" value="" maxlength="20" required placeholder="- 없이 입력하세요" />
		<br>
		<button type="button" id="FindBtn">아이디 찾기</button>						  
	</form>
	
</body>
</html>