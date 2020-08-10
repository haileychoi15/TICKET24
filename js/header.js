window.addEventListener('DOMContentLoaded', () => {

    styleCategory();
    styleUserBox();

});

function styleUserBox() {

    let userButton = document.querySelector('.user-button');
    userButton.addEventListener('click',(event) => {

        let userBox = event.currentTarget.querySelector('.user-box');

        if(userBox.classList.contains('hide')){

            userBox.style.display = 'flex';
            userBox.classList.replace('hide','show');
        }
        else{
            userBox.style.display = 'none';
            userBox.classList.replace('show','hide');
        }

    });
}

function styleCategory() {

    // 카테고리 hover 할 때 sub-category 보여주기
    let headerMenu = document.querySelector('.header-menu');
    let headerCategory = headerMenu.querySelector('.header-category');
    let list = headerCategory.querySelectorAll('.header-category-item > a');
    // list 같이 쓰려고 위로 올림
    headerCategory.addEventListener('mouseover', (event) => {

        event.stopPropagation();
        let target = event.target;

        let selectedCategory = target.innerText;

        if(target.className == 'category-link') {

            list.forEach((item) => {

                let category = item.innerText;
                let parent = item.closest('.header-category-item');

                if (category === selectedCategory) {
                    parent.classList.add('on');

                    let body = document.querySelector('body');
                    let width = Number(window.getComputedStyle(body).width.replace("px",""));

                    if(width >= 768){ // 데스크탑 버전
                        headerMenu.style.paddingBottom = '75px';
                    }
                    else{ // 모바일 버전
                        headerMenu.style.paddingBottom = '100px';
                    }
                } else {
                    parent.classList.remove('on');
                }
            });
        }
    });


    headerMenu.addEventListener('mouseleave', (event) => {

        let currentTarget = event.currentTarget;
        list.forEach((item) => {

            let parent = item.closest('.header-category-item');
            parent.classList.remove('on');

            let body = document.querySelector('body');
            let width = Number(window.getComputedStyle(body).width.replace("px",""));

            if(width >= 768){ // 데스크탑 버전
                currentTarget.style.paddingBottom = '35px';
            }
            else{ // 모바일 버전
                currentTarget.style.paddingBottom = '0';
            }

        });

    });

    headerCategory.addEventListener('click', (event) => {

        let ul = event.currentTarget;
        let list = ul.querySelectorAll('.header-category-item');

        // 뮤지컬 카테고리 클릭 했을 때만 musicalOnly 나타나게 하기
        let musicalOnly = document.querySelector('.musical-only');

        list.forEach((item) => {
            item.classList.remove('active');
            musicalOnly.style.display = 'none';
        });

        let target = event.target;
        let parent = target.closest('.header-category-item');
        parent.classList.add('active');

        if(target.innerText === '뮤지컬'){
            musicalOnly.style.display = 'flex';
        }

    });


}