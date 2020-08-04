window.addEventListener('DOMContentLoaded', () => {

    styleRanking();
    styleCategory();
    slidePromotion();

    let returnTopButton = document.querySelector('.return-top-button');
    returnTopButton.addEventListener('click', () => {

        window.scrollTo({top:0, left:0, behavior:'smooth'});
    });

});

function slidePromotion() {

    let promotionGroup = document.querySelector('.promotion-group');
    let promotionItem = promotionGroup.querySelectorAll('.promotion-item');

    let totalQty = promotionItem.length;
    let cloneQty = 3;

    // 화면에 직접적으로 보이는 아이템 개수만큼 클론노드 만들기
    for(let i=0; i<cloneQty; i++){
        let itemClone = promotionItem[i].cloneNode(true);
        promotionGroup.insertAdjacentElement('beforeend', itemClone);
    }

    // 아이템 하나의 너비를 얻어 와서 아이템 그룹의 너비를 만들기
    let itemStyle = window.getComputedStyle(promotionItem[0]);
    let width = Number(itemStyle.width.replace("px",""));
    let marginLeft = Number(itemStyle.marginLeft.replace("px",""));
    let marginRight = Number(itemStyle.marginRight.replace("px",""));

    width = width + marginLeft + marginRight;
    promotionGroup.style.width = (width * (totalQty + cloneQty)) + 'px';

    let count = 0;
    setInterval(() => {

        count++;
        promotionGroup.style.transition = 'transform 250ms ease-in-out';
        promotionGroup.style.transform = 'translate3d(-'+ (width * count) +'px, 0px, 0px)';

        if(count === totalQty){
            setTimeout(() => {

                promotionGroup.style.transition = '0ms';
                promotionGroup.style.transform = 'translate3d(0px, 0px, 0px)';

            },251);
            count = 0;
        }
    },5000);
}

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