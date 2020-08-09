window.addEventListener('DOMContentLoaded', () => {

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

    // 카테고리 누를 때 이벤트 발생
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
