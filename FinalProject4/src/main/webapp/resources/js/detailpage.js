window.addEventListener('DOMContentLoaded',()=>{

    addLikes();
    showShareBox();
    showcancel();
    registerReview();
    closeReview();
    starRate();
    /*showRevision();*/
    /*stargrades();*/
   /* closeRevision();*/
    bookingFetch();

    const returnTopButton=document.querySelector(".return-top-button");
    returnTopButton.addEventListener("click",()=>{
        window.scrollTo({top:0, right:0, behavior:'smooth'});
    });

});

//좋아요 버튼 (main, review 둘 다)
const addLikes=()=>{

    const noncoloredHeart=document.querySelectorAll(".noncolored-heart");
    const coloredHeart=document.querySelectorAll(".colored-heart");
    /*const likesNumber=document.querySelectorAll(".main-likes-number");*/

    coloredHeart.forEach(item=>{
        item.style.display="none";})

    for(i=0;i<noncoloredHeart.length;i++) {

        noncoloredHeart[i].addEventListener("click", (event) => {
            const target=event.target;

            target.style.display = "none";
            target.nextElementSibling.style.display="initial";
            const count=Number(target.nextElementSibling.nextElementSibling.textContent);

            //좋아요 수 증가
            target.nextElementSibling.nextElementSibling.textContent=String(count+1);

        });

        coloredHeart[i].addEventListener("click", (event) => {
            const target=event.target;
            target.style.display = "none";
            target.previousElementSibling.style.display="initial";
            const count=Number(target.nextElementSibling.textContent);

            //좋아요 수 감소
            target.nextElementSibling.textContent=String(count-1);

            /* coloredHeart[i].style.display = "initial";

             /!*누르면 숫자 +1*!/
             let count = Number(likesNumber[i].textContent);
             likesNumber[i].textContent = String(count + 1);
            */
        });
    }
    }


//공유 sns 채널 박스
const showShareBox=()=>{

    const sharebox=document.querySelector(".share-box");
    const shareButton=document.querySelector("#shareButton");
    const closeButton=document.querySelector("#close-button");

    shareButton.addEventListener("click",()=>{
        sharebox.classList.remove("share-box");
        sharebox.classList.add("show");
        shareButton.style.display="none";
    });

    closeButton.addEventListener("click",()=>{
        sharebox.classList.remove("show");
        sharebox.classList.add("share-box");
        shareButton.style.display="initial";
    });

}



//예매하기/booking 버튼 누르면 티켓예매 페이지로 이동




//예매/취소안내 이동시 보여질 section 고르기

const showcancel=()=> {

    const cancel = document.querySelector(".cancel");//버튼
    const info=document.querySelector(".info");
    const reviewbutton=document.querySelector(".post");
    //section nodes

    const review=document.querySelector(".review");
    const caution=document.querySelector(".caution");
    const detail=document.querySelector(".detail");
    const refund=document.querySelector(".refund");
    const map=document.querySelector(".map");
    const notice=document.querySelector(".notice");


    cancel.addEventListener("click", () => {

        notice.classList.remove("hide");
        caution.classList.add("hide");
        detail.classList.add("hide");
        refund.classList.add("hide");
        map.classList.add("hide");
        review.classList.add("hide");
        cancel.classList.add("on");
        info.classList.remove("on");
        reviewbutton.classList.remove("on");


    });

    info.addEventListener("click", () => {

        notice.classList.add("hide");
        caution.classList.remove("hide");
        detail.classList.remove("hide");
        refund.classList.remove("hide");
        map.classList.remove("hide");
        review.classList.remove("hide");

        info.classList.add("on");
        cancel.classList.remove("on");
        reviewbutton.classList.remove("on");

    });

    reviewbutton.addEventListener("click", () => {

        notice.classList.add("hide");
        caution.classList.remove("hide");
        detail.classList.remove("hide");
        refund.classList.remove("hide");
        map.classList.remove("hide");
        review.classList.remove("hide");

        reviewbutton.classList.add("on");
        info.classList.remove("on");
        cancel.classList.remove("on");

    });


}


//리뷰작성 버튼 클릭 시 페이지 보이게

const registerReview=()=>{
    const reviewOkButton=document.querySelector(".review-ok-button");
    const fk_userid=document.querySelector("#fk_userid");
    
    const modal=document.querySelector(".modal");
    reviewOkButton.addEventListener("click",()=>{

        if(fk_userid.value === ''){
            alert("먼저 로그인이 필요합니다.");
            return;
        }
    	
        modal.classList.remove("hide");
        modal.classList.add("show");
    });
}



//닫기버튼

const closeReview=()=>{
    const closeButton=document.querySelector(".close-button");
    const modal=document.querySelector(".modal");
    closeButton.addEventListener("click",()=>{
        modal.classList.remove("show");
        modal.classList.add("hide");
    })

}

//리뷰 작성 시 별점주기

    // 초기 별점셋팅
const starRate=()=> {

    const star = document.querySelector("#star");
    star.value = 5; //5점 부여

    const stars = document.querySelectorAll(".starlist i");
    console.log(stars);

    stars.forEach(item=>{item.classList.add("staron")
    });//초기 모든 별 꽉차게

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


const bookingFetch=()=>{

	const button = document.querySelector(".booking-button");
	const showdate=document.querySelector("#showdate");
	const showtime=document.querySelector("#showtime");

	button.addEventListener("click", () => {
	       fetch('finalproject4/reservePopUp.action', {
	        method: "POST",
	        headers: {
	            "Content-Type": "application/json"
	        },
	        body: JSON.stringify({
	            date:showdate,
	            time:showtime
	        })
	    })
	        .then(response => response.json())
	           .then(data=>console.log(data))
	           .catch(error=>console.log('ERROR'))
	    });


	}







//별점 보여주기
//여러 개로 불러오면 어떡 하나...?

/*const stargrades=()=>{

    //리뷰 작성 시 주었던 hidden input의 value 별점 불러오기
    const rate = document.querySelector("#star").value;
    const stars=document.querySelectorAll(".reviewstar");

    for(i=0;i<rate;i++){
        stars[i].classList.add("staron");
    }

}*/


//수정 버튼 누를 때 페이지

/*
const showRevision=()=>{
    const revisionbutton=document.querySelectorAll(".revisionButton");
    const modal=document.querySelector(".modal");
    const reviewcomment=document.querySelectorAll(".review-comment-desc p");



    for(i=0;i<revisionbutton.length;i++) {
        revisionbutton[i].addEventListener("click", () => {
            //리뷰작성 페이지와 같은 페이지가 나타남.
            modal.classList.remove("hide");
            modal.classList.add("show");
            console.log(reviewcomment[i].textContent);
        });
    }
}

//수정 닫기 버튼

const closeRevision=()=>{
    const closeButton=document.querySelector(".close-revision-button");
    const modal=document.querySelector(".revision");
    closeButton.addEventListener("click",()=>{
        modal.classList.remove("show");
        modal.classList.add("hide");
    })

}
*/




