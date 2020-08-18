<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript" src="<%= request.getContextPath()%>/resources/js/jquery-3.3.1.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
window.resizeTo(850, 617);

$(document).ready(function(){
		
    // 상단 관람일/회차 변경
    let changeDate = document.getElementById('changeDate');
    let changeRound = document.getElementById('changeRound');
    let seatArea = document.getElementById('seatArea');
    let eachSeat = document.getElementsByClassName('eachSeat');
    
    <c:forEach var="item" items="${getShowDay}">
    	changeDate.innerHTML += '<option class="changeShowDay">${item}</option>';
    </c:forEach>
    
    /* document.convey.showdate.value = opener.document.convey.showdate.value;

	let changeShowDay = document.getElementsByClassName('changeShowDay');
	for(let i=0; i<changeShowDay.length; i++) {
		if(changeShowDay[i].innerText.substr(0,10) === document.convey.showdate.value) {
			changeShowDay[i].setAttribute('selected', 'selected');
		}
	} */
    
    let selectedDate = changeDate.options[changeDate.selectedIndex].value;
    roundChange(selectedDate);
    
    $("#changeDate").change(function(){
    	var round = $(this).val();
    	changeRound.innerHTML = '';
    	changeRound.innerHTML += '<option>회차 선택</option>';
    	roundChange(round);
    });
    
	/* document.convey.showtime.value = opener.document.convey.showtime.value;
	
	let changeShowTime = document.getElementsByClassName('changeShowTime');
	for(let i=0; i<changeShowTime.length; i++) {
		if(changeShowTime[i].innerText === document.convey.showtime.value) {
			changeShowTime[i].setAttribute('selected', 'selected');
		}
	} */
	
	var dateSel = changeDate.options[changeDate.selectedIndex].value;
	var roundSel = changeRound.options[changeRound.selectedIndex].value;
	
	seatSelAjax(dateSel, roundSel);
    
    $("#changeRound").change(function(){
    	var day = $("#changeDate").val();
    	var round = $(this).val();
    	seatSelAjax(day, round);
    });

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
    
    // 부모창에서 받아온 값 넣기
    /* document.getElementById('conveyName').value = opener.document.convey.conveyName.value;
    document.getElementById('conveyEmail').value = opener.document.convey.conveyEmail.value;
    document.getElementById('conveyHP1').value = opener.document.convey.conveyHP1.value;
    document.getElementById('conveyHP2').value = opener.document.convey.conveyHP2.value;
    document.getElementById('conveyHP3').value = opener.document.convey.conveyHP3.value; */

});

function roundChange(round) {
	<c:forEach var="item" items="${getShowTime}">
		var showday = '${item.date_showday}';
		if(round == showday) {
			document.getElementById('changeRound').innerHTML += '<option class="changeShowTime">${item.date_showtime}</option>';
		}
	</c:forEach>
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
    let seat = document.getElementById('seat');
    seat.innerHTML = "";
}

// 숫자 형식
function numberPad(n, width) {
    n = n + '';
    return n.length >= width ? n:new Array(width - n.length + 1).join('0') + n;
}

