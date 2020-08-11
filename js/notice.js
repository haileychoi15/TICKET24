window.addEventListener('DOMContentLoaded', () => {

    ajaxBoard(1);

    let searchButton = document.querySelector('.search-button');
    searchButton.addEventListener('click',() => {

        setFirstPage();
        ajaxBoard(1);
    });

    let pageGroup = document.querySelector('.page-group');
    pageGroup.addEventListener('click', (event) => {

        let target = event.target;
        if(target.nodeName === 'BUTTON'){

            let page = target.innerText;
            ajaxBoard(page);
            removePageColor();
            target.classList.add('selected');
        }
    });

});

function enterSearchButton() {

    if(window.event.keyCode == 13) {
        ajaxBoard(1);
        setFirstPage();
    }
}

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
                        <a href="#${id}">
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

    let searchWord = document.querySelector('.search-word').value.trim();
    console.log("searchWord : ",searchWord, ", page : ",page); //확인용

    let httpRequest = new XMLHttpRequest();
    /*makeRequest('/finalproject4/notice.action',searchWord);

    function makeRequest(url, searchWord) {

        httpRequest.onreadystatechange = getResponse;
        httpRequest.open('POST', url);
        httpRequest.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        httpRequest.send('category=' + encodeURIComponent(searchWord)+'?page=' + encodeURIComponent(page));
    }

    function getResponse() {
        if (httpRequest.readyState === XMLHttpRequest.DONE) {
            if (httpRequest.status === 200) {
                let response = JSON.parse(httpRequest.responseText);

                console.log(response.computedString);

                //ajax 성공시 코드
                let html = '';
                response.forEach((item) => {

                    html += getBoardTemplate(item.id, item.category, item.subject, item.regDate, item.readCount ,item.fileName);
                });

                let tbody = document.querySelector('.qna .table .tbody');
                tbody.innerHTML = html;


            } else {
                alert('There was a problem with the request.');
            }
        }
    }*/
}
