window.addEventListener('DOMContentLoaded', () => {

    let returnTopButton = document.querySelector('.return-top-button');
    returnTopButton.addEventListener('click', () => {

        window.scrollTo({top:0, left:0, behavior:'smooth'});
    });

});