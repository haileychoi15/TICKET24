<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String ctxPath = request.getContextPath(); %>

<script type="text/javascript">
	var loginuser = "${sessionScope.loginuser}";
	var gobackURL = "${requestScope.gobackURL}";
	
	if(loginuser != null && (gobackURL != null && gobackURL != "")) {
		alert("${sessionScope.loginuser.name}님 로그인 성공했습니다.");
		location.href="<%= ctxPath%>/"+gobackURL;
	}
	else if(loginuser != null && (gobackURL == null || gobackURL == "")) {
		alert("${sessionScope.loginuser.name}님 로그인 성공했습니다.");
		location.href="<%= ctxPath%>/yes24.action";
	}
</script>