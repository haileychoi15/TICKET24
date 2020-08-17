window.addEventListener('DOMContentLoaded', () => {

    let okButton = document.querySelector('.ok-button');
    okButton.addEventListener('click', validateInput);

});

function validateInput() {

    let name = document.querySelector('#name');
    let mobile = document.querySelector('#mobile');

    name.classList.remove('wrong');
    mobile.classList.remove('wrong');

    if(name.value.trim() === ''){
        name.classList.add('wrong');
        return false;
    }

    console.log(mobile.value.length);

    if(mobile.value.length !== 11){
        mobile.classList.add('wrong');
        return false;
    }

    ajaxInfo(name.value, mobile.value);

    name.value = '';
    mobile.value = '';
}

function ajaxInfo(name, mobile) {

    let httpRequest = new XMLHttpRequest();
    makeRequest('/finalproject4/findIDEnd.action', name, mobile); // ###

    function makeRequest(url, name, mobile) {

        httpRequest.onreadystatechange = getResponse;
        httpRequest.open('GET', `${url}?name=${name}&mobile=${mobile}`);
        //httpRequest.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        //httpRequest.send(`name=${name}&mobile=${mobile}`);
        httpRequest.send();

    }

    function getResponse() {
        if (httpRequest.readyState === XMLHttpRequest.DONE) {
            if (httpRequest.status === 200) {
                let response = httpRequest.responseText;

                console.log('response : ',response);


                let html = '';
                if(response.length > 0){
                    html += `<p class="yes-result">${name}님의 아이디는 <strong>${response}</strong>&nbsp;입니다. <a href="#">로그인</a></p>`;
                }
                else{
                    html += `<p class="no-result">정보와 일치하는 아이디가 존재하지 않습니다.</p>`;
                }
                document.querySelector('.response').innerHTML = html;

            } else {
                alert('There was a problem with the request.');
            }
        }
    }
}