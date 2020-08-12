<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
%>     
    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Join page</title>
    <link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="resources/css/reset.css">
    <link rel="stylesheet" href="resources/css/join.css">
    <script src="https://kit.fontawesome.com/5342aa1b58.js" crossorigin="anonymous"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/resources/js/jquery-3.3.1.min.js"></script>
</head>
<body>
    <header class="header">
        <div class="header-top">
            <a href="#">
                <div class="logo-image" role="img" aria-label="Ticket24 icon image"></div>
            </a>
            <h1>TICKET24 회원가입</h1>
        </div>
        <div class="step-group step1">
            <div class="agree-step step">
                <span role="img" aria-label="Agree icon image"></span>
                <strong aria-label="Step1 약관동의">약관동의</strong>
            </div>
            <div class="join-step step">
                <span role="img" aria-label="Join icon image"></span>
                <strong aria-label="Step2 정보입력">정보입력</strong>
            </div>
        </div>
    </header>
    <section class="agree">
        <h1>
            서비스 이용을 위해 <br /> 아래 이용약관에 동의해주세요.
        </h1>
        <ul class="agree-area">
            <li class="input-group agree-all-group">
                <input id="agree-all" type="checkbox"/>
                <label for="agree-all">
                    <span>전체 약관에 동의합니다.</span>
                </label>
                <p>전체 동의는 필수 및 선택 정보에 대한 동의를 포함하고 있습니다. 각 약관에 대한 개별적인 동의를 할 수 있습니다.</p>
            </li>
            <li class="input-group agree1-group">
                <input id="agree1" type="checkbox" class="agree-box must"/>
                <label for="agree1">
                    <span>[필수] TICKET24 서비스 이용약관 동의</span>
                </label>
                <a href="#"></a>
            </li>
            <li class="input-group agree2-group">
                <input id="agree2" type="checkbox" class="agree-box must"/>
                <label for="agree2">
                    <span>[필수] 개인 정보 수집 및 이용 동의</span>
                </label>
                <a href="#"></a>
            </li>
            <li class="input-group agree3-group">
                <input id="agree3" type="checkbox" class="agree-box must"/>
                <label for="agree3">
                    <span>[필수] 개인정보 처리 위탁 동의</span>
                </label>
                <a href="#"></a>
            </li>
            <li class="input-group agree-sms-group">
                <input id="agree-sms" type="checkbox" class="agree-box option"/>
                <label for="agree-sms">
                    <span>[선택] sms 마케팅 수신 동의</span>
                </label>
                <a href="#"></a>
            </li>
            <li class="input-group agree-email-group">
                <input id="agree-email" type="checkbox" class="agree-box option"/>
                <label for="agree-email">
                    <span>[선택] email 마케팅 수신 동의</span>
                </label>
                <a href="#"></a>
            </li>
            <li class="notice">
                <p>14세 미만 청소년은 가입 불가합니다.</p>
            </li>
            <li class="notice">
                <p>TICKET24의 약관을 제공받고 그 내용을 충분히 숙지하였음을 확인하고 계정을 생성합니다.</p>
            </li>
        </ul>
        <button type="button" class="agree-button" disabled="disabled">동의합니다.</button>
    </section>
    <main class="join">
        <div class="join-area">
            <form class="join-form" name="registerFrm" onsubmit="return validateForm();">
                <div class="input-group id-group">
                    <label for="userid">아이디</label>
                    <button type="button" id="idcheck" class="userid-button">중복 확인</button>
                    <input name="userid" id="userid" type="text" placeholder="6~12자 이내의 영문과 숫자의 조합으로 입력해주세요."/>
                </div>
                <div class="input-group password-group hide">
                    <label for="pwd">비밀번호</label>
                    <input name="pwd" id="pwd" type="password" placeholder="8~20자 이내의 영문과 숫자의 조합으로 입력해주세요.">
                    <button type="button" aria-label="Show password" class="password-button"></button>
                </div>
                <div class="input-group name-group">
                    <label for="name">이름</label>
                    <c:if test="${paraMap == null}">
                    	<input name="name" id="name" type="text" placeholder="이름을 입력해주세요."/>
                    </c:if>
                    <c:if test="${paraMap != null}">
                    	<input name="name" id="name" type="text" value="${paraMap.name}" placeholder="이름을 입력해주세요."/>
                    </c:if>
                </div>
                <div class="input-group email-group">
                    <label for="email">이메일</label>
                    <button type="button" class="email-button" onclick="isExistEmailCheck();">중복 확인</button>
                    <c:if test="${paraMap == null}">
                    	<input name="email" id="email" type="email" placeholder="이메일을 입력해주세요."/>
                    </c:if>
                    <c:if test="${paraMap != null}">
                    	<input name="email" id="email" value="${paraMap.email }" readonly type="email" placeholder="이메일을 입력해주세요."/>
                    </c:if>
                    
                </div>
                <div class="input-group mobile-group">
                        <label for="mobile1">연락처</label>
                    <div class="mobile-input-group">
                        <input name="mobile1" id="mobile1" class="mobile" type="mobile" placeholder="010"/>
                        <span aria-label="Dash">—</span>
                        <input name="mobile2" id="mobile2" class="mobile" type="mobile" placeholder="0000"/>
                        <span aria-label="Dash">—</span>
                        <input name="mobile3" id="mobile3" class="mobile" type="mobile" placeholder="0000"/>
                    </div>
                </div>
                <div class="input-group postcode-group">
                    <label for="postcode">우편번호</label>
                    <button type="button" class="address-button">우편번호 검색</button>
                    <input name="postcode" id="postcode" type="text" placeholder="우편번호 검색을 이용해주세요." readonly/>
                </div>
                <div class="input-group address-group">
                    <label for="address">주소</label>
                    <input name="address" id="address" type="text" placeholder="우편번호 검색을 이용해주세요." readonly/>
                </div>
                <div class="input-group">
                    <label for="detailaddress">상세주소</label>
                    <input name="detailaddress" id="detailaddress" type="text" placeholder="상세주소를 입력해주세요."/>
                </div>
                <div class="checkbox-group">
                    <input name="is-sms" type="checkbox" class="is-sms" value="1" hidden>
                    <input name="is-email" type="checkbox" class="is-email" value="1" hidden>
                </div>
                <button type="submit" class="join-button">회원가입</button>
            </form>
        </div>
    </main>
    <footer class="footer">Copyright © WORKS MOBILE Corp. All Rights Reserved.</footer>
    <script src="resources/js/join.js"></script>
    <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
    <!-- autoload=false 자동으로 로딩되는 것을 막는다.-->
    <script>

	    var bIdDuplicateCheck = false; // 아이디중복확인을 클릭했는지 클릭안했는지를 알아보기 위한 용도임.
	    var bEmailDuplicateCheck = false;
    
        window.addEventListener('DOMContentLoaded', () => {

            let passwordButton = document.querySelector('.password-button');
            passwordButton.addEventListener('click', () => {

                setPasswordStatus();
            });

            let addressButton = document.querySelector('.address-button');
            addressButton.addEventListener('click', () => {

                setAddress();
            });
            
            if(${msg != null}) {
         		alert("${msg}");
         	} 
            
    		/// **** id 중복체크  ****///
    		$("#idcheck").click(function() {
    			bIdDuplicateCheck = true; // 아이디중복확인을 클릭했는지 클릭안했는지를 알아보기 위한 용도임.(클릭함)
    			
    			$.ajax({
    				url:"<%= ctxPath%>/member/idDuplicateCheck.action",
    				type:"post",
    				data:{"userid":$("#userid").val()},
    				dataType:"json",
    				success:function(json){
    					if(json.isUse) {
    						// 사용가능한 아이디
    						alert("가능");
    					}
    					else {
    						// 아이디 중복 메시지
    						alert("불가능");
    						$("#userid").val("");
    					}
    				},
    				error: function(request, status, error){
    					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
    				}
    			});
    			
    		});// end of $("#idcheck").click()------------
    		

        });
        
    	function isExistEmailCheck() {
    		
    		bEmailDuplicateCheck = true; // 아이디중복확인을 클릭했는지 클릭안했는지를 알아보기 위한 용도임.(클릭함)
    		
    		$.ajax({
    			url:"<%= ctxPath%>/member/emailDuplicateCheck.action",
    			type:"post",
    			data:{"email":$("#email").val()},
    			dataType:"json",
    			success:function(json){
    				if(json.isUse) {
    					// 사용가능한 이메일
    					alert("가능");
    				}
    				else {
    					// 이메일 중복
    					$("#email").val("");
    					alert("불가능");
    				}
    			},
    			error: function(request, status, error){
    				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
    			}
    		});
    		
    	}
        

        function setPasswordStatus() {

            let passwordGroup = document.querySelector('.password-group');
            let input = passwordGroup.querySelector('input');

            if(passwordGroup.classList.contains('hide')){
                passwordGroup.classList.replace('hide','show');
                input.type = 'text';
            }
            else{
                passwordGroup.classList.replace('show','hide');
                input.type = 'password';
            }

        };

        function setAddress(){

            new daum.Postcode({
                oncomplete: function(data) {
                    // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
                    // 예제를 참고하여 다양한 활용법을 확인해 보세요.

                    var addr = ''; // 주소 변수
                    var extraAddr = ''; // 참고항목 변수

                    //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                    if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                        addr = data.roadAddress;
                    } else { // 사용자가 지번 주소를 선택했을 경우(J)
                        addr = data.jibunAddress;
                    }

                    // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                    if(data.userSelectedType === 'R'){
                        // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                        // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                        if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                            extraAddr += data.bname;
                        }
                        // 건물명이 있고, 공동주택일 경우 추가한다.
                        if(data.buildingName !== '' && data.apartment === 'Y'){
                            extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                        }
                        // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                        if(extraAddr !== ''){
                            extraAddr = ' (' + extraAddr + ')';
                        }
                        // 조합된 참고항목을 해당 필드에 넣는다.
                        // document.getElementById("sample6_extraAddress").value = extraAddr;
                        console.log(extraAddr);

                    } else {
                        //document.getElementById("sample6_extraAddress").value = '';
                        console.log(extraAddr);
                    }

                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
                    document.querySelector('#postcode').value = data.zonecode;
                    document.querySelector('#address').value = addr;
                    document.querySelector('#address').value += extraAddr;
                    // 커서를 상세주소 필드로 이동한다.
                    document.querySelector('#detailaddress').focus();
                }
            }).open();

        }; // end of function setAddress();


        

     // 유효성 검사
     function validateForm() {

         let reID = /^[a-zA-Z0-9]{6,12}$/; // 아이디 정규식
         let rePW = /^[a-zA-Z0-9]{8,20}$/; // 패스워드 정규식
         let reEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i; //이메일 정규식
         let reMobile = /^[0-9]{3,4}$/; // 모바일 정규식

         let userid = document.querySelector('#userid');
         let passwd = document.querySelector('#pwd');
         let name = document.querySelector('#name');
         let email = document.querySelector('#email');
         let mobile = document.querySelectorAll('.mobile');

         if(!check(reID,userid,"아이디는 6~12자의 영문과 숫자로만 입력")) {
             return false;
         }

         if(!check(rePW,passwd,"비밀번호는 8~20자의 영문과 숫자로만 입력")) {
             return false;
         }

         if(name.value.trim() === ''){
             name.classList.add('wrong');
             return false;
         }

         if(!check(reEmail,email,"이메일형식이 올바르지 않습니다.")) {
             return false;
         }

         if(!check(reMobile,mobile[0],"휴대폰 번호 형식이 올바르지 않습니다.")) {
             return false;
         }

         if(!check(reMobile,mobile[1],"휴대폰 번호 형식이 올바르지 않습니다.")) {
             return false;
         }

         if(!check(reMobile,mobile[2],"휴대폰 번호 형식이 올바르지 않습니다.")) {
             return false;
         }

        if(${paraMap.kakao == 1}){
	      	var frm = document.registerFrm;
        	frm.method = "POST";
        	frm.action = "<%= ctxPath%>/kakaoRegister.action";
        	frm.submit();
        	
	        return true;
        }
        else if(${paraMap.naver == 1}){
	      	var frm = document.registerFrm;
        	frm.method = "POST";
        	frm.action = "<%= ctxPath%>/naverRegister.action";
        	frm.submit();
        	
	        return true;
        }
        else{
	      	var frm = document.registerFrm;
        	frm.method = "POST";
        	frm.action = "/finalproject4/register.action";
        	frm.submit();
	        	
	        //alert('회원가입이 완료되었습니다.');
	        return true;
        }
     }
        
        
    </script>
</body>
</html>