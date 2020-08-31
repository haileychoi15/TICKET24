<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% 
	String ctxPath = request.getContextPath();
%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="resources/css/grid.min.css">
    <link rel="stylesheet" href="resources/css/reset.css">
    <script src="https://kit.fontawesome.com/5342aa1b58.js" crossorigin="anonymous"></script>

<style type="text/css">

	/* body{margin-top: 116px;}

	table, th, td, textarea {border: solid gray 1px;}
	 
	#table {border-collapse: collapse;
	 		width: 900px;
	 		}
	#table th, #table td{padding: 5px;}
	#table th{width: 120px; background-color: #DDDDDD;}
	#table td{width: 860px;}
	.long {width: 470px;}
	.short {width: 120px;} */
	
		 	body{margin-top: 116px;}
	
	.noti-tit-tag01 {
		border: 1px solid #568ade;
		color: #568ade; 
		font-size: 10pt;
		padding: 5px 10px;
		margin: 0 15px 35px 0;
		text-align: right;
	}
	
	.noti-content {
		margin: 0px auto;
		padding: 0;
		width: 60%;
		word-wrap: break-word; 
	}
	
	.noti-vt-open {
		line-height: 1;
		margin: 30px 0 0 0;
		padding: 20px 0 0 0;
		font-style: normal;
		vertical-align: baseline;
		outline: none;
		background: #fbe5d5;
		border: 1px solid #999;
		margin-top: -1px;
		height: 230px;
		font-size: 17px;
		font-weight: 700;
		vertical-align: middle;
	}
	
	.noti-vt-open > span:nth-child(1) em {
		inline-block;
	    height: 22px;
	    line-height: 22px;
	    padding-left: 32px;
	    color: #ec7d2c;
		background: url('http://tkfile.yes24.com/imgNew/sub/ico-rp-tko1.png') no-repeat;
		background-size: auto 100%;
	}
	
	.noti-vt-open > span {
		margin: 0px 44px;
		padding: 14px 0 0 0;
		vertical-align: middle;
	}
	
	.noti-view-date, .noti-view-date > span { 
		text-align: right;
		height: 30px;
		line-height: 30px;
		margin-bottom: 30px;
	}

	.noti-content img {
		text-align: center;
	}

	/* table, th, td, */ textarea {border: solid gray 1px;}
	
	#table, #table2 {border-collapse: collapse;
	 		         /* width: 900px; */
	 		        }
	#table th, #table td{padding: 5px;}
	#table th{width: 120px;}
	#table td{width: 900px;}
	
	.long {width: 470px;}
	.short {width: 120px;}
	
	.move {cursor: pointer;}
	.moveColor {color: #660029; font-weight: bold;}
	
	a {text-decoration: none !important;}
    
	.blue {
		color:#568ade;
	}
	
	.orange {
		color:#ec7d2c;
	}
	
	.list-button-group{
    display: flex;
    justify-content: center;
    margin-bottom: 50px;
	}
	
	.list-button-group a{
	    display: flex;
	    justify-content: center;
	    align-items: center;
	    width: 100px;
	    height: 40px;
	    border: 1px solid rgb(216, 222, 226);
	    border-radius: 20px;
	    margin: 10px;
	    background-color: rgb(240, 240, 240);
	} 
	
	.list-button-group a:hover{
	    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.08);
	}  
	
	.noticebtn button[type="button"] {
		/* padding: 10px;
		border-radius: 50%;
		color:red; */
		    width: 100px;
		    height: 40px;
		    border: 1px solid rgb(216, 222, 226);
		    border-radius: 20px;
		    margin: 10px;
	} 
	
	
</style>

