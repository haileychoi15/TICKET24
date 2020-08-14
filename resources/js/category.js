window.addEventListener('DOMContentLoaded', (event) => {

    ajaxProduct(event.currentTarget);

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
        if(target.nodeName === 'BUTTON'){

            let subCategory = document.querySelector('.category-box-button > button');
            subCategory.innerText = target.innerText;
            subCategory.value = target.value;

            ajaxProduct(event.currentTarget);
        }
    });

    // 오더 버튼 누를 때 이벤트
    let orderGroup = document.querySelector('.order-group');
    orderGroup.addEventListener('click', (event) => {

        let target = event.target;
        if(target.nodeName == 'BUTTON'){

            // 색깔 변경
            let buttons = event.currentTarget.querySelectorAll('button');
            buttons.forEach((value) => {
                value.classList.remove('selected');
            });
            target.classList.add('selected');

            ajaxProduct(event.currentTarget);
        }
    });

    // 더보기 버튼 눌렀을 때 이벤트
    let moreButton = document.querySelector('.more-button');
    moreButton.addEventListener('click', (event) => {

        ajaxProduct(event.currentTarget);
    });

});

function getCategoryId(category) {

    switch (category) {
        case '콘서트':
            category = 1;
            break;
        case '뮤지컬':
            category = 2;
            break;
        case '연극':
            category = 3;
            break;
        case '클래식':
            category = 4;
            break;
        case '전시':
            category = 5;
            break;
        case '아동':
            category = 6;
            break;
    }
    return category;
}

function getProdTemplate(id, title, img, place) {

    // #### 주소 바꾸기 ####
    let template = `<li class="card">
                        <a href="<%=ctxPath%>/?prodId=${id}"> 
                            <div class="card-image common-image">
                                <img src="${img}" alt="${title}" />
                            </div>
                            <div class="card-desc">
                                <h3 class="card-title common-title">${title}</h3>
                                <strong class="card-content common-content">${place}</strong>
                            </div>
                        </a>
                    </li>`;
    return template;
}

function ajaxProduct(target) {

    let category = document.querySelector('.main-category').innerText;
    category = getCategoryId(category); // 메인 카테고리를 id 값으로 바꿔주기
    let subCategory = document.querySelector('.sub-category-title').value;
    let order = document.querySelector('.order-group button.selected').value;

    console.log('메인 카테고리 : ',category);
    console.log('서브 카테고리 : ',subCategory);
    console.log('정렬 순서 : ',order);

    //let httpRequest = new XMLHttpRequest();
    //makeRequest('/category', category, subCategory, order); // ####

    function makeRequest(url, category, subCategory, order) {

        httpRequest.onreadystatechange = getResponse;
        httpRequest.open('GET', `${url}?category=${category}&subCategory=${subCategory}&order=${order}`);
        httpRequest.send();
    }

    function getResponse() {
        if (httpRequest.readyState === XMLHttpRequest.DONE) {
            if (httpRequest.status === 200) {
                let response = JSON.parse(httpRequest.responseText);

                console.log(response.computedString);
                //ajax 성공시 코드

                let html = '';
                response.forEach((item, index) => {

                    if(index%4 === 0){ // 0 번째
                        html += '<div class="row">';
                    }

                    if(index%2 === 0){ // index가 짝수일 때
                        html += `<div class="col12 col-md-6">
                                 <ul class="card-list list-group">`;
                    }

                    html += getProdTemplate(item.prodId, item.prodTitle, item.prodImg, item.infoPlace);

                    if(index%2 === 1){ // index가 홀수일 때
                        html += `</ul>
                                 </div>`;
                    }

                    if(index%4 === 3){
                        html += `</div>`;
                    }
                });

                let prodGroup = document.querySelector('.product-group');
                if(!target.classList.contains('more-button')){ // 더보기 버튼 누른 것이 아니라면 상품리스트 비우기
                    prodGroup.innerHTML = '';
                }
                prodGroup.insertAdjacentHTML('beforeend', html);

            } else {
                alert('There was a problem with the request.');
            }
        }

    }
}
