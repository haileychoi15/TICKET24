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
    let list = headerCategory.querySelectorAll('.header-category-item');
    // list 같이 쓰려고 위로 올림
    headerCategory.addEventListener('mouseover', (event) => {

        let target = event.target;
        if(target.tagName === 'LI') {

            let selectedCategory = target.querySelector('.header-category-item > a').innerText;
            console.log('selectedCategory', selectedCategory);

            //let list = document.querySelectorAll('.header-category-item');
            list.forEach((item) => {

                let category = item.querySelector('a').innerText;
                console.log('a tag category name : ',category);

                if(category === selectedCategory){
                    item.classList.add('active');
                    headerMenu.style.paddingBottom = '71px';
                }
                else{
                    item.classList.remove('active');
                }

            });
        }
    });

    headerMenu.addEventListener('mouseleave', (event) => {

        let currentTarget = event.currentTarget;
        list.forEach((item) => {
            item.classList.remove('active');
            currentTarget.style.paddingBottom = '31px';

        });

    });

}