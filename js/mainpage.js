document.addEventListener('DOMContentLoaded', () => {

    styleRanking();

});

function styleRanking() {

    let rankingGroup = document.querySelector('.ranking-item-group');
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

    
}