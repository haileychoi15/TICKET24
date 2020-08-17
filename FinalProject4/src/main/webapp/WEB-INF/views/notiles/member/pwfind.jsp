<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String ctxPath = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Find Password page</title>
    <link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="resources/css/reset.css">
    <link rel="stylesheet" href="resources/css/find_pw.css">
    <script src="https://kit.fontawesome.com/5342aa1b58.js" crossorigin="anonymous"></script>
</head>
<body>
<div class="container">
    <header class="tab-section">
        <h1 class="section-title">
            <a href="<%= ctxPath%>/yes24.action">TICKET24</a>
        </h1>
        <ul class="find-tab">
            <li role="tab" aria-selected="false">
                <a href="<%=ctxPath %>/findID.action" role="button">아이디 찾기</a>
            </li>
            <li role="tab" aria-selected="true">
                <a href="<%=ctxPath %>/findPW.action" role="button">비밀번호 찾기</a>
            </li>
        </ul>
    </header>
    <main class="main">
        <header>
            <h1>비밀번호 찾기</h1>
            <p>내 정보에 등록한 정보와 일치하면,
                <br />
                새로운 비밀번호를 설정할 수 있습니다.</p>
        </header>
        <div class="info-box">
            <div class="userid-group input-group">
                <label for="userid">아이디</label>
                <input id="userid" type="text" placeholder="">
            </div>
            <div class="email-group input-group">
                <label for="email">이메일</label>
                <input id="email" type="email" placeholder="인증번호를 받을 이메일">
            </div>
            <button class="send-code-button">인증번호 발송</button>
        </div>
        <div class="response">
        </div>
        <div class="code-group input-group">
            <label for="code">인증번호</label>
            <input id="code" type="text" placeholder="" readonly>
        </div>
        
       	<input type="hidden" id="PWuserid" name="PWuserid" value="${sessionScope.userid }" />
        
        <ul class="button-group">
            <li role="tab" aria-selected="true">
                <a href="<%=ctxPath%>/login.action" role="button" class="cancel-button">취소</a>
            </li>
            <li role="tab" aria-selected="false">
                <button type="button" class="ok-button">확인</button>
            </li>
        </ul>
        <footer class="main-footer">
            <p>아이디와 이메일로 비밀번호를 찾을 수 없을 경우, <em><a href="<%= ctxPath%>/qna.action" role="button">고객센터</a></em>에 문의해 주세요.</p>
        </footer>
    </main>
    <footer class="footer">
        © TICKET24 Corp.
    </footer>
</div>
<script src="resources/js/find_pw.js"></script>
</body>
</html>