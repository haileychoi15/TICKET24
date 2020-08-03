window.resizeTo(850, 617);

window.onload = function () {

    // 상단 관람일/회차 변경
    let changeDate = document.getElementById('changeDate');
    let changeRound = document.getElementById('changeRound');

    changeDate.innerHTML += '<option>2020.08.22 토요일</option>';
    changeRound.innerHTML += '<option>[1회] 16시 00분</option>';

    // 숫자 형식
    function numberPad(n, width) {
        n = n + '';
        return n.length >= width ? n:new Array(width - n.length + 1).join('0') + n;
    }

    let seatArea = document.getElementById('seatArea');
    let eachSeat = document.getElementsByClassName('eachSeat');

    // 1층 1~9열
    for(var j=0; j<9; j++) {
        for(var i=0; i<37; i++) {
            var top = 204 + 12*j;
            if(i<8) {
                var left = 80 + 11*i;
                var area = "A";
                var no = i+1;
            }
            else if(i<29) {
                left = 188.5 + 11*(i-8);
                area = "B";
                no = (i+1) - 8;
            }
            else {
                left = 440 + 11*(i-29);
                area = "C";
                no = (i+1) - 29;
            }
            seatArea.innerHTML += "<div class='eachSeat' id='t"+numberPad(eachSeat.length+1, 3)+"' title='1층 "+area+"구역 0"+(j+1)+"열 0"+numberPad(no, 2)+"번' style='left: "+left+"px; top: "+top+"px'></div>";
        }
    }

    // 1층 10열
    for(var i=0; i<37; i++) {
        if(i<8) {
            left = 80 + 11*i;
            area = "A";
            no = i+1;
        }
        else if(i<11 || (i>25 && i<29)) {
            left = 188.5 + 11*(i-8);
            area = "B";
            no = (i+1) - 8;
        }
        else if(i>28) {
            left = 440 + 11*(i-29);
            area = "C";
            no = (i+1) - 29;
        }

        if(i<11 || i>25)
            seatArea.innerHTML += "<div class='eachSeat' id='t"+numberPad(eachSeat.length+1, 3)+"' title='1층 "+area+"구역 10열 0"+numberPad(no, 2)+"번' style='left: "+left+"px; top: 324px'></div>";
    }

    // 2층
    for(let y=0; y<6; y++) {
        for(let x=0; x<35; x++) {
            top = 389 + 12*y;
            if(x<10) {
                left = 91 + 11*x;
                area = "A";
                no = x+1;
            }
            else if(x<25) {
                left = 199 + 11*(x-8);
                area = "B";
                no = (x+1) - 10;
            }
            else {
                left = 384 + 11*(x-23);
                area = "C";
                no = (x+1) - 25;
            }
            seatArea.innerHTML += "<div class='eachSeat' id='t"+numberPad(eachSeat.length+1, 3)+"' title='2층 "+area+"구역 0"+(y+1)+"열 0"+numberPad(no, 2)+"번' style='left: "+left+"px; top: "+top+"px'></div>";
        }
    }

    // 공연 정보 불러오기
    let showName = document.getElementById('showName');
    let showLocation = document.getElementById('showLocation');
    let showGrade = document.getElementById('showGrade');
    let showTime = document.getElementById('showTime');
    showName.innerHTML = '뮤지컬 ＜오페라의 유령＞ 월드투어－대구 （The Phantom of the Opera)';
    showLocation.innerHTML = '인터파크홀';
    showGrade.innerHTML = '만 13세 이상';
    showTime.innerHTML = '120분';

    // 좌석 클릭 이벤트
    for(let i=0; i<eachSeat.length; i++) {
        eachSeat[i].addEventListener('click', function () {
            this.className === 'eachSeat'? this.className = 'selSeat' : this.className = 'eachSeat';

            let title = this.getAttribute('title');
            let selectedSeat = document.getElementById('selectedSeat');
            let pTagID = this.id;
            let pTag = document.getElementById('p'+pTagID);

            let seat = document.getElementById('seat');
            let spanTag = document.getElementById('span'+pTagID);

            if(this.className === 'eachSeat') {
                pTag.parentNode.removeChild(pTag);
                spanTag.parentNode.removeChild(spanTag);
            }
            else {
                selectedSeat.innerHTML += '<p id=p'+pTagID+'>'+title+'</p>';
                seat.innerHTML += '<span id=span'+pTagID+' style="display: block">'+title+'</span>'
            }
        });
    }

    // 예매 정보 출력 (side bar)
    let ticketPrice = document.getElementById('ticketPrice').innerText;
    let ticketCommission = document.getElementById('ticketCommission').innerText;
    let deliveryFee = document.getElementById('deliveryFee').innerText;
    let sum = Number(ticketPrice) + Number(ticketCommission) + Number(deliveryFee);

    let totalTicketPrice = document.getElementById('totalTicketPrice');
    totalTicketPrice.innerHTML = sum;

    let dcPrice = document.getElementById('dcPrice').innerText;
    let dcCoupon = document.getElementById('dcCoupon').innerText;
    let dcPoint = document.getElementById('dcPoint').innerText;
    let minus = Number(dcPrice) + Number(dcCoupon) + Number(dcPoint);

    let totalDiscount = document.getElementById('totalDiscount');
    totalDiscount.innerHTML = minus;

    let totalPrice = document.getElementById('totalPrice');
    totalPrice.innerHTML = sum - minus;

}

