window.addEventListener('DOMContentLoaded', () => {

    // 카테고리 누를 때 이벤트 발생
    let categoryGroup = document.querySelector('.category-group');
    categoryGroup.addEventListener('click', (event) => {

        let target = event.target;
        if(target.nodeName == 'BUTTON'){

            let category = target.value;
            console.log(category);

            //ajax
            ajaxBoard(category);
            
            let searchWord = document.querySelector('.search-word').value;
            console.log(searchWord + "searchWord1");

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
        let userid = modal.querySelector('.modal-form .userid');
        console.log('userid',userid);
        ajaxProduct(userid);
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

function ajaxProduct(userid) {

    let httpRequest = new XMLHttpRequest();
    makeRequest('/finalproject4/qna.action',category);

    function makeRequest(url, category) {

        httpRequest.onreadystatechange = getResponse;
        httpRequest.open('GET', url);
        httpRequest.send('userid=' + encodeURIComponent(userid));
    }

    function getResponse() {
        if (httpRequest.readyState === XMLHttpRequest.DONE) {
            if (httpRequest.status === 200) {
                let response = JSON.parse(httpRequest.responseText);
                alert(response.computedString);

                //ajax 성공시 코드

                let selectElement = document.querySelector('.qna-product');
                let html = '';
                response.forEach((item) => {

                        html += `<option value="">${item}</option>`;
                });

                selectElement.insertAdjacentElement('beforeend', html);


            } else {
                alert('There was a problem with the request.');
            }
        }
    }

}

function getBoardTemplate(category, title, content) {

    let template = `<div class="row">
                    <span class="table-category">
                        ${category}
                    </span>
                    <span class="table-title">
                        ${title}
                    </span>
                    <div class="table-content">
                        ${content}
                    </div>
                </div>`;

    return template;
}

function ajaxBoard(category) {

	
    let searchWord = document.querySelector('.search-word').value;
    console.log(searchWord + "searchWord2");
    
    let httpRequest = new XMLHttpRequest();
    makeRequest('/finalproject4/faq.action',category);

    function makeRequest(url, category) {

    	console.log(url + ":url");
    	console.log(category + ":category")
        httpRequest.onreadystatechange = getResponse;
        httpRequest.open('POST', url);
        httpRequest.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        httpRequest.send('category=' + encodeURIComponent(category)+ '&searchWord=' + encodeURIComponent(searchWord));
        
    }

    function getResponse() {
        if (httpRequest.readyState === XMLHttpRequest.DONE) {
            if (httpRequest.status === 200) {
                let response = JSON.parse(httpRequest.responseText);
                alert(response.computedString);

                //ajax 성공시 코드
/*
                let html = '';
                response.forEach((item) => {

                    html += getBoardTemplate(item.category, item.title, item.content);
                });

                let tbody = document.querySelector('.qna .table .tbody');
                tbody.insertAdjacentElement('beforeend', html);
*/

            } else {
                alert('There was a problem with the request.');
            }
        }
    }
}

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