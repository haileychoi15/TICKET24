window.addEventListener('DOMContentLoaded', () => {

    let infoBox = document.querySelector('.info-box');

    infoBox.addEventListener('focusin', (event) => {

        let target = event.target;
        if(target.nodeName === 'INPUT'){
            let label = target.closest('.input-group').firstElementChild;
            label.classList.add('on');
        }
    });

    infoBox.addEventListener('focusout', (event) => {

        let target = event.target;
        if(target.nodeName === 'INPUT' && target.value.trim() === ''){
            let label = target.closest('.input-group').firstElementChild;
            label.classList.remove('on');
        }
    });

    infoBox.addEventListener('click', (event) => {

        let target = event.target;
        if(target.nodeName === 'BUTTON'){
            let buttons = event.currentTarget.querySelectorAll('.input-group > button');
            let inputs = event.currentTarget.querySelectorAll('.input-group > input');
            if(target.classList.contains('hide')){

                buttons.forEach((item) => {
                    item.classList.replace('hide','show');
                });
                inputs.forEach((item) => {
                    item.type = 'text';
                });

            }
            else{
                buttons.forEach((item) => {
                    item.classList.replace('show','hide');
                });
                inputs.forEach((item) => {
                    item.type = 'password';
                });
            }
        }
    });

    let userpwCheck = document.querySelector('#userpw-check');
    userpwCheck.addEventListener('keyup', () => {

        let html = '<p class="no-result">비밀번호가 일치하지 않습니다.</p>';
        document.querySelector('.response').innerHTML = html;

        let userpw = document.querySelector('#userpw');
        if(userpw.value === userpwCheck.value){
            let result = document.querySelector('.no-result');
            result.innerText = '비밀번호가 일치합니다.';
            result.classList.replace('no-result','yes-result');
        }
    });
});

function validateForm() {

    let userpw = document.querySelector('#userpw');
    let userpwCheck = document.querySelector('#userpw-check');

    userpw.classList.remove('wrong');
    userpwCheck.classList.remove('wrong');

    let re = /^[a-z0-9!@#$%^&*]{8,20}$/; // 패스워드 정규식

    if(!re.test(userpw.value)){
        userpw.classList.add('wrong');
        return false;
    }

    if(!re.test(userpwCheck.value)){
        userpwCheck.classList.add('wrong');
        return false;
    }

    if(userpw.value !== userpwCheck.value){
        userpwCheck.classList.add('wrong');
        return false;
    }

    return true;
}