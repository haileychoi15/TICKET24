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


});
