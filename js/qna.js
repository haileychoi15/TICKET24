window.addEventListener('DOMContentLoaded', () => {

    let tbody = document.querySelector('.tbody');
    tbody.addEventListener('click', (event) => {

        let target = event.target;
        showContent(target);

    });


    let qnaButton = document.querySelector('.qna-button');
    let modal = document.querySelector('.modal');
    qnaButton.addEventListener('click',(event) => {

        modal.style.display = 'flex';
    });

    let closeButton = modal.querySelector('.close-button');
    closeButton.addEventListener('click',() => {

        modal.style.display = 'none';
    });


});

function showContent(target) {

    if(target.classList.contains('table-title')){

        console.log('title');
        let row = target.closest('.row');

        console.log('row', row);

        if(row.classList.contains('on')){
            row.classList.remove('on');
        }
        else{
            row.classList.add('on');
        }

    }

}