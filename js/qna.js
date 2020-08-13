window.addEventListener('DOMContentLoaded', () => {

    ajaxBoard(1);

    // 검색 버튼 눌렀을 때 이벤트
    let searchButton = document.querySelector('.search-button');
    searchButton.addEventListener('click', () => {

        setFirstPage();
        ajaxBoard(1);
    });

    // 엔터 눌렀을 때 이벤트
    let searchWord = document.querySelector('.search-word');
    searchWord.addEventListener("keyup",(event)=>{
        if(event.keyCode === 13){
            searchButton.click();
            return false;
        }
    });

    // 카테고리 누를 때 이벤트 발생
    let categoryGroup = document.querySelector('.category-group');
    categoryGroup.addEventListener('click', (event) => {

        let target = event.target;
        if(target.nodeName == 'BUTTON'){

            // 색깔 변경
            let buttons = event.currentTarget.querySelectorAll('button');
            buttons.forEach((value) => {
                value.classList.remove('selected');
            });
            target.classList.add('selected');

            setFirstPage();
            ajaxBoard(1);
        }
    });

    // 페이지 눌렀을 때
    let pageGroup = document.querySelector('.page-group');
    pageGroup.addEventListener('click', (event) => {

        let target = event.target;
        if(target.nodeName === 'BUTTON'){

            removePageColor();
            target.classList.add('selected');

            let page = target.innerText;
            ajaxBoard(page);
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
        let userid = modal.querySelector('.modal-form #userid').value;
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

function removePageColor() {

    let buttons = document.querySelectorAll('.page-button'); //  색깔 변경
    buttons.forEach((item) => {
        item.classList.remove('selected');
    });
}

function setFirstPage() {

    removePageColor();
    let buttons = document.querySelectorAll('.page-button');
    buttons[0].classList.add('selected');
}

function ajaxBoard(page) {

    let searchWord = document.querySelector('.search-word').value;
    let category = document.querySelector('.category-group .selected').value;
    console.log('searchWord : ',searchWord,', category : ',category,', page : ',page);

    let httpRequest = new XMLHttpRequest();
    makeRequest('/faq', searchWord, category, page); // ####

    function makeRequest(url, searchWord, category, page) {

        httpRequest.onreadystatechange = getResponse;
        httpRequest.open('GET', `${url}?searchWord=${searchWord}&category=${category}&page=${page}`);
        httpRequest.send();
    }

    function getResponse() {
        if (httpRequest.readyState === XMLHttpRequest.DONE) {
            if (httpRequest.status === 200) {
                let response = JSON.parse(httpRequest.responseText);

                console.log(response.computedString); //ajax 성공시 코드

                let html = '';
                let recodes = 0;

                let notice = document.querySelector('.no-result-notice');
                let thead = document.querySelector('.table .thead');
                let tbody = document.querySelector('.table .tbody');
                let pageGroup = document.querySelector('.page-group');

                if(response.length === 0){ // 받은 데이터가 없을 때

                    notice.classList.replace('hide','show');
                    thead.classList.replace('show','hide');
                    tbody.innerHTML = '';
                    pageGroup.style.visibility = 'hidden';

                }
                else { // 데이터가 있으면

                    notice.classList.replace('show', 'hide');
                    thead.classList.replace('hide', 'show');
                    pageGroup.style.visibility = 'visible';

                    response.forEach((item) => {
                        html += getBoardTemplate(item.category, item.subject, item.content);
                        recodes = item.totalCount;
                    });

                    setPageList(pageGroup, page, recodes); // 페이징 처리
                    tbody.innerHTML = html;
                }

            } else {
                alert('There was a problem with the request.');
            }
        }
    }
}

function setPageList(pageGroup, page, recodes) { // 현재 누른 페이지, 총 레코드 수

    let totalPage = Math.ceil(Number(recodes)/5);

    let html = '';
    for(let i=0; i<totalPage; i++){

        let count = i+1;
        if(Number(page) === count){ // 선택된 페이지에 selected class 추가
            html += `<button type="button" class="page-button selected" aria-label="Go to page${count}">${count}</button>`
        }
        else{
            html += `<button type="button" class="page-button" aria-label="Go to page${count}">${count}</button>`
        }
    }
    pageGroup.innerHTML = html;

}

function ajaxProduct(userid) {

    let httpRequest = new XMLHttpRequest();
    makeRequest('/finalproject4/qna.action', userid); // ####

    function makeRequest(url, userid) {

        httpRequest.onreadystatechange = getResponse;
        httpRequest.open('GET', `${url}?fk_userid=${userid}`);
        httpRequest.send();
    }

    function getResponse() {
        if (httpRequest.readyState === XMLHttpRequest.DONE) {
            if (httpRequest.status === 200) {

                let response = httpRequest.responseText.split(',');
                console.log(response, response.computedString, response.length); //ajax 성공시 코드

                let html = `<option value="0" class="qna-product-default selected">해당사항없음</option>`;

                if(response.length !== 0){
                    response.forEach((item) => {
                        html += `<option value="">${item}</option>`;
                    });
                }
                document.querySelector('.modal-form .qna-product').innerHTML = html;

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