<script type="text/javascript">
	$(document).ready(function(){
		
		<%-- === #160. 스마트 에디터 구현 시작 === --%>
		//전역변수
	    var obj = [];
	    
	    //스마트에디터 프레임생성
	    nhn.husky.EZCreator.createInIFrame({
	        oAppRef: obj,
	        elPlaceHolder: "content",
	        sSkinURI: "<%= request.getContextPath() %>/resources/smarteditor/SmartEditor2Skin.html",
	        htParams : {
	            // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseToolbar : true,            
	            // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseVerticalResizer : true,    
	            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseModeChanger : true,
	        }
	    });
		<%-- === #160. 스마트 에디터 구현 끝 === --%>
		
		// 쓰기버튼을 클릭하면
		$("#btnWrite").click(function(){
			
			<%-- === 스마트에디터 구현 시작 === --%>
			//id가 content인 textarea에 에디터에서 대입
	        obj.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
			<%-- === 스마트에디터 구현 끝 === --%>

		//	var category = $("#category option:selected").val();
		//	var len = $("select[name=category] option:selected").length;	
		
			// 글제목 유효성 검사
			var subjectVal = $("#subject").val().trim();
			if(subjectVal == "") {
				alert("글제목을 입력하세요!!");
				return; // 종료
			}
			
			<%-- === 스마트에디터 구현 시작 === --%>
			// 스마트에디터 사용시 무의미하게 생기는 p태그 제거
	        var contentval = $("#content").val();
		        
	        // === 확인용 ===
	        // alert(contentval); // content에 내용을 아무것도 입력치 않고 쓰기할 경우 알아보는것.
	        // "<p>&nbsp;</p>" 이라고 나온다.
	        
	        // 스마트에디터 사용시 무의미하게 생기는 p태그 제거하기전에 먼저 유효성 검사를 하도록 한다.
	        // 글내용 유효성 검사 
	        if(contentval == "" || contentval == "<p>&nbsp;</p>") {
	        	alert("글내용을 입력하세요!!");
	        	return;
	        }
	        
	        // 스마트에디터 사용시 무의미하게 생기는 p태그 제거하기
	        contentval = $("#content").val().replace(/<p><br><\/p>/gi, "<br>"); //<p><br></p> -> <br>로 변환
	    /*    
	                대상문자열.replace(/찾을 문자열/gi, "변경할 문자열");
	        ==> 여기서 꼭 알아야 될 점은 나누기(/)표시안에 넣는 찾을 문자열의 따옴표는 없어야 한다는 점입니다. 
	                     그리고 뒤의 gi는 다음을 의미합니다.

	        	g : 전체 모든 문자열을 변경 global
	        	i : 영문 대소문자를 무시, 모두 일치하는 패턴 검색 ignore
	    */    
	        contentval = contentval.replace(/<\/p><p>/gi, "<br>"); //</p><p> -> <br>로 변환  
	        contentval = contentval.replace(/(<\/p><br>|<p><br>)/gi, "<br><br>"); //</p><br>, <p><br> -> <br><br>로 변환
	        contentval = contentval.replace(/(<p>|<\/p>)/gi, ""); //<p> 또는 </p> 모두 제거시
	    
	        $("#content").val(contentval);
	        // alert(contentval);
		    <%-- === 스마트에디터 구현 끝 === --%>
		   
			
			// 폼(form) 을 전송(submit)
			var frm = document.addFrm;
			frm.method = "POST";
			frm.action = "<%= ctxPath%>/noticeAddEnd.action";
			frm.submit();
			
		});
		
	});	// end of $(document).ready(function(){}) --------------------
	
	function goCategory(value) {
		
		if(value == 1){
			$(".ticketopen").show();
		}
		else {
			$(".ticketopen").hide();
		}
		
	}
	
	
	function goTicketOpen() {
		
		// 팝업창 띄우기
		var prod_title = $("#prod_title").val().trim(); // != value
		
		if(prod_title == '') {
			alert("공연명을 입력해주세요");
			return;
		}
		else {
			var url = "<%= ctxPath%>/ticketopenSearch.action?prod_title="+prod_title;
			window.open(url, "공연명으로 티켓오픈일자 검색",
						"left=350px, top=100px, width=800px, height=650px");
		}
	}
	
	
</script>



<div style="margin-top: 200px;">
	
	<h1 style="text-align: center; ">공지사항 등록</h1>
	
	<div align="center">

		<%-- enctype="multipart/form-data" 를 해주어야만 파일첨부가 되어진다. --%>
		<form name="addFrm" enctype="multipart/form-data">
			<table id="table">
				<%-- <tr>
					<th>성명</th>
					<td>
						<input type="hidden" name="fk_userid" value="${sessionScope.loginuser.userid}">
						<input type="hidden" name="name" value="${sessionScope.loginuser.name}" class="short" readonly="readonly" />
					</td>
				</tr> --%>
				<tr>
					<th>구분</th>
					<td>
						<input type="hidden" name="fk_userid" value="${sessionScope.loginuser.userid}">
						<input type="hidden" name="name" value="${sessionScope.loginuser.name}" class="short" readonly="readonly" />
						<select name="category" id="category" onchange="goCategory(this.value);">
							<option value="1">티켓오픈</option>
							<option value="2">서비스점검</option>
							<option value="3">변경/취소</option>
							<option value="4">기타</option>
						</select>
					</td>
				</tr>
				<%-- ### 티켓오픈데이 date 형식으로 바꾸고, 오전/오후 선택해서 시간 입력해야 한다. ### --%>
				<tr class="ticketopen">
					<th>공연명</th>
					<td>
						<input type="text" id="prod_title" name="prod_title" placeholder="투란도트 " size="30" />
						<i onclick="goTicketOpen();" class="fas fa-search"></i>
						<input type="hidden" name="prod_id" id="prod_id" size="10" />
					</td>
				</tr>
				<tr class="ticketopen">
					<th>티켓오픈</th>
					<td>
						<input type="text" id="ticketopenday" name="ticketopenday" placeholder="2020.08.10(월) 오후 3:00"  size="30" />
					</td>
				</tr>
				<tr>
					<th>제목</th>
					<td>
						<input type="text" name="subject" id="subject" class="long" placeholder="제목을 입력하세요. " />
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<textarea rows="10" cols="100" style="width: 95%; height: 412px;" name="content" id="content"></textarea>
					</td>
				</tr>
				
				<%-- === #146. 파일첨부 타입 추가하기 === --%>
				<tr>
					<th>파일첨부</th>
					<td>
						<input type="file" name="attach" />
					</td>
				</tr>
				
			</table>
			
			<div style="margin: 20px;" class="noticebtn">
				<button type="button" id="btnWrite">쓰기</button>
				<button type="button" onclick="javascrpit:history.back()">취소</button>
			</div>
			
		</form>
	
	</div>
	
</div>