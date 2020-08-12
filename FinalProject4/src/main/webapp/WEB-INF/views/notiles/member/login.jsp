<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
%>    

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Main page</title>
    <link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="resources/css/grid.min.css">
    <link rel="stylesheet" href="resources/css/reset.css">
    <link rel="stylesheet" href="resources/css/login.css">
    <script src="https://kit.fontawesome.com/5342aa1b58.js" crossorigin="anonymous"></script>
	<script type="text/javascript" src="<%= request.getContextPath()%>/resources/js/jquery-3.3.1.min.js"></script>

<script type="text/javascript">
	
	$(document).ready(function(){
		
		
		
		// === 로컬스토리지(localStorage)에 저장된 userid 값을 불러와서 input태그 userid에 넣어주기 === //
		var loginUserid = localStorage.getItem('saveID');
		
		
		if(loginUserid != null){
			$("#userid").val(loginUserid);
			$("input:checkbox[name=saveID]").prop("checked", true);
		}
		
		 
		 $(".login-button").click(function() {
			 //alert("Asdasd");
			 func_Login();
		 });  
		 
		 $("#pwd").keydown(function(event){
				
				if(event.keyCode == 13) { // 엔터를 했을 경우
					func_Login();
				}
		 }); 
		 
		/* 	
		var keepLoginID = localStorage.getItem('keepLoginID');
		var keepLoginPWD = localStorage.getItem('keepLoginPWD');
		
		if(keepLoginID != null &&  keepLoginPWD != null){
			 $("input:checkbox[name=keepLogin]").prop("checked", true);
			 $("#userid").val(keepLoginID);
			 $("#pwd").val(keepLoginPWD);
			 $(".login-button").trigger('click');
		}
		 */
		 
		 
	}); 
	
	
	function func_Login() {
			 
		 var userid = $("#userid").val(); 
		 var pwd = $("#pwd").val(); 
		
		 if(userid.trim()=="") {
		 	 alert("아이디를 입력하세요!!");
			 $("#userid").val(""); 
			 $("#userid").focus();
			 return;
		 }
		
		 if(pwd.trim()=="") {
			 alert("비밀번호를 입력하세요!!");
			 $("#pwd").val(""); 
			 $("#pwd").focus();
			 return;
		 }
	
	 
		// === 로컬 스토리지(localStorage)에 userid 값 저장시키기 === //
		if($("input:checkbox[name=saveID]").prop("checked")){
			localStorage.setItem('saveID', $("#userid").val()); // 로컬 스토리지에 ID를 저장.
		}
		else{
			localStorage.removeItem('saveID'); // 로컬 스토리지에 저장된 ID 삭제
		}
		
		/* 
		// === 자동 로그인 시도...1 ===//
		if($("input:checkbox[name=keepLogin]").prop("checked")){
			localStorage.setItem('keepLoginID', $("#userid").val());
			localStorage.setItem('keepLoginPWD', $("#pwd").val()); 
		}
		else{
			localStorage.removeItem('keepLoginID');
			localStorage.removeItem('keepLoginPWD'); 
		} */
		 
		var frm = document.loginFrm;
		 
		frm.action = "<%=ctxPath%>/loginEnd.action";
		frm.method = "POST";
		frm.submit();
		 
	}

</script>

</head>

<body>
    <header class="header">
        <a href="#">
            <div class="logo-image" role="img" aria-label="Ticket24 icon image"></div>
        </a>
        <h1>TICKET24 로그인</h1>
    </header>
    <section class="login">
        <div class="login-area">
            <form class="login-form" name="loginFrm">
                <label for="userid" >아이디</label>
                <input name="userid" id="userid" type="text" maxlength="20" />
                <label for="pwd" >비밀번호</label>
                <input name="pwd" id="pwd" type="password" maxlength="20" />
                <div class="checkbox-group">
                    <input name="keepLogin" id="keep-login" type="checkbox" value="1">
                    <label for="keep-login">
                        <span>로그인 상태 유지</span>
                    </label>
                    <input name="saveID" id="save-id" type="checkbox" value="1">
                    <label for="save-id">
                        <span>아이디 저장</span>
                    </label>
                </div>
                <button type="button" class="login-button">로그인</button>
            </form>
            <div class="find-id">
                <a href="">아이디 찾기</a>
                <a href="">비밀번호 찾기</a>
            </div>
            <div class="other-login">
                <button type="button" onclick="location.href='${url}'">
                    <span class="logo-icon naver-logo-icon" role="img" aria-label="Naver icon image"></span>
                    <strong>네이버 아이디로 로그인</strong>
                </button>
                <button type="button" onclick="location.href='https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=0ce82228a182b543337d77406ca58a08&redirect_uri=http://localhost:9090/finalproject4/KakaoLoginEnd.action'">
                    <span class="logo-icon kakao-logo-icon" role="img" aria-label="Kakao icon image"></span>
                    <strong>카카오 아이디로 로그인</strong>
                </button>
            </div>
        </div>
        <section class="join-box">
            <strong>티켓24 계정이 없으세요? <a href="<%=ctxPath%>/register.action">회원가입</a></strong>
        </section >
    </section>
    <footer class="footer">Copyright © YES24 Corp. All Rights Reserved.</footer>

</body>
</html>