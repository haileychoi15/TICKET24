window.addEventListener('DOMContentLoaded', () => {

    ajaxBoard(1);

    // 검색 버튼 클릭 했을 때 이벤트
    let searchButton = document.querySelector('.search-button');
    searchButton.addEventListener('click',() => {
    	
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

    let category = document.querySelector('.category-group .selected').value;
    let searchWord = document.querySelector('.search-word').value.trim();
    if(searchWord === null) {
        searchWord = '';
    }
    console.log("searchWord : ", searchWord, ", category : ", category ,", page : ", page); //확인용

    let httpRequest = new XMLHttpRequest();
    makeRequest('/finalproject4/notice.action', searchWord, category, page); // ###

    function makeRequest(url, searchWord, category, page) {

        httpRequest.onreadystatechange = getResponse;
        httpRequest.open('GET', `${url}?searchWord=${searchWord}&category=${category}&page=${page}`);
        httpRequest.send();
    }

    function getResponse() {
        if (httpRequest.readyState === XMLHttpRequest.DONE) {
            if (httpRequest.status === 200) {
                let response = JSON.parse(httpRequest.responseText);

                console.log(response.computedString); //ajax 성공시 확인용

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
                else{ // 데이터가 있으면

                    notice.classList.replace('show','hide');
                    thead.classList.replace('hide','show');
                    pageGroup.style.visibility = 'visible';

                    response.forEach((item) => {

                        if(item.fileName === undefined) {
                            item.fileName = '';
                        }
                        if(item.ticketopenday === undefined) {
                            item.ticketopenday = '해당없음';
                        }

                        html += getBoardTemplate(item.notice_id, item.category, item.subject, item.ticketopenday, item.readCount ,item.fileName);
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

    let startPage = page-(page-1) % 10;
    let lastPage = Math.ceil(Number(recodes)/10);

    let prevGroup = pageGroup.querySelector('.prev-group');
    let pageList = pageGroup.querySelector('.page-list');
    let nextGroup = pageGroup.querySelector('.next-group');

    let prevHtml = '';
    let html = '';
    let nextHtml = '';

    if(startPage-1 >= 1){
        let prevPage = startPage-1;
        prevHtml += `<span role="button" onclick="ajaxBoard(${prevPage})">이전</span>`;
    }
    else{
        prevHtml += `<span class="no-click">이전</span>`; // 앞으로 갈 페이지가 없을 때
    }
    prevGroup.innerHTML = prevHtml;

    for(let i=0; i<10; i++){

        let eachPage = startPage + i;
        if(eachPage <= lastPage){

            if(page == eachPage){ // 선택된 페이지에 selected class 추가
                html += `<button type="button" class="page-button selected" aria-label="Go to page${eachPage}">${eachPage}</button>`
            }
            else{
                html += `<button type="button" class="page-button" aria-label="Go to page${eachPage}">${eachPage}</button>`
            }
        }
    }
    pageList.innerHTML = html;

    if(startPage+9 < lastPage){
        let nextPage = startPage+10;
        nextHtml += `<span role="button" onclick="ajaxBoard(${nextPage})">다음</span>`;
    }
    else{
        nextHtml += `<span class="no-click">다음</span>`; // 뒤로 갈 페이지가 없을 때
    }
    nextGroup.innerHTML = nextHtml;

}

function getBoardTemplate(seq, category, title, date, view, file) {

    let template = `<div class="row">
                    <span class="table-category">
                        ${category}
                    </span>
                    <span class="table-title">
                        <a href="/finalproject4/noticeView.action?seq=${seq}">
                            ${title}
                        </a>
                    </span>
                    <span class="table-date">
                        ${date}
                    </span>
                    <span class="table-view">
                        ${view}
                    </span>
                    <span class="table-file">
                        ${file}
                    </span>
                </div>`;

    return template;
}