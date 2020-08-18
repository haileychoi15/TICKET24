<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<style>
	
	
	div.mycontent {
  		width: 300px;
  		padding: 5px 3px;
  	}
  	
  	div.mycontent>.title {
  		font-size: 12pt;
  		font-weight: bold;
  		background-color: #d95050;
  		color: #fff;
  	}
  	
  	div.mycontent>.title>a {
  		text-decoration: none;
  		color: #fff;
  	}
  	
  	
  	div.mycontent>.desc {
  	 /* border: solid 1px red; */
  		padding: 10px 0 0 0;
  		color: #000;
  		font-weight: normal;
  		font-size: 9pt;
  	}
  	
  	div.mycontent>.desc>img {
  		width: 50px;
  		height: 50px;
  	}
 
</style>



<div id="map" style="width:90%; margin-top:300px; height:450px;"></div>

<%--
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=발급받은 APP KEY(JavaScript 키)를 넣으시면 됩니다."></script> 
--%>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1c844a357c44e6590d364de15fd13d24"></script>


<script>
$(document).ready(function(){
	
	
	
	// ========================================= // 
	
	
	// 지도를 담을 영역의 DOM 레퍼런스
	var mapContainer = document.getElementById('map'); // Id 가 map 인 태그에 담는다.

	// 지도를 생성할 때 필요한 기본 옵션
	var options = {
		center: new kakao.maps.LatLng(37.56602747782394, 126.98265938959321), // 지도의 중심좌표(위도, 경도). 반드시 존재해야함.
		level: 4 // 지도의 레벨(확대, 축소 정도). 숫자가 적을수록 확대된다(세세하게 나온다). 
	};
	/*
	  center 에 할당할 값은 kakao.maps.LatLng 클래스를 사용하여 생성한다.
	  kakao.maps.LatLng 클래스의 2개 인자값은 첫번째 파라미터는 위도(latitude)이고, 두번째 파라미터는 경도(longitude)이다.
	*/

	// 지도 생성 및 생성된 지도객체 리턴
	var mapobj = new kakao.maps.Map(mapContainer, options);
	
	// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성함. 	
	var mapTypeControl = new kakao.maps.MapTypeControl();

	// 지도 타입 컨트롤을 지도에 표시함.
	// kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미함.	
	mapobj.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

	// 지도 확대 축소를 제어할 수 있는 줌 컨트롤을 생성함.	
	var zoomControl = new kakao.maps.ZoomControl();

	// 지도 확대 축소를 제어할 수 있는 줌 컨트롤을 지도에 표시함.
	// kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 RIGHT는 오른쪽을 의미함.	 
	mapobj.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

	if (navigator.geolocation) {
		// HTML5의 geolocation으로 사용할 수 있는지 확인한다 
			
		// GeoLocation을 이용해서 웹페이지에 접속한 사용자의 현재 위치를 확인하여 그 위치(위도,경도)를 지도의 중앙에 오도록 한다. 
		navigator.geolocation.getCurrentPosition(function(position) {
			
			var latitude = position.coords.latitude;   // 현위치의 위도
			var longitude = position.coords.longitude; // 현위치의 경도
			console.log("현위치의 위도: "+latitude+", 현위치의 경도: "+longitude); 
		
			// 마커가 표시될 위치를 geolocation으로 얻어온 현위치의 위.경도 좌표로 한다   
			var locPosition = new kakao.maps.LatLng(latitude, longitude);

			// 마커이미지를 기본이미지를 사용하지 않고 다른 이미지로 사용할 경우의 이미지 주소 
	        var imageSrc = 'http://localhost:9090/MyMVC/images/pointerPink.png'; 

	     	// 마커이미지의 크기 
		    var imageSize = new kakao.maps.Size(34, 39); 

		 	// 마커이미지의 옵션. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정한다. 
		    var imageOption = {offset: new kakao.maps.Point(15, 39)};

		 	// 마커의 이미지정보를 가지고 있는 마커이미지를 생성한다. 
		    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);
		
		 	// == 마커 생성하기 == //
			var marker = new kakao.maps.Marker({ 
				map: mapobj, 
		        position: locPosition, // locPosition 좌표에 마커를 생성 
		        image: markerImage     // 마커이미지 설정
			}); 
			
		 	marker.setMap(mapobj); // 지도에 마커를 표시한다

			// === 인포윈도우(텍스트를 올릴 수 있는 말풍선 모양의 이미지) 생성하기 === //
			
			// 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능함.
			var iwContent = "<div style='padding:5px; font-size:9pt;'>여기에 계신가요?<br/><a href='https://map.kakao.com/link/map/현위치(약간틀림),"+latitude+","+longitude+"' style='color:blue;' target='_blank'>큰지도</a> <a href='https://map.kakao.com/link/to/현위치(약간틀림),"+latitude+","+longitude+"' style='color:blue' target='_blank'>길찾기</a></div>";

			// 인포윈도우 표시 위치
		    var iwPosition = locPosition;

		 	// removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됨
		    var iwRemoveable = true; 
		 
		 	// == 인포윈도우를 생성하기 == 
			var infowindow = new kakao.maps.InfoWindow({
			    position : iwPosition, 
			    content : iwContent,
			    removable : iwRemoveable
			});
		 	
			// == 마커 위에 인포윈도우를 표시하기 == //
			infowindow.open(mapobj, marker);

			// == 지도의 센터위치를 locPosition로 변경한다.(사이트에 접속한 클라이언트 컴퓨터의 현재의 위.경도로 변경한다.)
		    mapobj.setCenter(locPosition);

			
		});
		
		
	}
	else {
		// HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정한다.
		var locPosition = new kakao.maps.LatLng(37.56602747782394, 126.98265938959321);     
        
		// 위의 
		// 마커이미지를 기본이미지를 사용하지 않고 다른 이미지로 사용할 경우의 이미지 주소 
		// 부터
		// 마커 위에 인포윈도우를 표시하기 
		// 까지 동일함.
		
     	// 지도의 센터위치를 위에서 정적으로 입력한 위.경도로 변경한다.
	    mapobj.setCenter(locPosition);

	} // end of if~else
	
		
	
	// ================== 지도에 클릭 이벤트를 등록하기 ======================= //
	// 지도를 클릭하면 클릭한 위치에 마커를 표시하면서 위,경도를 보여주도록 한다.
	
	// == 마커 생성하기 == //
	// 1. 마커이미지 변경
	var imageSrc = 'http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png';       
	        
	// 2. 마커이미지의 크기 
    var imageSize = new kakao.maps.Size(34, 39);   
		      
    // 3. 마커이미지의 옵션. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정한다. (좌표는 다 한다음에 설정한다.)
    var imageOption = {offset: new kakao.maps.Point(15, 39)};   
      
    // 4. 이미지정보를 가지고 있는 마커이미지를 생성한다. 
    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);
		    
    var movingMarker = new kakao.maps.Marker({ 
		map: mapobj, 
        image: markerImage  // 마커이미지 설정
	});
    
    // === 인포윈도우(텍스트를 올릴 수 있는 말풍선 모양의 이미지) 생성하기 === //
	var movingInfowindow = new kakao.maps.InfoWindow({
	    removable : false
	  //removable : true   // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됨
	});
	
    
	kakao.maps.event.addListener(mapobj, 'click', function(mouseEvent) {         
		    
		 // 클릭한 위도, 경도 정보를 가져옵니다 
		 var latlng = mouseEvent.latLng;
		 
		 // 마커 위치를 클릭한 위치로 옮긴다.
		 movingMarker.setPosition(latlng);
		 
		 // 인포윈도우의 내용물 변경하기 
		 movingInfowindow.setContent("<div style='padding:5px; font-size:9pt;'>여기가 어디에요?<br/><a href='https://map.kakao.com/link/map/여기,"+latlng.getLat()+","+latlng.getLng()+"' style='color:blue;' target='_blank'>큰지도</a> <a href='https://map.kakao.com/link/to/여기,"+latlng.getLat()+","+latlng.getLng()+"' style='color:blue' target='_blank'>길찾기</a></div>");  
		 
		 // == 마커 위에 인포윈도우를 표시하기 == //
		 movingInfowindow.open(mapobj, movingMarker);
		 
		 var htmlMessage = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, '; 
		     htmlMessage += '경도는 ' + latlng.getLng() + ' 입니다';
		    
		 var resultDiv = document.getElementById("latlngResult"); 
		 resultDiv.innerHTML = htmlMessage;
	});

	
	
	// ========================================= // 

	
	// 매장 마커를 표시할 위치와 내용을 가지고 있는 객체 배열
	// location2.jsp 에서는 수동적으로 객체를 정해주었지만, 매장의 개수는 얼마든지 늘어날 수 있으므로 DB 에 있는 매장의 정보를 불러와서 ajax:json 을 이용해서 매장찾기를 해보았다.
	var positionArr = [];
	
	$.ajax({
		url:"<%= request.getContextPath()%>/mapInfo.action",
		async:false, // !!!!!! 지도는 비동기 통신(async:true)이 아닌 동기통신(async:false)으로 해야한다.!!!!!!
		// 동기와 비동기의 차이 : url 에 가서 데이터(json)를 받아올 때까지 가만히 대기하며 기다리는 것이 아니라, url 에 가서 데이터(json)를 받아올 때 까지 다른 것으로 넘어가서 진행하다가 다시 올라오는 것이 비동기이다.
		// 동기를 해야 하는 이유는, 지도정보를 다 가지고 온 후에 처리 해야하므로 json 으로 지도정보를 다 가지고 올 때 까지 가만히 대기해서 기다려야 한다. 
		data:{"prod_id":"1"},
		dataType:"json",
		success:function(json){
			
			$.each(json, function(index, item){
				var position = {}; // 배열에 넣을 객체 생성
				position.content =  "<div class='mycontent'>"+ 
						       		 "  <div class='title'>"+ 
							         "    <a href='"+item.map_url+"' target='_blank'><strong>"+item.map_name+"</strong></a>"+  
							         "  </div>"+
							         "  <div class='desc'>"+ 
							         /* "    <img src='/MyMVC/images/"+item.storeimg+"'>"+   */
							         "    <span class='address'>"+item.map_address+"</span>"+ 
							         "  </div>"+ 
							         "</div>";
				
				position.latlng = new kakao.maps.LatLng(item.map_lat, item.map_lng);
				
				position.zIndex = index;
							         
				positionArr.push(position); // 배열 positionArr 속에 객체 position 을 넣어준다(push)
				
			});
			
		},
		error: function(request, status, error){
			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	    }

		
	});
	
	// 인포윈도우를 가지고 있는 객체 배열의 용도 
	var infowindowArr = new Array(); 

	// == 객체 배열 만큼 마커 및 인포윈도우를 생성하여 지도위에 표시한다. == // 
	for(var i=0; i<positionArr.length; i++) {
		
		// == 마커 생성하기 == //
		var marker = new kakao.maps.Marker({
			map: mapobj,
			position: positionArr[i].latlng 	
		});
		
		// 지도에 마커를 표시한다.
		marker.setMap(mapobj);
		
		// == 인포윈도우를 생성하기 == // 
		var infowindow = new kakao.maps.InfoWindow({
			content: positionArr[i].content,
			removable: true, 
			zIndex: i+1
		});
		
		// 인포윈도우를 가지고 있는 객체배열에 넣기
		infowindowArr.push(infowindow);
		
		// == 마커 위에 인포윈도우를 표시하기 == //
		//	infowindow.open(mapobj, marker);
		
		// == 마커 위에 인포윈도우를 표시하기 == // 
		// 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
	    // 이벤트 리스너로는 클로저(closure => 함수 내에서 함수를 정의하고 사용하도록 만든것)를 만들어 등록합니다 
	    // for문에서 클로저(closure => 함수 내에서 함수를 정의하고 사용하도록 만든것)를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
	    kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(mapobj, marker, infowindow, infowindowArr));

		
		
	} // end of for--------------------------
	
	
	
	
});	// end of $(document).ready()----------------
	
	
	
	//인포윈도우를 표시하는 클로저(closure => 함수 내에서 함수를 정의하고 사용하도록 만든것)를 만드는 함수입니다 
	function makeOverListener(mapobj, marker, infowindow, infowindowArr) {
	    return function() {
	    	// alert("infowindow.getZIndex()-1:"+ (infowindow.getZIndex()-1));
	    	
	    	for(var i=0; i<infowindowArr.length; i++) {
	    		if(i == infowindow.getZIndex()-1) {
	    			infowindowArr[i].open(mapobj, marker);
	    		}
	    		else{
	    			infowindowArr[i].close();
	    		}
	    	}
	    };
	}

	
	
	
	
</script>


<div id="latlngResult" style="margin: 20px 0;"></div>

