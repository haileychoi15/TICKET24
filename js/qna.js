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

        // 작성했던 내용 없애기
        let radioInputs = document.querySelectorAll('.modal-input-group input[type=radio]');
        let product = document.querySelector('.qna-product-default');
        let title = document.querySelector('.qna-title');
        let content = document.querySelector('.qna-content');

        radioInputs.forEach((item) => {
            item.checked = false;
        });

        product.selected = true;
        title.value = '';
        content.value = '';

        modal.style.display = 'none';
    });

});

function validateForm() {

    let radioInputs = document.querySelectorAll('.modal-input-group input[type=radio]');
    let title = document.querySelector('.qna-title');
    let content = document.querySelector('.qna-content');

    let flag = false;
    radioInputs.forEach((item) => {

        if(item.checked){
            flag = true;
        }
    });

    if(!flag){
        alert('문의 구분을 선택해주세요.');
        return false;
    }

    if(title.value.trim() === ''){
        alert('문의 제목을 입력해주세요.');
        return false;
    }


    if(content.value.trim() === ''){
        alert('문의 내용을 입력해주세요.');
        return false;
    }

    alert('1:1문의가 등록되었습니다. 문의내역은 마이페이지에서 확인하실 수 있습니다.');
    return true;
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