// 좌석창 변경 ajax
function seatSelAjax(day, round) {
	
    let seatArea = document.getElementById('seatArea');
    let eachSeat = document.getElementsByClassName('eachSeat');
	reset();
	
	// 좌석 정보 받아오기
	$.ajax({
		url:"<%= request.getContextPath()%>/seatStatus.action",
		type:"POST",
		data:{"showDay":day
			 ,"showRound":round
			 ,"prodID":"${showNum}"},
		dataType:"JSON",
		success:function(json){
			seatArea.innerHTML = ""; 

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
		            
		            var seatTitle = "1층 "+area+"구역 0"+(j+1)+"열 0"+numberPad(no, 2)+"번";
		            $.each(json, function(index, item){
		            	if(item.seat_name == seatTitle) {
		            		if(item.seat_status == 1) {
		            			seatArea.innerHTML += "<div class='soldout' id='t"+numberPad(eachSeat.length+1, 3)+"' title='1층 "+area+"구역 0"+(j+1)+"열 0"+numberPad(no, 2)+"번' style='left: "+left+"px; top: "+top+"px;'></div>";
		            		}
		            		else {
		            			seatArea.innerHTML += "<div class='eachSeat' id='t"+numberPad(eachSeat.length+1, 3)+"' grade='" + item.seat_type + "' title='1층 "+area+"구역 0"+(j+1)+"열 0"+numberPad(no, 2)+"번' style='left: "+left+"px; top: "+top+"px; background-color: " + item.seat_color + ";'></div>";
		            		}
		            		return false;
		            	}
		            });
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

		        if(i<11 || i>25){
		        	var seatTitle = "1층 "+area+"구역 10열 0"+numberPad(no, 2)+"번";
		            $.each(json, function(index, item){
		            	if(item.seat_name == seatTitle) {
		            		if(item.seat_status == 1) {
		            			seatArea.innerHTML += "<div class='soldout' id='t"+numberPad(eachSeat.length+1, 3)+"' title='1층 "+area+"구역 10열 0"+numberPad(no, 2)+"번' style='left: "+left+"px; top: 281px;'></div>";
		            		}
		            		else {
		            			seatArea.innerHTML += "<div class='eachSeat' id='t"+numberPad(eachSeat.length+1, 3)+"' grade='" + item.seat_type + "' title='1층 "+area+"구역 10열 0"+numberPad(no, 2)+"번' style='left: "+left+"px; top: 281px; background-color: " + item.seat_color + ";'></div>";
		            		}
		            		return false;
		            	}
		            });
		        }
		            
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
		            
		            var seatTitle = "2층 "+area+"구역 0"+(y+1)+"열 0"+numberPad(no, 2)+"번";
		            $.each(json, function(index, item){
		            	if(item.seat_name == seatTitle) {
		            		if(item.seat_status == 1) {
		            			seatArea.innerHTML += "<div class='soldout' id='t"+numberPad(eachSeat.length+1, 3)+"' title='2층 "+area+"구역 0"+(y+1)+"열 0"+numberPad(no, 2)+"번' style='left: "+left+"px; top: "+top+"px;'></div>";
		            		}
		            		else {
		            			seatArea.innerHTML += "<div class='eachSeat' id='t"+numberPad(eachSeat.length+1, 3)+"' grade='" + item.seat_type + "' title='2층 "+area+"구역 0"+(y+1)+"열 0"+numberPad(no, 2)+"번' style='left: "+left+"px; top: "+top+"px; background-color: " + item.seat_color + ";'></div>";
		            		}
		            		return false;
		            	}
		            });
		        }
		    }
		    
		// 좌석 클릭 이벤트
	    for(let i=0; i<eachSeat.length; i++) {
	        eachSeat[i].addEventListener('click', function () {
	        	if($("#changeRound").val() == "회차 선택") {
	        		alert("일자 / 시간을 선택해주세요.");
	        		return false;
	        	}

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
	                selectedSeat.innerHTML += '<p id=p'+pTagID+' class="selseatCnt">'+title+'</p>';
	                seat.innerHTML += '<span id=span'+pTagID+' style="display: block">'+title+'</span>'
	            }
	        });
	    }
		},
		error: function(request, status, error){
			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		}
	});
	
	// 시간 회차 입력
	let showDate1 = document.getElementById('showDate1');
	let showDate2 = document.getElementById('showDate2');
	showDate1.innerHTML = day;
	showDate2.innerHTML = round;
}

