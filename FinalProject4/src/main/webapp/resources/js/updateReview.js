window.addEventListener('DOMContentLoaded',()=>{
    
//showRevision();
//closeRevision();
starRate();

});

/*
//수정하기 버튼 누르면  창 나타나게
//버튼 이름 변경하여 사용
//css에 .hide{display:none;}/.show{display:flex}
const showRevision=()=>{
    const revisionButton=document.querySelector(".revisionButton");
    const revision=document.querySelector(".revision");
    revisionButton.addEventListener("click",()=>{
        revision.classList.remove("hide");
        revision.classList.add("show");
    });

}
*/

//수정 닫기 버튼
/*
const closeRevision=()=>{
    //닫기 버튼 받아오기
    const closeButton=document.querySelector(".close-button");
    const revision=document.querySelector(".revision");
    closeButton.addEventListener("click",()=>{
        revision.classList.remove("show");
        revision.classList.add("hide");
    })
}
*/

//별점 주기(클릭 시 별이 채워지고, value값이 input hidden에 부여된다.)


const starRate=()=> {

    const star = document.querySelector("#re-star");
    star.value = 5; //5점 부여

    const stars = document.querySelectorAll(".re-starlist i");
    console.log(stars);

    stars.forEach(item=>{item.classList.add("staron")
    });//초기 모든 별 꽉차게

    //css에 추가하기
    //.staron{
    //     color:#ec7d2c;
    // }


    stars[0].addEventListener("click",()=>{
        stars.forEach(item=>{
            item.classList.remove("staron")
        });//모든 별 색 없어지게

        for(i=0;i<1;i++){
            stars[i].classList.add("staron");
        }
        star.value = 1; //1점 부여
        console.log(star.value);

    });

    stars[1].addEventListener("click",()=>{
        stars.forEach(item=>{
            item.classList.remove("staron")
        });//모든 별 색 없어지게

        for(i=0;i<2;i++){
            stars[i].classList.add("staron");
        }
        star.value = 2; //2점 부여
    });

    stars[2].addEventListener("click",()=>{
        stars.forEach(item=>{
            item.classList.remove("staron")
        });//모든 별 색 없어지게

        for(i=0;i<3;i++){
            stars[i].classList.add("staron");
        }

        star.value = 3; //3점 부여
    });

    stars[3].addEventListener("click",()=>{
        stars.forEach(item=>{
            item.classList.remove("staron")
        });//모든 별 색 없어지게

        for(i=0;i<4;i++){
            stars[i].classList.add("staron");
        }

        star.value = 4; //4점 부여
    });

    stars[4].addEventListener("click",()=>{
        stars.forEach(item=>{
            item.classList.remove("staron")
        });//모든 별 색 없어지게

        for(i=0;i<5;i++){
            stars[i].classList.add("staron");
        }
        star.value = 5; //5점 부여
    });
}