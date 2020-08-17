<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Title</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;700&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="resources/css/coupon.css"/>
    
    <script type="text/javascript">
    	function couponReceive(couponNum) {
    		// alert(num + "쿠폰발행");
   			$.ajax({
   				url:"<%= request.getContextPath()%>/getCoupon.action",
   				type:"GET",
   				data:{"couponNum":couponNum},
   				dataType:"JSON",
   				success:function(json){
   					if(json.resultNum == 1) {
   						alert("이미 발급받으셨습니다.");
   					}
   					else if(json.resultNum == 0) {
   						alert(json.couponName + " 쿠폰을 발급받으셨습니다!!");
   					}
   					else {
   						alert("쿠폰 발급에 실패하셨습니다. 고객센터로 문의해주세요.")
   					}
   				},
   				error: function(request, status, error){
   					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
   				}
   			});
    	}
    </script>
</head>

<body>
<section class="event-top">
                <div class="event-ad">
                <img src="resources/images/assets/eventtop.png" alt="이벤트안내이미지"/>
                </div>
             <!--   <div class="event-title">
                    <p>쿠폰은 <span>여기</span>!</p>
                </div>-->
</section>
<section class="event-main">

    <!--쿠폰 2개-->
                <div class="coupon-top">
                    <div class="coupon-box"> <!--borderrad-->
                       <div class="coupon-image" onclick="couponReceive(1);">
                            <img src="http://tkfile.yes24.com/img/event/2020/0318_Monthly/MonthlyCou_free.png" alt="수수료면제쿠폰">
                       </div>

                        <div class="coupon-desc">
                            <span data-tooltip-text="취소 시 쿠폰 복원&#10;타 할인,쿠폰과 중복 사용 가능&#10;다운로드 당일 사용 가능">
                                유의사항
                            </span>
                        </div>
                    </div>
                    <div class="coupon-box"> <!--borderrad-->
                        <div class="coupon-image" onclick="couponReceive(2);">
                            <img src="http://tkfile.yes24.com/img/event/2020/0318_Monthly/MonthlyCou_3w.png" alt="3000원 쿠폰">
                        </div>

                        <div class="coupon-desc">
                            <span data-tooltip-text="취소 시 쿠폰 복원&#10;타 할인,쿠폰과 중복 사용 가능&#10;다운로드 당일 사용 가능">
                                유의사항
                            </span>
                        </div>
                    </div>
                </div>

    <!--쿠폰 2개-->
                <div class="coupon-bottom">
                    <div class="coupon-box"> <!--borderrad-->
                        <div class="coupon-image" onclick="couponReceive(3);">
                            <img src="http://tkfile.yes24.com/img/event/2020/0318_Monthly/MonthlyCou_5w.png" alt="5000원 쿠폰">
                        </div>

                        <div class="coupon-desc">
                            <span data-tooltip-text="취소 시 쿠폰 복원&#10;타 할인,쿠폰과 중복 사용 가능&#10;다운로드 당일 사용 가능">
                                유의사항
                            </span>
                        </div>
                    </div>
                    <div class="coupon-box"> <!--borderrad-->
                        <div class="coupon-image" onclick="couponReceive(4);">
                            <img src="http://tkfile.yes24.com/img/event/2020/0318_Monthly/MonthlyCou_10w.png" alt="10000원 쿠폰">
                        </div>

                        <div class="coupon-desc">
                            <span data-tooltip-text="취소 시 쿠폰 복원&#10;타 할인,쿠폰과 중복 사용 가능&#10;다운로드 당일 사용 가능">
                                유의사항
                            </span>
                        </div>
                    </div>
                </div>
</section>

</body>
</html>