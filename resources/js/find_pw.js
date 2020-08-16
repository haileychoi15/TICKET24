window.addEventListener('DOMContentLoaded', () => {

    let codeButton = document.querySelector('.send-code-button');
    codeButton.addEventListener('click', validateInput);

    let okButton = document.querySelector('.ok-button');
    okButton.addEventListener('click', validateCode);

});

function validateCode() {

    let code = document.querySelector('#code');

    if(code.value.length !== 6){
        code.classList.add('wrong');
        return false;
    }

    ajaxCode(code.value);
}

function ajaxCode(code) {

    let httpRequest = new XMLHttpRequest();
    makeRequest('/finalproject4/findIDEnd.action', code); // ###

    function makeRequest(url, code) {

        httpRequest.onreadystatechange = getResponse;
        httpRequest.open('GET', `${url}?code=${code}`);
        //httpRequest.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        //httpRequest.send(`userid=${userid}&email=${email}`);
        httpRequest.send();
    }

    function getResponse() {
        if (httpRequest.readyState === XMLHttpRequest.DONE) {
            if (httpRequest.status === 200) {
                let response = httpRequest.responseText;

                console.log('response : ',response);

                let html = '';
                if(Number(response) === 0){ // 인증번호가 일치하지 않으면
                    html += '<p class="no-result">인증번호가 틀렸습니다.</p>';
                }
                document.querySelector('.response').innerHTML = html;

            } else {
                alert('There was a problem with the request.');
            }
        }
    }
}

function validateInput() {

    let userid = document.querySelector('#userid');
    let email = document.querySelector('#email');

    userid.classList.remove('wrong');
    email.classList.remove('wrong');

    if(userid.value.trim() === ''){
        userid.classList.add('wrong');
        return false;
    }

    if(email.value.trim() === ''){
        email.classList.add('wrong');
        return false;
    }

    ajaxInfo(userid.value, email.value);
}

function ajaxInfo(userid, email) {

    let httpRequest = new XMLHttpRequest();
    makeRequest('/finalproject4/findIDEnd.action', userid, email); // ###

    function makeRequest(url, userid, email) {

        httpRequest.onreadystatechange = getResponse;
        httpRequest.open('GET', `${url}?userid=${userid}&email=${email}`);
        //httpRequest.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        //httpRequest.send(`userid=${userid}&email=${email}`);
        httpRequest.send();
    }

    function getResponse() {
        if (httpRequest.readyState === XMLHttpRequest.DONE) {
            if (httpRequest.status === 200) {
                let response = httpRequest.responseText;

                console.log('response : ',response);

                let html = '';
                let codeGroup = document.querySelector('.code-group');
                if(Number(response) === 1){
                    html += '<p class="yes-result">이메일로 인증번호가 발송되었습니다.</p>';
                    codeGroup.style.display = 'block';
                }
                else{
                    html += '<p class="no-result">존재하지 않는 아이디입니다.</p>';
                    codeGroup.style.display = 'block';
                }
                document.querySelector('.response').innerHTML = html;

            } else {
                alert('There was a problem with the request.');
            }
        }
    }
}