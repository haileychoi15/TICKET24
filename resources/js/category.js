window.addEventListener('DOMContentLoaded', () => {

    // 카테고리 박스 눌렀을 때 이벤트
    let subCategoryButton = document.querySelector('.category-box-button');
    subCategoryButton.addEventListener('click', (event) => {

        let box = document.querySelector('.sub-category-box');

        if(box.classList.contains('show')){

            box.style.display = 'none';
            box.classList.replace('show','hide');
            event.currentTarget.classList.remove('on'); // 클릭 화살표 방향 바꾸기
        }
        else{
            box.style.display = 'flex';
            box.classList.replace('hide','show');
            event.currentTarget.classList.add('on'); // 클릭 화살표 방향 바꾸기
        }

    });


    // 박스안에 서브 카테고리 눌렀을 때 이벤트
    let box = document.querySelector('.sub-category-box'); // 위에도 있음
    box.addEventListener('click', (event) => {

        let target = event.target;
        if(target.nodeName === 'P'){ // 버튼 역할하는 태그

            console.log(target);

            let subCategory = document.querySelector('.category-box-button > button');
            console.log(target.innerText, subCategory.innerText);
            subCategory.innerText = target.innerText;
        }


    });


    // 오더 버튼 누를 때 이벤트 발생
    let orderGroup = document.querySelector('.order-group');
    orderGroup.addEventListener('click', (event) => {

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


});

function getProductTemplate() {

}

function ajaxProduct() {

    let subCategory = document.querySelector('.sub-category-title').value;
    let order = document.querySelector('.order-group button.selected').value;

    let httpRequest = new XMLHttpRequest();
    makeRequest('/finalproject4/category.action', subCategory, order);

    function makeRequest(url, subCategory, order) {

        httpRequest.onreadystatechange = getResponse;
        httpRequest.open('POST', url);
        httpRequest.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        httpRequest.send('category=' + encodeURIComponent(subCategory) + '&searchWord=' + encodeURIComponent(order));
    }

    function getResponse() {
        if (httpRequest.readyState === XMLHttpRequest.DONE) {
            if (httpRequest.status === 200) {
                let response = JSON.parse(httpRequest.responseText);
                alert(response.computedString);

                //ajax 성공시 코드

                let html = '';
                response.forEach((item) => {

                    html += getProductTemplate(item.title, item.image, item.content);
                });

                let tbody = document.querySelector('.product-group');
                tbody.innerHTML = html;


            } else {
                alert('There was a problem with the request.');
            }
        }

    }

}
