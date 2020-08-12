window.addEventListener('DOMContentLoaded', () => {

    ajaxBoard(1);

    let searchButton = document.querySelector('.search-button');
    searchButton.addEventListener('click',() => {

        setFirstPage();
        ajaxBoard(1);
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
    document.querySelector('.page-button:first-child').classList.add('selected');
}

function getBoardTemplate(id, category, title, date, view, file) {

    let template = `<div class="row">
                    <span class="table-category">
                        ${category}
                    </span>
                    <span class="table-title">
                        <a href="/finalproject4/noticeView.action?seq=${id}">
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

function ajaxBoard(page) {

    let category = document.querySelector('.category-group .selected').value;
    let searchWord = document.querySelector('.search-word').value.trim();
    if(searchWord === null) {
        searchWord = '';
    }
    console.log("searchWord : ",searchWord, ", page : ",page, ", category : ",category); //확인용

    let httpRequest = new XMLHttpRequest();
    makeRequest('/finalproject4/notice.action', searchWord, page); // 바꿈

    function makeRequest(url, searchWord, page) {

        httpRequest.onreadystatechange = getResponse;
        httpRequest.open('GET', `${url}?searchWord=${searchWord}&page=${page}`);
        httpRequest.send();
    }

    function getResponse() {
        if (httpRequest.readyState === XMLHttpRequest.DONE) {
            if (httpRequest.status === 200) {
                let response = JSON.parse(httpRequest.responseText);

                console.log(response.computedString);

                //ajax 성공시 코드
                let html = '';
                let recodes = 0;
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

                setPageList(page, recodes); // 페이징 처리

                let tbody = document.querySelector('.qna .table .tbody');
                tbody.innerHTML = html;


            } else {
                alert('There was a problem with the request.');
            }
        }
    }
}

function setPageList(page, recodes) { // 현재 누른 페이지, 총 레코드 수

    let startPage = page-(page-1) % 10;
    let lastPage = Math.ceil(Number(recodes)/10);

    let prevGroups = document.querySelectorAll('.prev-group');
    let pageList = document.querySelector('.page-list');

    let prevHtml = '';
    if(startPage-1 >= 1){

        let prevPage = startPage-1;
        prevHtml += `<span role="button" onclick="ajaxBoard(${prevPage})">이전</span>`;
    }
    else{
        prevHtml += `<span class="no-click">이전</span>`; // 앞으로 갈 페이지가 없을 때
    }

    prevGroups[0].innerHTML = prevHtml; // insertAdjacentElement인가..


    let html = '';
    for(let i=0; i<10; i++){

        let eachPage = startPage + i;

        if(eachPage <= lastPage){

            if(page == eachPage){
                html += `<button type="button" class="page-button selected" aria-label="Go to page${eachPage}">${eachPage}</button>`
            }
            else{
                html += `<button type="button" class="page-button" aria-label="Go to page${eachPage}">${eachPage}</button>`
            }
        }
    }

    pageList.innerHTML = html;


    let nextHtml = '';
    if(startPage+9 < lastPage){

        let nextPage = startPage+10;
        nextHtml += `<span role="button" onclick="ajaxBoard(${nextPage})">다음</span>`;
    }
    else{
        nextHtml += `<span class="no-click">다음</span>`;
    }

    prevGroups[1].innerHTML = nextHtml;

}