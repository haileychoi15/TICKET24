window.addEventListener('DOMContentLoaded', () => {

    // 카테고리 누를 때 이벤트 발생
    let categoryGroup = document.querySelector('.category-group');
    categoryGroup.addEventListener('click', (event) => {

        let target = event.target;
        if(target.nodeName == 'BUTTON'){

            //ajax

            // 색깔 변경
            console.log(target,event.currentTarget );
            let buttons = event.currentTarget.querySelectorAll('button');
            buttons.forEach((value) => {
                value.classList.remove('selected');
            });

            target.classList.add('selected');
        }

    });




    // 글 제목 누르면 내용 보이기
    let tbody = document.querySelector('.tbody');
    tbody.addEventListener('click', (event) => {

        let target = event.target;
        showContent(target);

    });


    let qnaButton = document.querySelector('.qna-button strong');
    let modal = document.querySelector('.modal');
    qnaButton.addEventListener('click',(event) => {

        modal.style.display = 'flex';
    });

    let closeButton = modal.querySelector('.close-button');
    closeButton.addEventListener('click',() => {

        modal.style.display = 'none';
    });


    // 폼 유효성 검사
    validateForm(modal);

});

function validateForm(modal) {

    let qnaOkButton = modal.querySelector('.qna-ok-button');
    qnaOkButton.addEventListener('click', (event) => {

        //event.preventDefault();

        let flag = false;
        let inputs = modal.querySelectorAll('.modal-input-group input');
        inputs.forEach(value => {
            if(value.checked){
                flag = true;
            }
        });

        if(!flag) {
            alert('문의 종류를 선택해 주세요.');
            return false;
        }

        let title = modal.querySelector('.qna-title');
        if(title.value.trim() === ''){

            return false;
        }

        let content = modal.querySelector('.qna-content');
        if(content.value.trim() === ''){

            return false;
        }





    });
}

function showContent(target) {

    if(target.classList.contains('table-title')){

        let row = target.closest('.row');

        if(row.classList.contains('on')){
            row.classList.remove('on');
        }
        else{
            row.classList.add('on');
        }

    }

}