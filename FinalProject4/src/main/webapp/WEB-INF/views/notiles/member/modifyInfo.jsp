<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% String ctxPath = request.getContextPath(); %>
    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>정보 수정</title>
    <link rel="stylesheet" href="resources/css/modifyInfo.css">
    <script type="text/javascript" src="<%= request.getContextPath()%>/resources/js/jquery-3.3.1.min.js"></script>
    <script type="text/javascript">
    
    	$(document).ready(function(){
    		if(${mvo.isSMS} == '1'){
    			$("#user_is_sms").prop("checked", true);
    		}	
    		if(${mvo.isEMAIL} == '1'){
    			$("#user_is_email").prop("checked", true);
    		}	 
    		
    		
    		$("#modify").click(function(){
    			modifyInfo();
    		});
    		
    		
    		
    	});
    	
    	function modifyInfo(){
    		
    		var frm = document.modifyFrm;
    		frm.method = "POST";
			frm.action = "<%= ctxPath%>/modifyEnd.action";
			frm.submit();
    		
    	}
    	
    </script>
    
</head>
<body>
    <div id="container">
        <div id="title">나의 정보 수정</div>

        <div id="myPageForm">
            <form name="modifyFrm">
                <div class="myPageCol idDiv">
                    <div class="inputArea">
                        <div class="label">아이디</div>
                        <input class="data" name="userid" value="${mvo.userid}" id="user_userid" type="text" size="15" readonly>
                    </div>
                </div>
                <div class="myPageCol">
                    <div class="inputArea">
                        <div class="label">비밀번호</div>
                        <input class="data" name="pwd" id="user_pw" type="password">
                    </div>
                </div>
                <div class="myPageCol">
                    <div class="inputArea">
                        <div class="label">비밀번호 확인</div>
                        <input class="data" name="pwdConfirm" id="pwConfirm" type="password">
                    </div>
                </div>
                <div class="myPageCol">
                    <div class="inputArea">
                        <div class="label">이름</div>
                        <input class="data" name="name" value="${mvo.name}" id="user_name" type="text" size="15" readonly>
                    </div>
                </div>
                <div class="myPageCol addressDiv">
                    <div class="inputArea">
                        <div class="label">주소</div>
                        <input class="data" name="postcode" value="${mvo.postcode}" id="user_postcode" type="text" size="10"><button>주소찾기</button><br>
                        <input class="data" name="address" value="${mvo.address}" id="user_address" type="text" size="20">
                        <input class="data" name="detailAddress" value="${mvo.detailAddress}" id="user_datail_address" type="text" size="15">
                    </div>
                </div>
                <div class="myPageCol">
                    <div class="inputArea">
                        <div class="label">전화번호</div>
                        <input class="data" name="hp1" value="${mvo.hp1 }" id="user_mobile1" type="text" size="5"> - <input class="data" name="hp2" value="${mvo.hp2 }"  id="user_mobile2" type="text" size="5"> - <input class="data" name="hp3" value="${mvo.hp3 }" id="user_mobile3" type="text" size="5">
                    </div>
                </div>
                <div class="myPageCol">
                    <div class="inputArea">
                        <div class="label">이메일</div>
                        <input class="data" name="email" value="${mvo.email }" id="user_email" type="text" size="30">
                    </div>
                </div>
                <div class="myPageCol agreeDiv">
                    <div class="inputArea agree">
                        <div class="label">수신동의</div>
                        <input class="data" name="isSMS" id="user_is_sms" value="1" type="checkbox"><label for="user_is_sms">sms 수신 동의</label><br>
                        <input class="data" name="isEMAIL" id="user_is_email" value="1" type="checkbox"><label for="user_is_email">email 수신 동의</label>
                    </div>
                </div>
            </form>
        </div>

        <div id="btnArea">
            <button id="modify">수정</button>
            <button id="cancel">취소</button>
        </div>
    </div>
</body>
<script src="<%= request.getContextPath()%>/resources/js/modifyInfoScript.js"></script>
</html>