<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
	String ctxPath = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>반응형상세</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;700&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="resources/css/grid.min.css" />
    <link rel="stylesheet" href="resources/css/respstyle.css">
    <link rel="stylesheet" href="resources/css/fullcalendar/main.css">
    
    <style type="text/css">
    a {text-decoration: none !important;}
	
	#star_grade a{
        text-decoration: none;
        color: gray;
    }
    
    #star_grade a.on{
        color: red;
    }
    
	<%-- .star-rating { width:103px; }
	.star-rating,.star-rating span { display:inline-block; height:19px; overflow:hidden; background:url(<%= ctxPath%>/resources/images/star_resize.png)no-repeat; color: orange;}
	.star-rating span{ background-position:left bottom; line-height:0; vertical-align:top; } --%>
	
	<%-- .star-rating { width:115px; }
	.star-rating,.star-rating span { display:inline-block; height:22px; overflow:hidden; background:url(<%= ctxPath%>/resources/images/orange_star.PNG)no-repeat; color: orange;}
	.star-rating span{ background-position:left bottom; line-height:0; vertical-align:top; } --%>
	
	li.pageBarStyle {
		display:inline-block; 
		width:30px;
	}
	
    </style>
    
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=713478ea9084b9fc9e6f5c1cc4d5d95f&libraries=services"></script>
    <script src="https://kit.fontawesome.com/3625c042d9.js" crossorigin="anonymous"></script>
   	<script src='resources/js/fullcalendar/main.js'></script>
    <script src="resources/js/fullcalendar/ko.js"></script>
    <script>

        document.addEventListener('DOMContentLoaded', function() {
        	
        	var loginuserid = "${sessionScope.loginuser.userid}";
       // 	document.getElementById('fk_userid').value = loginuserid;
        	

			var existlike = $("#existlike").val();
			console.log("existlike : "+existlike);
			
			goLikeProdCnt();
			
		/* 	goLikeProdCnt();
			
			var loginuserid = "${sessionScope.loginuser.userid}";
			if(loginuserid != "") {
				goLikeProdUser();
			} */
			
		
			goReviewList("1");
        	
        	var showdate = document.getElementById('showdate');
        	var showtime = document.getElementById('showtime');
        	
            var calendarEl = document.getElementById('calendar');
            var calendar = new FullCalendar.Calendar(calendarEl, {
                initialView: 'dayGridMonth',
                locale:'ko',
                dateClick: function(info) {
                    // alert('Date: ' + info.dateStr); // 선택한 달력의 값
                    // 달력을 선택하면 Ajax로 달력의 값이 date_showday 와 같은 경우 회차정보를 불러오도록 한다. 
                    
                    $.ajax({
						url:"<%= request.getContextPath()%>/dateLoading.action",
						data:{"chooseDate":info.dateStr,
							  "seq":"${pvo.prod_id}"},
						type:"GET",
						dataType:"JSON",
						success:function(json){
							var html = "";
							if(json.length > 0) {
								$.each(json, function(index, item){
									html += "<button onclick='goShowtime(\""+item.date_showtime+"\");' class='ticketing-button'>"+item.date_showtime+"</button>";
								//	console.log(item.date_showtime);
								
									$(".ticketing-detailtime").html(html);
									showdate.value = info.dateStr;
								});
							}
							else {
								$(".ticketing-detailtime").html("");
								showdate.value = "";
							}
						},
						error: function(request, status, error){
							alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
						}
					});
                
                }
            });
            
            calendar.render();

            
            
            
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            
            //	지도를 담을 영역의 DOM 레퍼런스
     		var mapContainer = document.getElementById('map');
     		
     	//	지도를 생성할때 필요한 기본 옵션
     		var options = {
     			center: new kakao.maps.LatLng(37.510338, 127.058518),	// 지도의 중심좌표. 반드시 존재해야함.
     			level: 4	// 지도의 레벨(확대, 축소 정도). 숫자가 적을수록 확대 된다.
     		};
     		/*
     		  center 에 할당할 값은 kakao.maps.LatLng 클래스를 사용하여 생성한다.
     		  kakao.maps.LatLng 클래스의 2개 인자값은 첫번째 파라미터는 위도(latitude)이고, 두번째 파라미터는 경도(longitude)이다.
     		*/
     		
     	//	지도 생성 및 생성된 지도객체 리턴
     		var mapobj = new kakao.maps.Map(mapContainer, options);
     		
     	//	일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성함. 	
     		var mapTypeControl = new kakao.maps.MapTypeControl();
     	
     	//	지도 타입 컨트롤을 지도에 표시함.
     	//	kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미함.	
     		mapobj.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
     	
     	//	지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성함.	
     		var zoomControl = new kakao.maps.ZoomControl();
     	
     	//	지도 확대 축소를 제어할 수 있는  줌 컨트롤을 지도에 표시함.
     	//	kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 RIGHT는 오른쪽을 의미함.	 
     		mapobj.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
     	
     		if (navigator.geolocation) {
     		//	HTML5의 geolocation으로 사용할 수 있는지 확인한다 
     				
     			// GeoLocation을 이용해서 웹페이지에 접속한 사용자의 현재 위치를 확인하여 그 위치(위도,경도)를 지도의 중앙에 오도록 한다. 
     			navigator.geolocation.getCurrentPosition(function(position) {
     				var latitude = position.coords.latitude;   // 현위치의 위도
     				var longitude = position.coords.longitude; // 현위치의 경도
     				
     			//	=== 인포윈도우(텍스트를 올릴 수 있는 말풍선 모양의 이미지) 생성하기 === //
     				
     			//	인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능함.
     			
     			$.ajax({
     				url:"<%= request.getContextPath()%>/mapInfo.action",
     				async:false, // !!!!!! 지도는 비동기 통신(async:true)이 아닌 동기통신(async:false)으로 해야한다.!!!!!!
     				// 동기와 비동기의 차이 : url 에 가서 데이터(json)를 받아올 때까지 가만히 대기하며 기다리는 것이 아니라, url 에 가서 데이터(json)를 받아올 때 까지 다른 것으로 넘어가서 진행하다가 다시 올라오는 것이 비동기이다.
     				// 동기를 해야 하는 이유는, 지도정보를 다 가지고 온 후에 처리 해야하므로 json 으로 지도정보를 다 가지고 올 때 까지 가만히 대기해서 기다려야 한다. 
     				data:{"prod_id":"${pvo.prod_id}"},
     				dataType:"json",
     				success:function(json){
     					
     					var iwContent =  "<div class='mycontent'>"+ 
     									 "	<div class='title'>"+ 
     									 "		<a href='"+json.map_url+"' target='_blank'><strong>"+json.map_name+"</strong></a>"+  
     									 "	</div>"+
     									 "	<div class='desc'>"+ 
     								//	 "		<img src='/finalproject4/resources/images/logo3.png' width='60px' height='25px'><br>"+  
     									 "		<span class='address'>"+json.map_address+"</span>"+ 
     									 "	</div>"+ 
     								//	 "	<div class='desc' style='padding:5px; font-size:9pt;'>"+
     								//	 "      <a href='https://map.kakao.com/link/map/코엑스디홀,"+json.map_lat+","+json.map_lng+"' style='color:blue;' target='_blank'>큰지도</a>"+
     								//	 "      <a href='https://map.kakao.com/link/to/코엑스디홀,"+json.map_lat+","+json.map_lng+' style='color:blue;' target='_blank'>길찾기</a>"+
     									 "	<div class='desc' style='padding:5px; font-size:9pt;'><a href='https://map.kakao.com/link/map/"+json.map_name+","+json.map_lng+","+json.map_lat+"' style='color:blue;' target='_blank'>큰지도</a>"+
     									 "  <a href='https://map.kakao.com/link/to/"+json.map_name+","+json.map_lng+","+json.map_lat+"' style='color:blue' target='_blank'>길찾기</a></div>"+
     									 "  </div>"+
     									 "</div>";
     					console.log(Number(json.map_lat)+": map_lat,"+Number(json.map_lng)+": map_lng");
     				//  ## lat, lng 순서바뀜. ##
     									 
     					var iwPosition = new kakao.maps.LatLng(Number(json.map_lng), Number(json.map_lat));
     					var iwZIndex = 1;
     						
     				//	removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됨
     				    var iwRemoveable = true; 
     				
     				//	== 인포윈도우를 생성하기 == 
     					var infowindow = new kakao.maps.InfoWindow({
     					    position : iwPosition, 
     					    content : iwContent,
     					    zIndex : iwZIndex,
     					    removable : iwRemoveable
     					});
     				
     				//  마커 위치 지정해주기
     				//  마커가 표시될 위치를 geolocation으로 얻어온 현위치의 위.경도 좌표로 한다   
     					var locPosition = new kakao.maps.LatLng(Number(json.map_lng), Number(json.map_lat));
     		
     				//	마커이미지를 기본이미지를 사용하지 않고 다른 이미지로 사용할 경우의 이미지 주소 
     			        var imageSrc = 'http://localhost:9090/finalproject4/resources/images/pointerPink.png'; 
     		
     				//	마커이미지의 크기 
     					var imageSize = new kakao.maps.Size(34, 39); 
     		
     				//	마커이미지의 옵션. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정한다. 
     				    var imageOption = {offset: new kakao.maps.Point(15, 39)};
     		
     				//	마커의 이미지정보를 가지고 있는 마커이미지를 생성한다. 
     					var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);
     		
     				//	== 마커 생성하기 == //
     					var marker = new kakao.maps.Marker({ 
     						map: mapobj, 
     				        position: locPosition, // locPosition 좌표에 마커를 생성 
     				        image: markerImage     // 마커이미지 설정
     					}); 
     				
     					marker.setMap(mapobj); // 지도에 마커를 표시한다
     				
     				
     				//	== 마커 위에 인포윈도우를 표시하기 == //
     					infowindow.open(mapobj, marker);
     				
     				//	== 지도의 센터위치를 iwPosition로 변경한다.
     				    mapobj.setCenter(iwPosition);
     				
     				    kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(mapobj, marker, infowindow));
     				
     					$("#goBackBtn").click(function(){
     						mapobj.setCenter(iwPosition);
     					});
     					
     					
     				},
     				error: function(request, status, error){
     					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
     			    }
     		
     				
     			});
     			
     			});
     		}

            	
			//   == 마커 위에 인포윈도우를 표시하기 ==
            //	infowindow.open(mapobj, marker);
                    	
            //	== 마커 위에 인포윈도우를 표시하기 ==
            //	마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
            //	이벤트 리스너로는 클로저(closure => 함수 내에서 함수를 정의하고 사용하도록 만든것)를 만들어 등록합니다 
            //	for문에서 클로저(closure => 함수 내에서 함수를 정의하고 사용하도록 만든것)를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
                    		
                    	
            //	================== 지도에 클릭 이벤트를 등록하기 ======================= //
            //	지도를 클릭하면 클릭한 위치에 마커를 표시하면서 위,경도를 보여주도록 한다.
            //	== 마커 생성하기 == //
            //	1. 마커이미지 변경
            var imageSrc = 'http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png';       
                    			        
            //	2. 마커이미지의 크기 
            var imageSize = new kakao.maps.Size(34, 39);   
                    				      
            //	3. 마커이미지의 옵션. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정한다. 
            var imageOption = {offset: new kakao.maps.Point(15, 39)};   
                    		      
            //	4. 이미지정보를 가지고 있는 마커이미지를 생성한다. 
            var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);
                    				    
            var movingMarker = new kakao.maps.Marker({ 
  				map: mapobj, 
  				image: markerImage  // 마커이미지 설정
  			});
  		    
  		//	=== 인포윈도우(텍스트를 올릴 수 있는 말풍선 모양의 이미지) 생성하기 === //
  			var movingInfowindow = new kakao.maps.InfoWindow({
  				removable : false
  			//	removable : true   // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됨
  			});
                    			
                    		    
			kakao.maps.event.addListener(mapobj, 'click', function(mouseEvent) {         
				    
			//	클릭한 위도, 경도 정보를 가져옵니다 
				var latlng = mouseEvent.latLng;
				 
			//	마커 위치를 클릭한 위치로 옮긴다.
				movingMarker.setPosition(latlng);
				 
			//	인포윈도우의 내용물 변경하기 
				movingInfowindow.setContent("<div style='padding:5px; font-size:9pt;'>여기가 어디에요?<br/><a href='https://map.kakao.com/link/map/여기,"+latlng.getLat()+","+latlng.getLng()+"' style='color:blue;' target='_blank'>큰지도</a> <a href='https://map.kakao.com/link/to/여기,"+latlng.getLat()+","+latlng.getLng()+"' style='color:blue' target='_blank'>길찾기</a></div>");  
				 
			// 	== 마커 위에 인포윈도우를 표시하기 == //
				movingInfowindow.open(mapobj, movingMarker);
			
			});  			
                    			
            
        }); // end of document.addEventListener('DOMContentLoaded', function() {})-----------------------
        
        
        function makeOverListener(mapobj, marker, infowindow) {
    		
    	    return function() {
    	    	
        		if(0 == infowindow.getZIndex()-1) {
        			infowindow.open(mapobj, marker);
        		}
        		else{
        			infowindow.close();
        		}
        		
    	    };
    	}
        
        
        
        function goShowtime(time) {
        	var showtime = document.getElementById('showtime');
        	showtime.value = time;
        }

        
        function goReview() {

        	
        	var form_data = $("form[name=reviewFrm]").serialize();
        	
        	$.ajax({
				url:"<%= request.getContextPath()%>/addReview.action",
				data:form_data,
				type:"GET",
				dataType:"JSON",
				success:function(json){
					var html = "";
					if(json.n == 1) {
						alert("리뷰가 등록되었습니다.");
					}
					else {
						alert("리뷰등록에 실패했습니다.");
					}
					/* 
					$(".modal").addClass("hide");
					$(".modal").removeClass("show"); */

					$("#content").val("");
					$(".modal").css("display","none");
					
					goReviewList("1");
					
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			});
        	
        }
        
        
        function goReviewList(page){
        	
        	$.ajax({
				url:"<%= request.getContextPath()%>/reviewList.action",
				data:{"parentProdId":"${pvo.prod_id}"
					 ,"fk_userid":"${sessionScope.loginuser.userid}"
					 ,"page":page},
				type:"GET",
				dataType:"JSON",
				success:function(json){
					
					var html = "";
					html += "<ul class='review-comments-list'>";
					if(json.length > 0) {
						
						$.each(json, function(index, item){
							html += getReviewTemplate(item.review_id, item.fk_userid, item.name, item.star, item.regDate, item.content);
						});
						
					}
					else {
						html += "<li>관람후기가 없습니다.<li>";
					}
					
					html += "</ul>"
					$(".review-comments").html(html);

					makeCommentPageBar(page);
                    
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			});
        	
        }
        
        function moveBooking() {
            
            let showdate = document.getElementById('showdate');
            let showtime = document.getElementById('showtime');
           
            if(showdate.value === '' || showtime.value === '') {
            alert('날짜와 회차를 모두 선택하여 주세요.');
            return false;
            }
             
             let fk_userid = document.getElementById('fk_userid');
             if(fk_userid.value === '') {
             alert('공연 예매는 로그인이 필요합니다.');
             location.href="<%=ctxPath%>/login.action"
             return false;
             }
            
             window.open("/finalproject4/reservePopUp.action", "popUp", 'toolbar=no, menubar=no, scrollbars=no');
            
            }
        
        
        function getReviewTemplate(review_id, fk_userid, name, star, regDate, content) {
        
        var loginuserid = "${sessionScope.loginuser.userid}";
        var fk_userid_sub = fk_userid.substring(0,fk_userid.length-2) + '**';                
        var template = '<li>'+
        			   '<div class="review-comment-badge">'+
	        				'<span class="reservationbadge">예매자</span>';
	        				
		if(fk_userid == loginuserid){
            template += '<span class="writerself">본인</span>';
        }
		
	        template += '</div>'+
	                    '<div class="review-comment-star">'+
	                        '<span class="reviewer">'+fk_userid_sub+'</span>'+
	                        '<span class="reviewer">'+regDate+'</span>'+
	                        '<span class="reviewer">';
	                        
	                        for(var i=0; i<star; i++){
								template += "<span><i class='fas fa-star reviewstar' style='color:orange;'></i></span>";
							}
							for(var i=0; i<5-star; i++){
								template += "<span><i class='far fa-star reviewstar' style='color:orange;'></i></span>";
							}
	                        
             template += '</span>'+
                    '</div>'+
                    '<div class="review-comment-desc">'+
                    '<span>(관람일:2020.08.02)</span>'+
                    '<p>'+
                    content+
                    '</p>'+
                '</div>'+
                '<div class="review-comment-bottom">'+
                    '<div class="review-comment-like">'+
                    '<span onclick="goLikeReview('+review_id+','+'\''+fk_userid+'\')">'+
                        '<i id="likeReviewMain" class="far fa-heart noncolored-heart"></i>'+
                        /* '<i class="fas fa-heart colored-heart"></i>'+
                        '<strong class="main-likes-number">'+
                            '118'+
                        '</strong>'+  */
                    '</div>'+
                    '<div class="review-comment-revision">'+
                        '<span class="rev revisionButton" onclick="goEditReview('+review_id+','+'\''+fk_userid+'\''+','+'\''+star+'\''+','+'\''+content+'\''+')">수정</span>'+
                        '<span class="rev" onclick="goDelReview('+review_id+','+'\''+fk_userid+'\''+')" style="color:blue;">삭제</span>'+
                    '</div>'+
                '</div>'+
            '</li>';
            	
            return template;
        }
        
        function prevPageBar(page) {
        	var prevPageBar = "<li class='pageBarStyle' style=''><a href='javascript:goReviewList(\""+Number(page)+"\")'><i class='fas fa-angle-left'></i></a></li>";
        	return prevPageBar;
        }
        

        function nextPageBar(page) {
        	var nextPageBar = "<li class='pageBarStyle' style=''><a href='javascript:goReviewList(\""+Number(page)+"\")'><i class='fas fa-angle-right'></i></a></li>";
        	return nextPageBar;
        }
        
        
        function makeCommentPageBar(page) {
    		
    		$.ajax({
    			url:"<%= request.getContextPath()%>/getReviewTotalPage.action",
    			data:{"parentProdId":"${pvo.prod_id}"
					 ,"fk_userid":"${sessionScope.loginuser.userid}"
    				 ,"sizePerPage":"5"
    				 ,"page":page},
    			type:"GET",
    			dataType:"JSON",
    			success:function(json){
    			
    				if(json.totalPage > 0) { // 댓글이 있는 경우
    				
    					var pageBarHTML = "<ul style='list-style: none;'>"; 
    					var blockSize = 10;
    					var loop = 1;
    				
    					if(typeof page == "string") {
    						page = Number(page);
    					}
    					
    					var pageNo = Math.floor((page - 1)/blockSize) * blockSize + 1;
    					
    					
    					/* // === [이전 <<] 만들기 === //
    					if(pageNo != 1) {
    						pageBarHTML += prevPageBar(pageNo-1);
    					} */

    					// === [이전 <] 만들기 === //
    					if(page == 1) {
    						pageBarHTML += prevPageBar(1);
    					}
    					else{
    						pageBarHTML += prevPageBar(page-1);
    					}
    					
    					while( !(loop > blockSize || pageNo > json.totalPage) ) {
    						
    						if(pageNo == page) {
    							pageBarHTML += "<li class='pageBarStyle' style='color:red;'>"+pageNo+"</li>";
    						}
    						else {
    							pageBarHTML += "<li class='pageBarStyle'><a href='javascript:goReviewList(\""+(pageNo)+"\")'>"+pageNo+"</a></li>";
    						}
    						
    						loop++;
    						pageNo++;
    					}

    					// === [다음 >] 만들기 === //
    					if(page >= json.totalPage) {
    						pageBarHTML += nextPageBar(json.totalPage);
    					}
    					else{
    						pageBarHTML += nextPageBar(page+1);
    					}

    					/* // === [다음 >>] 만들기 === //
    					if( !(pageNo > json.totalPage) ) { 
    						pageBarHTML += nextPageBar(pageNo);
    					} */
    					
    					pageBarHTML += "</ul>";
    					$(".review-pagination").html(pageBarHTML);
    				
    					var num = Number(json.avgStar) / 5 * 100;
    					$(".star-rating-width").css('width', num+'%');
    					$(".totalReviewCount").html(json.totalCount);
    					$(".star").html(json.avgStar);
    					
    				}
    				else { // 댓글이 없는 경우
    					$(".review-pagination").empty();
    					
    					$(".star-rating-width").css('width', '0%');
    					$(".totalReviewCount").html(0);
    					$(".star").html(0);
    				}
    			
    			},
    			error: function(request, status, error){
    				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
    			}
    		});
    		
    	}// end of function makeCommentPageBar(currentShowPageNo) --------------------
    	
        
    	function goDelReview(review_id, fk_userid){
    		
    		var loginuserid = "${sessionScope.loginuser.userid}";
    		if(fk_userid != loginuserid) {
    			alert("댓글삭제는 본인만 가능합니다.");
    			return;
    		}
    		
    		var bool = confirm("리뷰글을 정말로 삭제하시겠습니까?");
    		if(bool) {
    			
    			$.ajax({
    				url:"<%= ctxPath%>/delReview.action",
    				type:"GET",
    				data:{"review_id":review_id,
    					  "fk_userid":fk_userid},
    				dataType:"JSON",
    				success:function(json) {
    					
    					if(json.n == 1) {
    						alert("리뷰가 삭제되었습니다.");
    					}
    					else {
    						alert("리뷰삭제를 할 수 없습니다.");
    					}
    					
    					goReviewList(1);
    				},
    				error: function(request, status, error){
    					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
    				}
    			});	
    			
    		}
    	}
    	
    	
    	function goEditReview(review_id, fk_userid, star, content) {
    		// 수정 모달 띄우기
    		
    		var loginuserid = "${sessionScope.loginuser.userid}";
    		if(fk_userid != loginuserid) {
    			alert("댓글수정은 본인만 가능합니다.");
    			return;
    		}
    		
    	//	$(".revision").css("display","inline-block");
    		$(".revision").css("display","initial");
    		
    		$(".close-revision-button").click(function(){
    			$(".revision").css("display","none");
    		});
    		
			$("#review_id").val(review_id);
    		$("#input-content").val(content);
    		
    		
    		// 초기 별점셋팅
    		$(".re-starlist i").removeClass("staron");
    		$(".re-starlist i").eq(star).prevAll("i").addClass("staron"); // eq(index=star) 인 star+1번째 별 전에 모두 on 시키기
    		$("#re-star").val(star);
    		
    		// 별점 주기
    		$(".re-starlist i").click(function(){
                $(this).parent().children("i").removeClass("staron");  /* 별점의 on 클래스 전부 제거 */ 
                $(this).addClass("staron").prevAll("i").addClass("staron"); /* 클릭한 별과, 그 앞 까지 별점에 on 클래스 추가 */
                
            //  var hasClassLen = $(this).siblings().hasClass("on");
            //  console.log(hasClassLen);	// true  
            
            	var hasClassLen = $(".re-starlist i.staron").length;
            //  alert(hasClassLen);
            	$("#re-star").val(hasClassLen);

                return false;
            });
    		
    	}
    	
    	
		function goEditEndReview() {
        	
        	$.ajax({
				url:"<%= request.getContextPath()%>/editReview.action",
				data:{"review_id":$("#review_id").val(),
				  	  "star":$("#re-star").val(),
				  	  "content":$("#input-content").val()},
				type:"GET",
				dataType:"JSON",
				success:function(json){
					var html = "";
					if(json.n == 1) {
						alert("수정되었습니다.");
					}
					else {
						alert("수정할 수 없습니다.");
					}
					/* 
					$(".revision").addClass("hide");
					$(".revision").removeClass("show"); */

					$("#input-content").val("");
					$("#re-star").val("");
					$(".revision").css("display","none");
					
					goReviewList("1");
					
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			});
        	
        }
		
		// 관심상품 등록하기
		function goLikeProd(prod_id) {
			
			var loginuserid = "${sessionScope.loginuser.userid}";
			
			if(loginuserid == "") {
				alert("관심상품등록은 로그인 후 가능합니다.");
				return;
			}
			
			var existlike = $("#existlike").val();
			console.log(existlike);
			/* 
			 if(existlike == '1') {
				alert("이미 추천한 글입니다.");
				return;
			}   */
			
			// 관심상품 등록하기
			$.ajax({
				url:"<%= request.getContextPath()%>/likeProd.action",
				type:"GET",
				data:{"prod_id":prod_id,
					  "fk_userid":loginuserid},
				   // "existlike":existlike},
				dataType:"JSON",
				success:function(json) {
					
					if(json.m == "추천") { 
						if(json.n == 1) {
							alert("관심상품으로 등록되었습니다. ");
					 		goLikeProdCnt(); 
							$("#existlike").val("1");
							
							$("#likeProdMain").removeClass("far");
							$("#likeProdMain").addClass("fas");
						}
						else {
							alert("관심상품으로 등록할 수 없습니다. ");
						}
					 }
					else {
						if(json.n == 1) {
							alert("관심상품에서 삭제되었습니다. ");
					 		goLikeProdCnt();
							$("#existlike").val("0");
							$("#likeProdMain").removeClass("fas");
							$("#likeProdMain").addClass("far");
						}
						else {
							alert("관심상품을 삭제할 수 없습니다. ");
						}
					} 
					
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			});	   
			
		}
		
		// 리뷰 추천하기
		function goLikeProdCnt(){
			
			var loginuserid = "${sessionScope.loginuser.userid}";
			
			$.ajax({
				url:"<%= request.getContextPath()%>/likeProdCnt.action",
				type:"GET",
				data:{"prod_id":"${pvo.prod_id}",
					  "fk_userid":loginuserid},  
				dataType:"JSON",
				success:function(json) {
					
					if(json.likeProdCnt != 0) {
						$(".main-likes-number").html(json.likeProdCnt);
						if(json.existlike == 1) {
							$("#likeProdMain").removeClass("far");
							$("#likeProdMain").addClass("fas");
						}
						else {
							$("#likeProdMain").removeClass("fas");
							$("#likeProdMain").addClass("far");
						}
					}
					else {
						$(".main-likes-number").html(json.likeProdCnt);
					}
					
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			});	   
			
		}
		
		
		function goLikeReview(review_id, fk_userid){
			
			alert(fk_userid);
	 		var loginuserid = "${sessionScope.loginuser.userid}";
			
			if(loginuserid == "") {
				alert("리뷰 추천은 로그인 후 가능합니다.");
				return;
			}
			
			if(loginuserid == fk_userid){
				alert("자기자신의 리뷰는 추천할 수 없습니다.");
				return;
			}
			
			// 관심상품 등록하기
			$.ajax({
				url:"<%= request.getContextPath()%>/likeReview.action",
				type:"GET",
				data:{"review_id":review_id,
					  "fk_userid":fk_userid, 
				  	  "fk_parentProdId":"${pvo.prod_id}"},
				dataType:"JSON",
				success:function(json) {
					
					if(json.m == "추천") { 
						if(json.n == 1) {
							alert("리뷰추천이 완료되었습니다. ");
					 	//	goLikeProdCnt(); 
							
							$("#likeReviewMain").removeClass("far");
							$("#likeReviewMain").addClass("fas");
						}
						else {
							alert("리뷰 추천할 수 없습니다. ");
						}
					 }
					else {
						if(json.n == 1) {
							alert("관심상품에서 삭제되었습니다. ");
					 	//	goLikeProdCnt();
					 	
							$("#likeReviewMain").removeClass("fas");
							$("#likeReviewMain").addClass("far");
						}
						else {
							alert("리뷰 추천 취소할 수 없습니다. ");
						}
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
<section class="landing">
    <div class="container">
        <div class="row">
            <div class="col-12">
               <div class="landing-content">
                    <!--이전페이지주소로이동-->
                   <a href="#" class="landing-category">
                       <span>콘서트</span>><span>국내뮤지션</span>
                   </a>

                   <div class="landing-info">

                       <h1 class="landing-title">
                           [${pvo.local}] ${pvo.prod_title}
                       </h1>
                       <strong class="landing-date">
                           ${pvo.info_open_date}~${pvo.info_close_date}
                       </strong>
                       <a href="#map" class="landing-place">
                           <i class="fas fa-map-marker-alt"></i>
                           ${pvo.map_name}
                           <%-- <input type="hidden" value="${pvo.prod_id}" > --%>
                       </a>

                   </div>

                   <div class="landing-share">

                       <button type="button" class="share-button" id="shareButton" aria-label="Share this product"></button>

                       <div class="share-box show">
                           <a href="https://www.facebook.com/">
                               <i class="fab fa-facebook"></i>
                           </a>
                           <a href="https://twitter.com/?lang=ko">
                               <i class="fab fa-twitter-square"></i>
                           </a>
                           <a href="https://www.instagram.com/?hl=ko">
                               <i class="fab fa-instagram"></i>
                           </a>
                           <button type="button" class="share-button" id="close-button" aria-label="Share this product"></button>
                       </div>

                   </div>

               </div>
            </div>
        </div>
    </div>
</section>
<section class="main">
    <div class="container">
        <div class="row">

            <div class="col-12 col-md-5">
                <div class="main-image">
                    <img src="resources/images/${pvo.prod_img}" alt="팬텀싱어3콘서트"/>
                </div>

                <div class="main-rate">
                    <div class="main-likes">
						<span id="likecnt"></span>
                    	<span onclick="goLikeProd('${pvo.prod_id}')">
                    		<i id="likeProdMain" class="far fa-heart" style="color:orange;"></i>
	                    </span>
                        <strong class="main-likes-number">
                            118
                        </strong>
                    </div> 
                    <div class="main-reviews">
                        <a href="#review" class="main-review-link">
                            <strong class="star">
                                <span class='star-rating'><span class='star-rating-width' style ='width:0%'></span></span>
                            </strong>&nbsp;
                            (<span class="totalReviewCount">
                                
                            </span>개)
                        </a>
                    </div>
                </div>
            </div>

            <div class="col-12 col-md-7">
                <div class="main-detail-top">
                    <dl>
                        <div>
                            <dt>등급</dt>
                            <dd>${pvo.info_grade}</dd>
                        </div>
                        <div>
                            <dt>관람시간</dt>
                            <dd>${pvo.info_run_time}</dd>
                        </div>
                        <!--  <div>
                            <dt>출연</dt>
                            <dd>라포엠</dd>
                        </div>-->
                        <div>
                            <dt>가격</dt>
                            <dd>
                                <div class="main-price">
                                	<c:forEach var="seattype" items="${seattypeList}">
                                    	<span>${seattype.seat_type}석</span><span>${seattype.seat_price}</span><br/>
                                	</c:forEach>
                                </div>
                            </dd>
                        </div>
                    </dl>
                </div>

                <div class="main-detail-bottom">
                    <dl>
                        <div>
                            <dt>공연시간안내</dt>
                            <dd>
                            	<c:forEach var="datevo" items="${dateList}" varStatus="status">
                                <span>
                                <c:if test = "${status.count %2!=0}">${datevo.date_showday}</c:if> 
                                	&nbsp;&nbsp;&nbsp; ${datevo.date_showtime}
                                <c:if test="${status.count %2 !=0}">,</c:if>
                                <c:if test="${status.count %2 ==0}"><br/></c:if>
                                </span>
                            	</c:forEach>
                            </dd>
                        </div>
                        <div>
                            <dt>배송정보</dt>
                            <dd><!--예매 테이블 수령방법 컬럼-->
                                <span>본 상품은 일괄배송 상품으로 2020년 08월 10일부터 순차 배송됩니다.</span>
                            </dd>
                        </div>
                    </dl>
                </div>
            </div>
        </div>
    </div>
</section>
<section class="ticketing">
    <div class="container">
        <div class="row">
            <!--달력-->
            <div class="col-12 col-md-7">
                <div class="ticketing-choice">
                <h2>날짜/시간 선택</h2>
                </div>
                <div class="ticketing-desc">
                
                
                    <div id="calendar">
                    </div>
                    
                    
                    <div class="ticketing-detailtime">
                        <!--회차정보-->
                        <!-- 
                        <a href="#" class="ticketing-button">
                            <span>1회</span>
                            오후 7시 00분
                        </a> -->
							
                    </div>
                </div>
            </div>


            <!--예매가능좌석-->
            <div class="col-12 col-md-5">
                <h2 class="ticketing-title">예매 가능 좌석</h2>
                <div class="ticketing-seat">
                    <div class="ticketing-seat-list">
                        <dl>
                        	<c:forEach var="seattype" items="${seattypeList}">
                            <dt>${seattype.seat_type}석</dt>
                            <dd>
                                ${seattype.seat_price}<br>
                            <span>(잔여:17석)</span>
                            </dd>
                            </c:forEach>
                        </dl>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<section class="booking">
<div class="container">
    <div class="row">
        <div class="col-12">
            <a onclick="moveBooking()" class="booking-button">예매하기</a>
            <a href="http://ticket.yes24.com/Pages/English/Perf/FnPerfList.aspx" class="booking-button-invert">Booking</a>
        </div>
    </div>
</div>


<form name="convey">
	<input type="hidden" name="showdate" id="showdate" value="" />
	<input type="hidden" name="showtime" id="showtime" value="" />
	<input type="hidden" name="conveyName" value="${sessionScope.loginuser.name}">
	<input type="hidden" name="conveyEmail" value="${sessionScope.loginuser.email}">
	<input type="hidden" name="conveyHP1" value="${sessionScope.loginuser.hp1}">
	<input type="hidden" name="conveyHP2" value="${sessionScope.loginuser.hp2}">
	<input type="hidden" name="conveyHP3" value="${sessionScope.loginuser.hp3}">
	<input type="hidden" name="conveyPostcode" value="${sessionScope.loginuser.postcode}">
	<input type="hidden" name="conveyAddress" value="${sessionScope.loginuser.address}">
	<input type="hidden" name="conveyDetailAddress" value="${sessionScope.loginuser.detailAddress}">
</form>
					<!-- finalproject4/reservePopUp.action 으로 예매하기 데이터 넘기는 부분 -->
					
					
					<input type="hidden" id="existlike" value="0" />
					<!-- 관심상품이 이미 눌러져있는지 여부를 판단하는 부분 -->
					

</section>
<section class="maincategory">
<div class="container">
    <div class="row">
        <div class="col-12"> <!--선택된 배너에 orange 효과주기-->
            <div class="mainlinks">
            <span class="info">상세정보</span>
            <a href="#review" class="post" >관람후기</a>
            <span class="cancel">예매/취소안내</span>
            </div>
        </div>
    </div>
</div>
</section>
<section class="caution">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <h1 class="caution-title">유의사항</h1>
                <p class="caution-desc">
                    ※ 본 공연은 네이버 쿠폰이 적용되지 않습니다.<br>
                    ※ 본 공연은 YES24공연에서 진행하는 할인쿠폰이벤트 대상에서 제외됩니다.<br>
                    ※ 매수제한 : 회차별 1인 4매
                </p>
            </div>
        </div>
    </div>
</section>
<section class="detail">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="detail-image">
                    <img src="resources/images/${pvo.prod_detail_img}" alt="상세설명1">
                    <!-- <img src="resources/images/assets/phantomsingerdetail2.jpg" alt="상세설명2">
                    <img src="resources/images/assets/phantomsingerdetail3.jpg" alt="상세설명3"> -->
                </div>
            </div>
        </div>
    </div>
</section>
<section class="refund">
    <div class="container">
        <div class="row">
            <div class="col-12 justify-content-center">
                <div class="refund-table">
                    <table>
                        <thead>
                            <tr>
                                <th class="refund-title">
                                    취소/환불방법
                                </th>
                            </tr>
                        </thead>

                        <tbody>
                            <tr>
                                <td>
                                    <div class="refund-desc">
                                        <p>
                                            취소 일자에 따라 아래와 같이 취소수수료가 부과됩니다. 예매일보다 관람일 기준이 우선 적용되오니 유의해주시기 바랍니다.
                                            <br>
                                            단, 예매 후 7일 이내라도 취소시점이 공연일로부터 10일 이내라면 그에 해당하는 취소수수료가 부과됩니다.
                                            <br>
                                            (단, 상품에 따라 취소 정책이 달라질 수 있고, 각 공연이 공지하는 취소 정책이 우선 적용되므로, 예매 시 참고하시기 바랍니다.)
                                        </p>

                                        <div class="refund-detail-table">
                                            <table>
                                                <caption></caption>
                                                <colgroup>
                                                    <col width="50%">
                                                    <col width="50%">
                                                </colgroup>
                                                <tbody>
                                                <tr>
                                                    <th scope="col">취소일</th>
                                                    <th scope="col">취소수수료</th>
                                                </tr>
                                                <tr>
                                                    <td>예매 후 7일 이내</td>
                                                    <td>없음</td>
                                                </tr>
                                                <tr>
                                                    <td>예매 후 7일 이내</td>
                                                    <td>없음</td>
                                                </tr>
                                                <tr>
                                                    <td>예매 후 8일~관람일 10일 전까지</td>
                                                    <td>장당 4,000원(단,티켓 금액의 10% 이내)</td>
                                                </tr>
                                                <tr>
                                                    <td>관람일 9일 전~관람일 7일 전까지</td>
                                                    <td>티켓 금액의 10%</td>
                                                </tr>
                                                <tr>
                                                    <td>관람일 6일 전~관람일 3일 전까지</td>
                                                    <td>티켓 금액의 20%</td>
                                                </tr>
                                                <tr>
                                                    <td>관람일 2일 전~취소마감일시까지</td>
                                                    <td>티켓 금액의 30%</td>
                                                </tr>
                                                </tbody>
                                            </table>
                                        </div>


                                        <p>
                                            예매수수료는 예매 당일 밤 12시 이전 취소 시에만 환불되며, 그 이후 기간에는 환불되지 않습니다.
                                            <br>
                                            취소는 MY공연&gt;예매확인/취소 에서 직접 취소 또는 고객센터(1544-6399)를 통해 취소 가능합니다.
                                            <br>
                                            티켓이 배송된 후에는 PC/모바일 취소가 불가, 취소마감시간 이전에 예스24 고객센터로 티켓이 반송되어야 취소 가능합니다.
                                            <br>
                                            (취소수수료는 티켓 도착일 기준으로 부과되며, 배송비는 환불되지 않습니다.)
                                        </p>
                                    </div> <!--div desc-->
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- 
<div class="map_wrap">
    
    <ul id="category">
        <li id="BK9" data-order="0"> 
            <span class="category_bg bank"></span>
            은행
        </li>       
        <li id="MT1" data-order="1"> 
            <span class="category_bg mart"></span>
            마트
        </li>  
        <li id="PM9" data-order="2"> 
            <span class="category_bg pharmacy"></span>
            약국
        </li>  
        <li id="OL7" data-order="3"> 
            <span class="category_bg oil"></span>
            주유소
        </li>  
        <li id="CE7" data-order="4"> 
            <span class="category_bg cafe"></span>
            카페
        </li>  
        <li id="CS2" data-order="5"> 
            <span class="category_bg store"></span>
            편의점
        </li>      
    </ul>
</div> -->
<section class="map" >
    <div class="container">
        <div class="row">
            <div class="col-12">
                <strong class="map-title">
                    <i class="fas fa-map-marker-alt"></i>
                    ${pvo.map_name}
                </strong>
                <div id="map" class="map-desc">
                	
					<%-- <jsp:include page="map.jsp"></jsp:include> --%>
                </div>
            </div>
        </div>
    </div>
</section>
<section class="review" id="review">
    <div class="container">
        <div class="row">
            <div class="col-12">

                <div class="review-title">
                    <i class="far fa-comment-dots"></i>
                    <strong>
                        관람후기
                    </strong>
                </div>

                <div class="review-desc">
                    <p class="cautionpara">
                        <span class="caution-red">매매,욕설 등 예스 24 게시판 운영 규정에 위반되는 글은 사전 통보없이 삭제될 수 있습니다.</span>
                        <br>
                        개인정보가 포함된 내용은 삼가 주시기 바라며,게시물로 인해 발생하는 문제는 작성자 본인에게 책임이 있습니다.
                    </p>
                    <div class="review-register">
                        <dl>
                            <dt>평점</dt>
                            <dd class="star">4.94</dd>
                        </dl>
                        <dl>
                            <dt>리뷰</dt>
                            <dd class="totalReviewCount">108</dd>
                        </dl>
                        <span class="review-ok-button">
                            리뷰작성
                        </span>
                    </div>
                    <section class="modal hide">
                        <div class="modal-group">
                            <form name="reviewFrm" class="modal-form">
                                <div class="modal-table">
                                    <div class="modal-title">
                                        <p class="post-title">${pvo.prod_title}</p>
                                        <button type="button" class="close-button"><span>+</span></button>
										<input type="hidden" name="fk_userid" id="fk_userid" value="${sessionScope.loginuser.userid}" />
                                        <input type="hidden" name="parentProdId" id="parentProdId" value="${pvo.prod_id}" />
                                    </div>
                                    <div class="row datestar">
                                        <div class="table-title">관람일시</div>
                                        <div class="table-content">관람 내역이 없습니다.</div>
                                    </div>
                                    <div class="row datestar">
                                        <div class="table-title">작성자명</div>
                                        <div class="table-content"><input type="text" name="name" value="${sessionScope.loginuser.name}" readonly /></div>
                                    </div>
                                    <div class="row datestar">
                                        <div class="table-title">별점</div>
                                        <div class="table-content starlist">
                                            <span><i class="fas fa-star"></i></span>
                                            <span><i class="fas fa-star"></i></span>
                                            <span><i class="fas fa-star"></i></span>
                                            <span><i class="fas fa-star"></i></span>
                                            <span><i class="fas fa-star"></i></span>
                                            <input type="hidden" name="star" id="star" value="" />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="table-title">관람후기</div>
                                        <div class="table-content">
                                            <textarea id="content" name="content" class="input-content" maxlength="2000" minlength="10" cols="30" rows="10" placeholder="내용을 작성해주세요.(최소 20byte/최대 2,000byte)"></textarea>
                                        </div>
                                    </div>
                                </div>
                                <div class="post-buttons">
                                    <button type="button" class="post-ok-button" onclick="goReview();">등록</button>
                                </div>
                            </form>
                        </div>
                    </section>

                   <section class="revision hide">
                        <div class="revision-group">
                            <form name="reviewEditFrm" class="revision-form">
                                <div class="revision-table">
                                    <div class="revision-title">
                                        <p class="re-title">${pvo.prod_title}</p>
                                        <button type="button" class="close-revision-button" ><span>+</span></button>
                                    </div>
                                    <div class="re-row re-datestar">
                                        <div class="re-table-title">관람일시</div>
                                        <div class="re-table-content">관람 내역이 없습니다.</div>
                                        <input type="hidden" name="review_id" id="review_id" value="" />
                                    </div>
                                    <%-- <div class="row datestar">
                                        <div class="table-title">작성자명</div>
                                        <div class="table-content"><input type="text" name="name" value="${sessionScope.loginuser.name}" readonly /></div>
                                    </div> --%>
                                    <div class="re-row re-datestar">
                                        <div class="re-table-title">별점</div>
                                        <div class="re-table-content re-starlist">
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <input type="hidden" name="re-star" id="re-star" value="" />
                                        </div>
                                    </div>
                                    <div class="re-row">
                                        <div class="re-table-title">관람후기</div>
                                        <div class="re-table-content">
                                            <textarea name="input-content" id="input-content" class="re-input-content" maxlength="2000" minlength="10" cols="30" rows="10" placeholder="내용을 작성해주세요.(최소 20byte/최대 2,000byte)"></textarea>
                                        </div>
                                    </div>
                                </div>
                                <div class="re-post-buttons">
                                    <button type="button" class="re-post-ok-button" onclick="goEditEndReview();">수정</button>
                                </div>
                            </form>
                        </div>
                    </section>  

                </div><!-- review-desc끝 -->
                <div class="review-comments">
                    
                    
                
                    
                </div>
                <div class="review-pagination" style="margin-bottom: 100px;">
                    
                </div>
            </div>
        </div>
    </div>
</section>
<section class="notice hide">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="info-1">
                    <div class="info-1-title">
                       <h2> 예매 </h2>
                    </div>
                    <div class="info-1-desc">
                        <p>
                            예매는 PC, 모바일, 고객센터 를 통해 신용카드, 가상계좌(무통장 입금), YES머니, YES상품권, 예치금 등으로 예매하실 수 있습니다.
                            <br>
                            (단, 상품마다 사용 가능한 결제 수단이 다르게 적용될 수 있으니 상품 상세페이지 안내 사항을 확인해주세요.)
                            <br>
                            무통장입금 결제 선택 시 입금 마감시간은 예매일 익일 밤 11시 29분까지
                            입니다. 입금 마감시간 내 미입금 된 경우 예매가 자동 취소됩니다.
                            <br>
                            (단, 상품에 따라 예매 당일 밤 11시 29분에 마감되는 경우가 있으니 예매 전후 반드시 확인해주시기 바랍니다.)
                            <br>
                            예매수수료는 다음과 같습니다.
                        </p>
                        <table>
                            <thead>
                                <tr>
                                    <th>장르</th>
                                    <th>pc/모바일</th>
                                    <th>전화예매</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>콘서트,뮤지컬,클래식,국악,무용</td>
                                    <td>장당 1,000원</td>
                                    <td rowspan="3">장당 2,000원</td>
                                </tr>
                                <tr>
                                    <td>연극,전시</td>
                                    <td>장당 500원</td>
                                </tr>
                                <tr>
                                    <td>체험,행사</td>
                                    <td>장당 300원</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- 
<button type="button" class="return-top-button" aria-label="Back to top">
    <img src="resources/images/assets/curvey.jpg" alt="">
</button> 
-->

<script src="resources/js/detailpage.js"></script>
</body>
</html>
    
   