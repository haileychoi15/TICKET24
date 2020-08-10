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

            let subCategory = document.querySelector('.category-box-button > span');
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
