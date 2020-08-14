<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
	String ctxPath = request.getContextPath();
	//		/finalproject4
%>


<style type="text/css">

	table, th, td, input, textarea {border: solid gray 1px;}
	
	#table, #table2 {border-collapse: collapse;
	 		         width: 900px;
	 		        }
	#table th, #table td{padding: 5px;}
	#table th{width: 120px; background-color: #DDDDDD;}
	#table td{width: 750px;}
	
	.long {width: 470px;}
	.short {width: 120px;}
	
	.move {cursor: pointer;}
	.moveColor {color: #660029; font-weight: bold;}
	
	a {text-decoration: none !important;}
	
	#star_grade a{
        text-decoration: none;
        color: gray;
    }
    
    #star_grade a.on{
        color: red;
    }
    
    <%-- 
    .star-rating { width:205px; }
	.star-rating,.star-rating span { display:inline-block; height:39px; overflow:hidden; background:url(<%= ctxPath%>/resources/images/star.png)no-repeat; color: blue;}
	.star-rating span{ background-position:left bottom; line-height:0; vertical-align:top; }
     --%>
    .star-rating { width:103px; }
	.star-rating,.star-rating span { display:inline-block; height:19px; overflow:hidden; background:url(<%= ctxPath%>/resources/images/star_resize.png)no-repeat; color: blue;}
	.star-rating span{ background-position:left bottom; line-height:0; vertical-align:top; }
	
</style>

<div style="padding-left: 10%;">
	<h1>글내용보기</h1>
	
	<table id="table" style="word-wrap: break-word; table-layout: fixed; margin-top: 100px;">
		<tr>
			<th>글번호</th>
			<td>${qnavo.qna_id}</td>
		</tr>
		<tr>
			<th>아이디</th>
			<td>${qnavo.fk_userid}</td>
		</tr>
		<tr>
			<th>이름</th>
			<td>${qnavo.name}</td>
		</tr>
		<tr>
			<th>제목</th>
			<td>${qnavo.subject}</td>
		</tr>
		<tr>
			<th>구분</th>
			<td>${qnavo.qna_cate_name}</td>
		</tr>
		<tr>
			<th>문의일자</th>
			<td>${qnavo.regDate}</td>
		</tr>
		
		<tr>
			<th>내용</th>
			<td>
			 <p style="word-break: break-all;">${qnavo.content}</p>
			 <%-- 
			      style="word-break: break-all; 은 공백없는 긴영문일 경우 width 크기를 뚫고 나오는 것을 막는 것임. 
			           그런데 style="word-break: break-all; 나 style="word-wrap: break-word; 은
			           테이블태그의 <td>태그에는 안되고 <p> 나 <div> 태그안에서 적용되어지므로 <td>태그에서 적용하려면
			      <table>태그속에 style="word-wrap: break-word; table-layout: fixed;" 을 주면 된다.
			 --%>
			</td>
		</tr>
		<tr>
			<th>읽음여부</th>
			<td>${qnavo.adminread}</td>
		</tr>
		<tr>
			<th>답변여부</th>
			<td>${qnavo.adminans}</td>
		</tr>
	</table>
	
	<br/>
	
	<div style="margin-bottom: 1%;">이전글&nbsp;:&nbsp;<span class="move" onclick="javascript:location.href='?seq=${notivo.previousseq}'">${notivo.previoussubject}</span></div>
	<div style="margin-bottom: 1%;">다음글&nbsp;:&nbsp;<span class="move" onclick="javascript:location.href='?seq=${notivo.nextseq}'">${notivo.nextsubject}</span></div>
	<%-- 
	이전글보기 : <a href="?seq=${notivo.previousseq}">${notivo.previoussubject}</a>
	다음글보기 : <a href="?seq=${notivo.nextseq}">${notivo.nextsubject}</a>
	--%>
	<br/>
	
	<%-- 
	<button type="button" onclick="javascript:location.href='<%= request.getContextPath()%>/list.action'">전체목록보기</button>
	<c:if test="${sessionScope.gobackURL != null && sessionScope.gobackURL != ''}">
		<button type="button" onclick="javascript:location.href='<%= request.getContextPath()%>/${sessionScope.gobackURL}'">목록보기</button>
	</c:if> --%>
	
	<!-- === #124.  페이징 처리되어진 후 특정글제목을 클릭하여 상세내용을 본 이후
		 			사용자가 목록보기 버튼을 클릭했을때 돌아갈 페이지를 알려주기 위해
		 			현재 페이지 주소를 뷰단으로 넘겨준다. -->
	<button type="button" onclick="javascript:location.href='<%= request.getContextPath()%>/qnaListMain.action'">전체목록보기</button>
	<button type="button" onclick="javascript:location.href='<%= request.getContextPath()%>/qnaListMain.action?page=5'">목록보기</button>
	<%-- 	
	<c:if test="${gobackURL != null}">
		<button type="button" onclick="javascript:location.href=''">목록보기</button>
	</c:if>
	<c:if test="${gobackURL == null}">
		<button type="button" onclick="javascript:location.href='<%= request.getContextPath()%>/noticeMain.action'">목록보기</button>
	</c:if> --%>
	
	<button type="button" onclick="javascript:location.href='<%= request.getContextPath()%>/qnaAddAdmin.action?fk_seq=${qnavo.qna_id}&groupno=${qnavo.groupno}&depthno=${qnavo.depthno}&category=${qnavo.category}'">답변글쓰기</button>
	<button type="button" onclick="javascript:location.href='<%= request.getContextPath()%>/qnaEdit.action?seq=${qnavo.qna_id}'">수정</button>
	<button type="button" onclick="javascript:location.href='<%= request.getContextPath()%>/qnaDel.action?seq=${qnavo.qna_id}'">삭제</button>
		
</div>

	



