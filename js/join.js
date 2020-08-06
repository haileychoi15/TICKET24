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

});

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
            agreeButton.style.backgroundColor = '#d96f1c'; // 버튼 able
        }
        else{ // 체크박스가 하나라도 덜 선택되면
            agreeAllBox.checked = false; // 전체동의 미체크

            if(mustCount === 3){ // 그런데 필수 항목 다 체크했으면
                agreeButton.style.backgroundColor = '#d96f1c'; //버튼 able
            }else{ // 필수 항목 다 체크 안했으면
                agreeButton.style.backgroundColor = '#ddd'; // 버튼 disable
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
        agreeButton.style.backgroundColor = '#d96f1c';
    }
    else{
        agreeButton.style.backgroundColor = '#ddd';
    }

}