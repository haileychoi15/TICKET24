window.addEventListener('DOMContentLoaded', () => {

    styleRanking();
    styleCategory();

});

function styleRanking() {

    let rankingGroup = document.querySelector('.ranking-item-group');

    // 제목이 길면 잘라서 보여주기

    // item hover 시 자세한 내용 보여주기
    rankingGroup.addEventListener('mouseover', (event) => {

        let target = event.target;
        if(target.tagName === 'LI') {

            let selectedRanking = target.querySelector('.ranking-item-ranking').innerText;

            let list = rankingGroup.querySelectorAll('.ranking-item');
            list.forEach((item) => {

                let ranking = item.querySelector('.ranking-item-ranking').innerText;
                if(ranking === selectedRanking){
                    item.classList.add('on');
                }
                else{
                    item.classList.remove('on');
                }
            });
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
                    headerMenu.style.paddingBottom = '75px';
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
            currentTarget.style.paddingBottom = '35px';

        });

    });

    headerCategory.addEventListener('click', (event) => {

        let ul = event.currentTarget;
        let list = ul.querySelectorAll('.header-category-item');
        console.log('list', list);

        list.forEach((item) => {
            item.classList.remove('active');
        });

        let target = event.target;
        let parent = target.closest('.header-category-item');
        parent.classList.add('active');

    });


}