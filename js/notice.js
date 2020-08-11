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

            let category = target.value;
            console.log(category);

            //ajax
            //ajaxBoard(category);

            // 색깔 변경
            console.log(target,event.currentTarget );
            let buttons = event.currentTarget.querySelectorAll('button');
            buttons.forEach((value) => {
                value.classList.remove('selected');
            });

            target.classList.add('selected');
        }

    });

/*    searchButton.addEventListener('keydown',(event) => {

        const keyCode = event.keyCode;
        console.log('pushed key : ',event.keyCode);

        if(keyCode == 13){
            setFirstPage();
            ajaxBoard(1);
        }
    });*/

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
    makeRequest('/finalproject4/notice.action',searchWord);

    function makeRequest(url, searchWord) {

        httpRequest.onreadystatechange = getResponse;
        httpRequest.open('GET', url+"?searchWord="+ encodeURIComponent(searchWord)+'&page=' + encodeURIComponent(page));
        //   httpRequest.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        //   httpRequest.send('searchWord=' + encodeURIComponent(searchWord)+'&page=' + encodeURIComponent(page));
        httpRequest.send();
    }

    function getResponse() {
        if (httpRequest.readyState === XMLHttpRequest.DONE) {
            if (httpRequest.status === 200) {
                let response = JSON.parse(httpRequest.responseText);

                console.log(response.computedString);

                //ajax 성공시 코드
                let html = '';
                let totalPage = 0;
                response.forEach((item) => {

                    if(item.fileName === undefined){
                        item.fileName = '';
                    }

                    html += getBoardTemplate(item.id, item.category, item.subject, item.regDate, item.readCount ,item.fileName);
                    totalPage = item.totalPage;

                    let pageList = '';
                    for(let i=0; i<totalPage; i++){

                        if(i==0){
                            pageList += '<span onclick="ajaxBoard('+(page-1)+')">&lt;</span>';
                        }

                        if((i+1) == page){
                            pageList += '<button type="button" class="page-button selected" aria-label="Go to page1">'+(i+1)+'</button>';
                        }
                        else{
                            pageList += '<button type="button" class="page-button" aria-label="Go to page1">'+(i+1)+'</button>';
                        }

                        if((i+1)==totalPage){
                            pageList += '<span onclick="ajaxBoard('+(page+1)+')">></span>';
                        }
                    }

                    document.querySelector('.page-group').innerHTML = pageList;

                    let tbody = document.querySelector('.qna .table .tbody');
                    tbody.innerHTML = html;


                });


            } else {
                alert('There was a problem with the request.');
            }
        }
    }
}