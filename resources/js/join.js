window.addEventListener('DOMContentLoaded',() => {

    // 전체 약관 동의 눌렀을 때 이벤트
    let agreeAllBox = document.querySelector('#agree-all');
    let agreeButton = document.querySelector('.agree-button');
    agreeAllBox.addEventListener('click', (event) => {

        let status = event.currentTarget.checked;
        ChangeOtherBoxStatus(status, agreeButton);
        
    });

    // 개별 체크박스 눌렀을 때 이벤트
    let ul = document.querySelector('.agree-area');
    ul.addEventListener('click', (event) => {

        let target = event.target;
        CheckEveryBox(target, agreeAllBox, agreeButton);

    });

    // 동의 버튼 눌렀을 때 이벤트
    agreeButton.addEventListener('click', ()=> {

        // header step 색깔 변경
        let stepGroup = document.querySelector('.step-group');
        stepGroup.classList.replace('step1', 'step2');

        // 마케팅 수신 동의 여부 value 값 가져 오기
        let isSms = false, isEmail = false;
        let agreeBoxes = document.querySelectorAll('.agree-box');
        agreeBoxes.forEach((item) => {

            if(item.id === 'agree-sms' && item.checked) isSms = true;
            if(item.id === 'agree-email' && item.checked) isEmail = true;
        });

        // agree 필드가 사라지고 join 필드가 생긴다.
        document.querySelector('section.agree').style.display = 'none';
        document.querySelector('main.join').style.display = 'block';

        // join 필드가 랜더링 된 이후에 받아온 마케팅 동의 값을 넣어 준다.
        document.querySelector('.is-sms').checked = isSms;
        document.querySelector('.is-email').checked = isEmail;

    });

    // 틀려서 정보 다시 입력할 때 빨간 색 없애기
    let form = document.querySelector('.join-form');
    form.addEventListener('focusin', (event) => {

        let target = event.target;
        if(target.nodeName === 'INPUT'){

            console.log(target.nodeName, target.classList);

            let inputs = form.querySelectorAll('input');
            inputs.forEach((item) => {

                item.classList.remove('wrong');
            });
        }
    });


    // 회원가입 아이디, 이메일 중복 확인
    let useridButton = document.querySelector('.userid-button');
    let userid = document.querySelector('#userid');
    useridButton.addEventListener('click', ajaxCheckValue(userid.name, userid.value));

    let emailButton = document.querySelector('.email-button');
    let email = document.querySelector('#userid');
    emailButton.addEventListener('click', ajaxCheckValue(email.name, email.value));

});

function ajaxCheckValue(name, value) {

    let httpRequest = new XMLHttpRequest();
    makeRequest('/finalproject4/qna.action',value);

    function makeRequest(url, value) {

        httpRequest.onreadystatechange = getResponse;
        httpRequest.open('GET', url);
        httpRequest.send('value=' + encodeURIComponent(userid));
    }

    function getResponse() {
        if (httpRequest.readyState === XMLHttpRequest.DONE) {
            if (httpRequest.status === 200) {
                let response = JSON.parse(httpRequest.responseText);
                alert(response.computedString);

                //ajax 성공시 코드

            } else {
                alert('There was a problem with the request.');
            }
        }
    }


}

function check(re, input, message) {
    if(re.test(input.value)) {
        input.classList.remove('wrong');
        return true;
    }
    input.classList.add('wrong');
    console.log(input.value, message); // 확인용
    //input.focus();
    //return false;
}


// 유효성 검사
function validateForm() {

    let reID = /^[a-zA-Z0-9]{6,12}$/; // 아이디 정규식
    let rePW = /^[a-zA-Z0-9]{8,20}$/; // 패스워드 정규식
    let reEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i; //이메일 정규식
    let reMobile = /^[0-9]{3,4}$/; // 모바일 정규식

    let userid = document.querySelector('#userid');
    let passwd = document.querySelector('#userpw');
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

    alert('회원가입이 완료되었습니다.');
    return true;

}

function CheckEveryBox(target, agreeAllBox, agreeButton) {

    if(target.classList.contains('agree-box')){

        let count = 0;
        let mustCount = 0;
        let agreeBoxes = document.querySelectorAll('.agree-box');
        agreeBoxes.forEach((item) => {

            if(item.checked){
                count++;
            }

            if(item.classList.contains('must') && item.checked){
                mustCount++;
            }
        });

        if(count === agreeBoxes.length){ // 체크박스가 다 선택되면
            agreeAllBox.checked = true; // 전체동의 체크
            agreeButton.disabled = false; // 버튼 able
        }
        else{ // 체크박스가 하나라도 덜 선택되면
            agreeAllBox.checked = false; // 전체동의 미체크

            if(mustCount === 3){ // 그런데 필수 항목 다 체크했으면
                agreeButton.disabled = false; //버튼 able
            }else{ // 필수 항목 다 체크 안했으면
                agreeButton.disabled = 'disabled'; // 버튼 disable
            }
        }

    }

}

function ChangeOtherBoxStatus(status,agreeButton) {

    let boxes = document.querySelectorAll('.agree input[type=checkbox]');
    boxes.forEach((item) => {
        item.checked = status;
    });

    if(status){
        agreeButton.disabled = false;
    }
    else{
        agreeButton.disabled = 'disabled';
    }

}