// 좌석 선택 리셋
function reset() {
    let selSeat = document.getElementsByClassName('selSeat');

    for(let i=0; i<selSeat.length; i++) {
        selSeat[i].className = 'eachSeat';
        i--;
    }
    let selectedSeat = document.getElementById('selectedSeat');
    selectedSeat.innerHTML = "";
}

// 좌석 선택 완료 여부
function seatSelComplete() {
    let seat = document.getElementById('step1');
    let sale = document.getElementById('step2');
    let sideBar = document.getElementById('bookingInfo');

    let selSeat = document.getElementsByClassName('selSeat');
    if(selSeat.length === 0)
        alert("좌석을 선택해주세요.");
    else {
        change(step2);
    }
}

// 화면 전환
function change(step) {
    let step1 = document.getElementById('step1');
    let step2 = document.getElementById('step2');
    let step3 = document.getElementById('step3');
    let step4 = document.getElementById('step4');
    let sideBar = document.getElementById('bookingInfo');

    let prevStep = document.getElementById('prevStep');
    let nextStep = document.getElementById('nextStep');

    if(step === step1) {
        step1.style.display = 'block';
        step2.style.display = 'none';
        step3.style.display = 'none';
        step4.style.display = 'none';
        sideBar.style.display = 'none';
    }
    else if(step === step2) {
        step1.style.display = 'none';
        step2.style.display = 'block';
        step3.style.display = 'none';
        step4.style.display = 'none';
        sideBar.style.display = 'block';

        let seat = document.getElementById('seat');
        let seatCount = seat.childElementCount;
        let ticketLength = document.getElementById('ticketLength');
        ticketLength.innerHTML = seatCount + "매";

        prevStep.setAttribute('onclick', 'change(step1)');
        nextStep.innerHTML = '다음 단계';
        nextStep.setAttribute('onclick', 'change(step3)');
    }
    else if(step === step3) {
        step1.style.display = 'none';
        step2.style.display = 'none';
        step3.style.display = 'block';
        step4.style.display = 'none';
        sideBar.style.display = 'block';

        prevStep.setAttribute('onclick', 'change(step2)');
        nextStep.innerHTML = '다음 단계';
        nextStep.setAttribute('onclick', 'change(step4)');
    }
    else if(step === step4) {
        step1.style.display = 'none';
        step2.style.display = 'none';
        step3.style.display = 'none';
        step4.style.display = 'block';
        sideBar.style.display = 'block';

        prevStep.setAttribute('onclick', 'change(step3)');
        nextStep.innerHTML = '결제하기';
        nextStep.setAttribute('onclick', 'payment()');
    }
}

// 수령 방법 선택 이벤트
function deliverySel() {
    let receive = document.getElementsByName('receive');
    let deliveryInfo = document.getElementById('deliveryInfo');
    let checkedReceive = null;
    for(let i=0; i<receive.length; i++) {
        if(receive[i].checked === true)
            checkedReceive = receive[i].value;
    }
    if(checkedReceive == '0')
        deliveryInfo.style.display = 'none';
    else if(checkedReceive == '1')
        deliveryInfo.style.display = 'block';
}

// 돈 콤마 찍기
function money(money) {
    return money.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function payment() {
    let confirm = document.getElementsByName('confirm');
    let check1 = false;
    let check2 = false;

    for(let i=0; i<confirm.length; i++) {
        if(confirm[0].checked)
            check1 = true;
        if(confirm[1].checked)
            check2 = true;
    }

    if(check1 && check2)
        alert('결제로 이동');
    else
        alert('취소 수수료/취소 기한 및 제 3자 정보 제공 내용에 동의하셔야만 \n결제가 가능합니다.');
}