window.addEventListener('DOMContentLoaded', () => {

    let subCategoryButton = document.querySelector('.sub-category > button');
    subCategoryButton.addEventListener('click', (event) => {

        let box = document.querySelector('.sub-category-box');
        let icon = document.querySelector('.sub-category .button-icon');
        icon.style.transform = 'rotate(180deg)';

        if(box.classList.contains('show')){

            console.log(icon);

            box.style.display = 'none';
            box.classList.replace('show','hide');
            icon.style.transform = 'rotate(0)';
        }
        else{
            box.style.display = 'flex';
            box.classList.replace('hide','show');
            icon.style.transform = 'rotate(180deg)';

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
