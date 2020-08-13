<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- === #24. tiles 를 사용하는 레이아웃1 페이지 만들기 === --%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>

<%
	String ctxPath = request.getContextPath();
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>YES24 티켓</title>
<link rel="shortcut icon" href="http://tkfile.yes24.com/img/favicon.ico?ver=150825a" type="image/x-icon">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="resources/css/grid.min.css">
<link rel="stylesheet" href="resources/css/main.css">
<link rel="stylesheet" href="resources/css/footer.css">
  
</head>
<body>
<tiles:insertAttribute name="header" />

<tiles:insertAttribute name="content" />

<tiles:insertAttribute name="footer" />
</body>
</html>