<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공연명으로 티켓오픈일자 검색</title>

<style>

   table#tbl {
   	    width: 93%;
   	    border: hidden;
   	    margin: 10px;
   }  
   
   table#tbl #th {
   		height: 40px;
   		text-align: center;
   		background-color: silver;
   		font-size: 14pt;
   }
   
   table#tbl td {
   		line-height: 30px;
   		padding-top: 8px;
   		padding-bottom: 8px;
   }
   
   
   div .head {
		width: 90%;
		height: 20px;
		border: 1px solid gray;
		margin-top: 10px;
		margin-bottom: 30px;
		padding-top: 10px;
		padding-bottom: 50px;
		background-color: #ffffe6;
		font-size: 18pt;
	}
	
	
   
</style> 


<script type="text/javascript">

	$(document).ready(function(){
		
		$("tr.select").click(function() {
			
			var prod_id = $(this).children(".prod_id").text();
			var prod_title = $(this).children(".prod_title").text();
			var info_open_date = $(this).children(".info_open_date").text();
			
			$("#prod_id").val(prod_id);
			$("#prod_title").val(prod_title);
			$("#info_open_date").val(info_open_date);
			
		});
		
	});


	function goTicketOpenEnd() {
		
		opener.document.getElementById("ticketopenday").value = document.getElementById("info_open_date").value;
		opener.document.getElementById("prod_id").value = document.getElementById("prod_id").value;
		opener.document.getElementById("prod_title").value = document.getElementById("prod_title").value;
		window.close();
	}

</script>

</head>
<body>


<c:if test="${empty ticketList}">
	<div class="row" align="center">
		<div class="col-md-12">
		검색결과가 없습니다.
		</div>
	</div>
</c:if>


<c:if test="${not empty ticketList}">
	<div class="row" align="center">
		<div class="col-md-12">
		
			<form name="selectFrm">
			<div class="head" align="center">
				::: 공연의 티켓오픈일 :::
			</div>
			<table id="tbl">
			
				<tr>
					<th style="width: 10%; font-weight: bold;">공연번호</th>
					<th style="width: 60%; font-weight: bold;">공연명</th>
					<th style="width: 30%; font-weight: bold;">티켓오픈일자</th>
				</tr>
				<c:forEach var="ticketpvo" items="${ticketList}">
				<tr class="select">
					<td class="prod_id" style="width: 10%; text-align: center;">${ticketpvo.prod_id}</td>
					<td class="prod_title" style="width: 60%; text-align: left;">${ticketpvo.prod_title}</td>
					<td class="info_open_date" style="width: 30%; text-align: center;">${ticketpvo.info_open_date}</td>
				</tr>
				</c:forEach>
			
				<tr>
					<td colspan="3">
						<button type="button" id="btnSelect" style="margin-left: 40%; margin-top: 2%; width: 80px; height: 40px;" onClick="goTicketOpenEnd();"><span style="font-size: 15pt;">선택</span></button>
					
						<input type="hidden" id="prod_id" />
						<input type="hidden" id="prod_title" />
						<input type="hidden" id="info_open_date" />
					
					</td>
				</tr>
				
			</table>
			</form>
		</div>
	</div>
</c:if>


</body>
</html>