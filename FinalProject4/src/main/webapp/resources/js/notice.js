window.addEventListener('DOMContentLoaded', () => {

    ajaxBoard('');

    let tbody = document.querySelector('.tbody');
    tbody.addEventListener('click', (event) => {

        let target = event.target;
        showContent(target);

    });


});

function ajaxBoard(searchWord) {

    searchWord = document.querySelector('.search-word').value.trim();

    let httpRequest = new XMLHttpRequest();
    makeRequest('/finalproject4/notice.action',searchWord);

    function makeRequest(url, searchWord) {

        httpRequest.onreadystatechange = getResponse;
        httpRequest.open('POST', url);
        httpRequest.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        httpRequest.send('category=' + encodeURIComponent(searchWord));
    }

    function getResponse() {
        if (httpRequest.readyState === XMLHttpRequest.DONE) {
            if (httpRequest.status === 200) {
                let response = JSON.parse(httpRequest.responseText);

                console.log(response.computedString);

                //ajax 성공시 코드
                let html = '';
                response.forEach((item) => {

                    html += getBoardTemplate(item.subject, item.date, item.regDate);
                });

                let tbody = document.querySelector('.qna .table .tbody');
                tbody.innerHTML = html;


            } else {
                alert('There was a problem with the request.');
            }
        }
    }
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