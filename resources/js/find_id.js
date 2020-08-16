window.addEventListener('DOMContentLoaded', () => {

    let okButton = document.querySelector('.ok-button');
    okButton.addEventListener('click', validateInput());

});

function validateInput() {

    let name = document.querySelector('#name');
    let mobile = document.querySelector('#mobile');

    if(name.value.trim() === ''){
        
    }

}