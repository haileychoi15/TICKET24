<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript" src="<%= request.getContextPath()%>/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
window.resizeTo(850, 617);

$(document).ready(function(){
    // 상단 관람일/회차 변경
    let changeDate = document.getElementById('changeDate');
    let changeRound = document.getElementById('changeRound');

    <c:forEach var="item" items="${getShowDay}">
    	changeDate.innerHTML += '<option>${item}</option>';
    </c:forEach>
    
    $("#changeDate").change(function(){
    	var round = $(this).val();
    	changeRound.innerHTML = '';
    	changeRound.innerHTML += '<option>회차 선택</option>';
    	roundChange(round);
    });
    
    $("#changeRound").change(function(){
    	var showDate = $("#changeDate").val();
    	var round = $(this).val();
    	console.log(showDate + "일자선택한값");
    	console.log(round + "회차선택한값");
    });
    
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
            var top = 162 + 12*j;
            if(i<8) {
                var left = 71 + 11*i;
                var area = "A";
                var no = i+1;
            }
            else if(i<29) {
                left = 180 + 11*(i-8);
                area = "B";
                no = (i+1) - 8;
            }
            else {
                left = 433 + 11*(i-29);
                area = "C";
                no = (i+1) - 29;
            }
            seatArea.innerHTML += "<div class='eachSeat' id='t"+numberPad(eachSeat.length+1, 3)+"' title='1층 "+area+"구역 0"+(j+1)+"열 0"+numberPad(no, 2)+"번' style='left: "+left+"px; top: "+top+"px'></div>";
        }
    }

    // 1층 10열
    for(var i=0; i<37; i++) {
        if(i<8) {
            left = 71 + 11*i;
            area = "A";
            no = i+1;
        }
        else if( i<11 || (i>25 && i<29) ) {
            left = 180 + 11*(i-8);
            area = "B";
            no = (i+1) - 8;
        }
        else if(i>28) {
            left = 433 + 11*(i-29);
            area = "C";
            no = (i+1) - 29;
        }

        if(i<11 || i>25)
            seatArea.innerHTML += "<div class='eachSeat' id='t"+numberPad(eachSeat.length+1, 3)+"' title='1층 "+area+"구역 10열 0"+numberPad(no, 2)+"번' style='left: "+left+"px; top: 281px'></div>";
    }

    // 2층
    for(let y=0; y<6; y++) {
        for(let x=0; x<35; x++) {
            top = 346 + 12*y;
            if(x<10) {
                left = 83 + 11*x;
                area = "A";
                no = x+1;
            }
            else if(x<25) {
                left = 191 + 11*(x-8);
                area = "B";
                no = (x+1) - 10;
            }
            else {
                left = 376 + 11*(x-23);
                area = "C";
                no = (x+1) - 25;
            }
            seatArea.innerHTML += "<div class='eachSeat' id='t"+numberPad(eachSeat.length+1, 3)+"' title='2층 "+area+"구역 0"+(y+1)+"열 0"+numberPad(no, 2)+"번' style='left: "+left+"px; top: "+top+"px'></div>";
        }
    }

    // 공연 정보 불러오기
    let showName = document.getElementsByClassName('showName');
    let showLocation = document.getElementById('showLocation');
    let showGrade = document.getElementById('showGrade');
    let showTime = document.getElementById('showTime');

    for(let i=0; i<showName.length; i++) {
        showName[i].innerHTML = '${getShowRsvInfo.prod_title}';
    }
    showLocation.innerHTML = '${getShowRsvInfo.map_name}';
    showGrade.innerHTML = '만 ' + '${getShowRsvInfo.info_grade}';
    showTime.innerHTML = '${getShowRsvInfo.info_run_time}';

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

});

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
    let fromStep2 = document.getElementById('fromStep2');
    let step2 = document.getElementById('step2');
    let step3 = document.getElementById('step3');
    let step4 = document.getElementById('step4');
    let sideBar = document.getElementById('sideBar');

    let prevStep = document.getElementById('prevStep');
    let nextStep = document.getElementById('nextStep');

    if(step === step1) {
        step1.style.display = 'block';
        fromStep2.style.display = 'none';
        step2.style.display = 'none';
        step3.style.display = 'none';
        step4.style.display = 'none';
        sideBar.style.display = 'none';
    }
    else if(step === step2) {
        step1.style.display = 'none';
        fromStep2.style.display = 'block';
        step2.style.display = 'block';
        step3.style.display = 'none';
        step4.style.display = 'none';
        sideBar.style.display = 'block';

        let seat = document.getElementById('seat');
        let seatCount = seat.childElementCount;
        let ticketLength = document.getElementById('ticketLength');
        ticketLength.innerHTML = seatCount;

        prevStep.setAttribute('onclick', 'change(step1)');
        nextStep.innerHTML = '다음 단계';
        nextStep.setAttribute('onclick', 'change(step3)');
    }
    else if(step === step3) {
        step1.style.display = 'none';
        fromStep2.style.display = 'block';
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
        fromStep2.style.display = 'block';
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

// 배송 주의사항
function deliveryCaution() {
    let caution = document.getElementById('caution');
    caution.style.display = 'block';
}
function deliveryCautionEnd() {
    let caution = document.getElementById('caution');
    caution.style.display = 'none';
}

// 돈 콤마 찍기
function money(돈) {
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

function roundChange(round) {
	<c:forEach var="item" items="${getShowTime}">
		var showday1 = String(round);
		// var showday = '${item.date_showday}';
		<c:set var="showday" item="${item.date_showday}" />
		<c:if test="${showday1 eq showday}">
			console.log(round + "  비교1");
			console.log(showday + "  비교2");
			changeRound.innerHTML += '<option>${item.date_showtime}</option>';
		</c:if>
	</c:forEach>
}

</script>