// 좌석 선택 완료 여부
function seatSelComplete() {
    let selSeat = document.getElementsByClassName('selSeat');
    let ticketPrice = document.getElementById('ticketPrice');
    let ticketPriceDisplay = document.getElementById('ticketPriceDisplay');
    var seatType = "";
    var i = 0;
    var sumPrice = 0;
    ticketPrice.innerHTML = "";
    
    if(selSeat.length === 0)
        alert("좌석을 선택해주세요.");
    else {
    	$(".selSeat").each(function(index, item){
    		seatType = $(item).attr("grade");

    		switch (seatType) {
			case "${getSeatType.get(0).seat_type}":
				sumPrice += ${getSeatType.get(0).seat_price};
				break;
			case "${getSeatType.get(1).seat_type}":
				sumPrice += ${getSeatType.get(1).seat_price};
				break;
			case "${getSeatType.get(2).seat_type}":
				sumPrice += ${getSeatType.get(2).seat_price};
				break;
			}
    		
    	});
        change(step2);
        ticketPrice.innerHTML += sumPrice;
        
        let ticketPriceResult = document.getElementById('ticketPrice').innerText;
        ticketPriceDisplay.innerText = money(Number(ticketPriceResult));
        
     	// 예매 정보 출력 (side bar)
        let ticketPriceInner = ticketPrice.innerText;
        let ticketCommission = document.getElementById('ticketCommission').innerText;
        let sum = Number(ticketPriceInner) + Number(ticketCommission);

        let totalPrice = document.getElementById('totalPrice');
        let totalPriceDisplay = document.getElementById('totalPriceDisplay');
        totalPrice.innerText = sum;
        totalPriceDisplay.innerText = money(sum);
        document.getElementById('paySum').value = sum;
        
        let dc1 = document.getElementById('dc1');
        let dc1Display = document.getElementById('dc1Display');
        dc1.innerText = Number(ticketPriceInner) * 0.25;
        dc1Display.innerText = money(Number(ticketPriceInner) * 0.25);
        
        let dc2 = document.getElementById('dc2');
        let dc2Display = document.getElementById('dc2Display');
        dc2.innerText = Number(ticketPriceInner) * 0.25;
        dc2Display.innerText = money(Number(ticketPriceInner) * 0.25);
        
        let dc3 = document.getElementById('dc3');
        let dc3Display = document.getElementById('dc3Display');
        dc3.innerText = Number(ticketPriceInner) * 0.15;
        dc3Display.innerText = money(Number(ticketPriceInner) * 0.15);
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
        
        // 좌석 정보 받아오기
	   	$.ajax({
			url:"<%= request.getContextPath()%>/takeCoupon.action",
			type:"POST",
			dataType:"JSON",
			success:function(json){
				var html = "";
				
				if(json.length > 0) {
					$.each(json, function(index, item) {
						// alert("111");
						html += "<tr>"
							  + "<td class='row1'>" + item.coupon_name + "</td>"
							  + "<td class='row2'>" + item.coupon_dc + "</td>"
							  + "<td class='row3'><input type='checkbox' class='couponCheck' value='" + item.coupon_dc + "' onchange='changeCoupon()'>"
							  + "</td>";
					});
				}
				else {
					html = "<p style='text-align: center;'>사용 가능한 쿠폰이 없습니다.</p>";
				}
				
				$(".couponList").html(html);
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
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
    let deliveryFee = document.getElementById('deliveryFee');
    let deliveryFeeDisplay = document.getElementById('deliveryFeeDisplay');
    
    let ticketPrice = document.getElementById('ticketPrice').innerText;
    let dcPrice = document.getElementById('dcPrice').innerText;
    let dcCoupon = document.getElementById('dcCoupon').innerText;
    let ticketCommission = document.getElementById('ticketCommission').innerText;
    
    let prevPrice = Number(ticketPrice) - Number(dcPrice) - Number(dcCoupon) + Number(ticketCommission);
    let resultDeliveryFee = 0;
    
    let totalPrice = document.getElementById('totalPrice');
    let totalPriceDisplay = document.getElementById('totalPriceDisplay');
        
    let checkedReceive = null;
    for(let i=0; i<receive.length; i++) {
        if(receive[i].checked === true)
            checkedReceive = receive[i].value;
    }
    if(checkedReceive == '0') {
        deliveryInfo.style.display = 'none';
        deliveryFee.innerText = '0';
        deliveryFeeDisplay.innerText = money(0);   
  
        resultDeliveryFee = 0;
        let resultPrice = prevPrice + resultDeliveryFee; 
         
        totalPrice.innerText = resultPrice;
        totalPriceDisplay.innerText = money(resultPrice);
    }
    else if(checkedReceive == '1') {
        deliveryInfo.style.display = 'block';
        deliveryFee.innerText = '2500';
        deliveryFeeDisplay.innerText = money(2500);
  
        resultDeliveryFee = 2500;
        let resultPrice = prevPrice + resultDeliveryFee; 
         
        totalPrice.innerText = resultPrice;
        totalPriceDisplay.innerText = money(resultPrice);
    }
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

    if(check1 && check2) {
        alert('결제로 이동');
        if($("input:radio[id='card']").prop('checked') == true) {
        	Pay();
        }
        else if($("input:radio[id='deposit']").prop('checked') == true) {
        	alert("계좌이체 정보알림페이지로 이동");
        }
    }
    else {
        alert('취소 수수료/취소 기한 및 제 3자 정보 제공 내용에 동의하셔야만 \n결제가 가능합니다.');
    }
}

function setAddress(){

    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
            // 예제를 참고하여 다양한 활용법을 확인해 보세요.

            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                // document.getElementById("sample6_extraAddress").value = extraAddr;
                console.log(extraAddr);

            } else {
                //document.getElementById("sample6_extraAddress").value = '';
                console.log(extraAddr);
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.querySelector('#postNo').value = data.zonecode;
            document.querySelector('#address').value = addr;
            document.querySelector('#address').value += extraAddr;
            // 커서를 상세주소 필드로 이동한다.
            document.querySelector('#detailAddress').focus();
        }
    }).open();

}; // end of function setAddress();

  
function ChangeAddressInfo(num) {
	var children = $(".deliveryRow2").children('input');
	
	switch (num) {
	case 1:
		document.getElementById('deliveryName').value = document.getElementById('conveyName').value;
		document.getElementById('deliveryPostNo').value = opener.document.convey.conveyPostcode.value;
		document.getElementById('deliveryAddress').value = opener.document.convey.conveyAddress.value;
		document.getElementById('detailAddress').value = opener.document.convey.conveyDetailAddress.value;
		
		break;
	case 2:
		alert("새로고침");
		console.log(children);
		children.value = "";
		break;
	}
}

function Pay() {
	var frm = document.payFrm;
	frm.method = "POST";
	frm.action = "<%= request.getContextPath()%>/payPopUp.action";
	frm.submit();
	
	<%-- var url = "<%= request.getContextPath()%>/payPopUp.action";
	var option = "width = 971, height = 635, top = 200, left = 500, location = no, scrollbars = yes, toolbars = no, status = no";
	window.open(url, "", option); --%>
	
	
	/* var sFeatures = "dialogWidth:300px; dialogheight:100px; dialogLeft:100px; dialogTop:100px; center: no; status:no; scroll:no";
	window.showModalDialog("paymentGateway.jsp", window,sFeatures); */
	/* window.showModalDialog("paymentGateway.jsp", self, "dialogLeft:0px; dialogTop:0px; dialogWidth:200px; dialogHeight:200px"); */
	
	/* modal('inipay_modal'); */
}

/* function modal(id) {
	var zIndex = 9999;
    var modal = document.getElementById(id);

    // 모달 div 뒤에 희끄무레한 레이어
    var bg = document.createElement('div');
    bg.setStyle({
        position: 'fixed',
        zIndex: zIndex,
        left: '0px',
        top: '0px',
        width: '100%',
        height: '100%',
        overflow: 'auto',
        // 레이어 색갈은 여기서 바꾸면 됨
        backgroundColor: 'rgba(0,0,0,0.4)'
    });
    document.body.append(bg);

    // 닫기 버튼 처리, 시꺼먼 레이어와 모달 div 지우기
    modal.querySelector('.modal_close_btn').addEventListener('click', function() {
        bg.remove();
        modal.style.display = 'none';
    });

    modal.setStyle({
        position: 'fixed',
        display: 'block',
        boxShadow: '0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)',

        // 시꺼먼 레이어 보다 한칸 위에 보이기
        zIndex: zIndex + 1,

        // div center 정렬
        top: '50%',
        left: '50%',
        transform: 'translate(-50%, -50%)',
        msTransform: 'translate(-50%, -50%)',
        webkitTransform: 'translate(-50%, -50%)'
    });
} */

//가격할인
function changeDC() {
	
	let dcCheck1 = document.getElementById('dcCheck1');
	let dcCheck2 = document.getElementById('dcCheck2');
	let dcCheck3 = document.getElementById('dcCheck3');

    let dc1 = document.getElementById('dc1').innerText;
    let dc2 = document.getElementById('dc2').innerText;
    let dc3 = document.getElementById('dc3').innerText;
    
    let deliverySpan = document.getElementById('deliverySpan');
    
    let resultDC = 0;
    
    if(dcCheck1.checked) {
    	resultDC = Number(dc1);
    	if(dcCheck2.checked || dcCheck3.checked) {
        	alert('할인은 하나만 선택이 가능합니다.');
        	dcCheck2.checked = false;
        	dcCheck3.checked = false;
    	}
    	deliverySpan.style.display = 'none';
    }
    if(dcCheck2.checked) {
    	resultDC = Number(dc2);
    	if(dcCheck1.checked || dcCheck3.checked) {
        	alert('할인은 하나만 선택이 가능합니다.');
        	dcCheck1.checked = false;
        	dcCheck3.checked = false;
    	}
    	deliverySpan.style.display = 'none';
    }
    if(dcCheck3.checked) {
    	resultDC = Number(dc3);
    	if(dcCheck1.checked || dcCheck2.checked) {
        	alert('할인은 하나만 선택이 가능합니다.');
        	dcCheck1.checked = false;
        	dcCheck2.checked = false;
    	}
    	deliverySpan.style.display = 'none';
    }  
    
    if(!dcCheck1.checked && !dcCheck2.checked && !dcCheck3.checked) {
    	deliverySpan.style.display = 'inline';
    }

    let dcPrice = document.getElementById('dcPrice');
    let dcPriceDisplay = document.getElementById('dcPriceDisplay');
    dcPrice.innerText = resultDC;
    dcPriceDisplay.innerText = money(resultDC);

    // 총 결제금액 변경
    let ticketPrice = document.getElementById('ticketPrice').innerText;
    let ticketCommission = document.getElementById('ticketCommission').innerText;
    let dcCoupon = document.getElementById('dcCoupon').innerText;
    let dcPoint = document.getElementById('dcPoint').innerText;
    let resultPrice = Number(ticketPrice) + Number(ticketCommission) - Number(resultDC) - Number(dcCoupon) - Number(dcPoint);

    let totalPrice = document.getElementById('totalPrice');
    let totalPriceDisplay = document.getElementById('totalPriceDisplay');

    totalPrice.innerText = resultPrice;
    totalPriceDisplay.innerText = money(resultPrice);

    document.getElementById('paySum').value = resultPrice;
}

// 쿠폰할인
function changeCoupon() {	
	
	let couponCheck = document.getElementsByClassName('couponCheck');
    let dcCoupon = document.getElementById('dcCoupon');
    let dcCouponDisplay = document.getElementById('dcCouponDisplay');
    let sumCoupon = 0;
	for(let i=0; i<couponCheck.length; i++) {
		if(couponCheck[i].checked) {
			alert(couponCheck[i].value);
		}
		
	}

   /* let couponCheck1 = document.getElementById('couponCheck1');
    if(couponCheck1.checked) {
        dcCoupon.innerText = couponCheck1.value;
        dcCouponDisplay.innerText = money(couponCheck1.value);
    }
    else if(!couponCheck1.checked) {
        dcCoupon.innerText = Number(dcCoupon.innerText) - Number(couponCheck1.value);
        dcCouponDisplay.innerText = money(dcCoupon.innerText);
    }*/

    // 총 결제금액 변경
    let ticketPrice = document.getElementById('ticketPrice').innerText;
    let ticketCommission = document.getElementById('ticketCommission').innerText;
    let dcPrice = document.getElementById('dcPrice').innerText;
    let dcPoint = document.getElementById('dcPoint').innerText;
    let resultPrice = Number(ticketPrice) + Number(ticketCommission) - Number(dcPrice) - Number(dcCoupon.innerText) - Number(dcPoint);

    let totalPrice = document.getElementById('totalPrice');
    let totalPriceDisplay = document.getElementById('totalPriceDisplay');

    totalPrice.innerText = resultPrice;
    totalPriceDisplay.innerText = money(resultPrice);

    document.getElementById('paySum').value = resultPrice;
    
}

</script>
