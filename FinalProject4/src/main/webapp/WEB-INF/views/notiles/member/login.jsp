<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>    
    
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
		 
		 $(".login-button").click(function() {
			 func_Login();
		 }); 
		 
		 $("#pwd").keydown(function(event){
				
				if(event.keyCode == 13) { // 엔터를 했을 경우
					func_Login();
				}
		 }); 
		 
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
                <input name="userID" id="userid" type="text" maxlength="20" />
                <label for="pwd" >비밀번호</label>
                <input name="userPW" id="pwd" type="password" maxlength="20" />
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
                    <span>네이버 아이디로 로그인</span>
                </button>
                <button type="button" onclick="location.href='https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=0ce82228a182b543337d77406ca58a08&redirect_uri=http://localhost:9090/board/KakaoLoginEnd.action'">
                    <span class="logo-icon kakao-logo-icon" role="img" aria-label="Kakao icon image"></span>
                    <span>카카오 아이디로 로그인</span>
                </button>
            </div>
        </div>
        <div class="register-box">
            <strong>티켓24 계정이 없으세요? <a href="#">회원가입</a></strong>
        </div>
    </section>
    <footer class="footer">Copyright © YES24 Corp. All Rights Reserved.</footer>

</body>
</html>