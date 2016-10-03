<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
	<title>마커를 움직여 좌표추출</title>
	<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBoH5tLttmCw5zCZf5i0tlFeQlVwnLiCgM&sensor=false" type="text/javascript"></script>	
	<script>
	var marker;
	var markerTitle;
	var infowindow;
	var map;
	var contentString;
	var geocoder;
	var myCity;
		function returnNation(arr)
		{
			for(var i = 0 ; i < arr[0].address_components.length ; i++)
			{
				if(arr[0].address_components[i].types[0] == "country")
				{
					return arr[0].address_components[i].long_name;
				}
			}
		}
		
		function returnPostal(arr)
		{
			for(var i = 0 ; i < arr[0].address_components.length ; i++)
			{
				if(arr[0].address_components[i].types[0] == "postal_code")
				{
					return arr[0].address_components[i].long_name;					
				}
			}
			return "";
		}
		
		function initialize() 
		{
			/*
				http://openapi.map.naver.com/api/geocode.php?key=f32441ebcd3cc9de474f8081df1e54e3&encoding=euc-kr&coord=LatLng&query=서울특별시 강남구 강남대로 456
                        위와같이 링크에서 뒤에 주소를 적으면 x,y 값을 구할수 있다.
			*/
			var X_point			= "37.49794199999999";		// Y 좌표
			var Y_point			= "127.02762099999995";		// X 좌표

			var zoomLevel		= 16;						// 지도의 확대 레벨 : 숫자가 클수록 확대됨

			markerTitle		= "위즈소프트";					// 현재 위치 마커에 마우스를 올렸을때 나타나는 정보
			var markerMaxWidth	= 1000;						// 마커를 클릭했을때 나타나는 말풍선의 최대 크기
			var markerMaxHeight = 1000;

			// 말풍선 내용
			contentString = '<div class="w3-tag w3-round w3-green" style="padding:3px">' +
					  			'<div class="w3-tag w3-round w3-green w3-border w3-border-white">' +
								 '관광지' +
								'</div>' +
							'</div>';
			//'<h2>위즈소프트</h2>'+
			//'<p>위즈소프트는 WEB Agency & SI 분야에서 10년 이상의 풍부한 경험을 보유한<br />' +
            //'전문 인력으로 구성된 E-Business 전문 기업입니다.</p>' +
            //'<img src="imgs/sqlmapconfig.PNG">'+
			//'<a href="http://www.daegu.go.kr" target="_blank">http://www.daegu.go.kr</a>'+ //링크도 넣을 수 있음
			//'</div>';

			var myLatlng = new google.maps.LatLng(X_point, Y_point);
			var mapOptions = {zoom: zoomLevel, center: myLatlng, mapTypeId: google.maps.MapTypeId.ROADMAP}
			map = new google.maps.Map(document.getElementById('map_view'), mapOptions);
			geocoder = new google.maps.Geocoder();
			marker = new google.maps.Marker({position: myLatlng, map: map, title: markerTitle, draggable:true});

			infowindow = new google.maps.InfoWindow({content: contentString, maxWidth: markerMaxWidth, maxHeight:markerMaxHeight});
						
			google.maps.event.addListener(marker, 'click', function() {
				infowindow.open(map, marker);
			});
			google.maps.event.addListener(marker, 'mouseup', function(event)
			{				
				/* geocode request 객체의 구성요소. (=호출법)
				{
					address: string,
					latLng: LatLng,
					bounds: LatLngBounds,
					region: string
				}
				*/
				// geocode 요청을 latLng 로 지정하면 latLng좌표값으로 지오코드 DB상의 주소를 뽑아내는 쿼리를 실행하는 역지오코드 모드가 된다.
				// address 와 latLng 둘중 하나는 반드시 포함되어야 함.
				geocoder.geocode({'latLng':event.latLng}, function(results, status)
				{
					if (status == google.maps.GeocoderStatus.OK) 
					{	
						// 숨겨둔 MODAL 창 보여주기
						//document.getElementById('id01').style.display='block';
						//if (results[1]) 
						//{
					    	//map.setZoom(11);
					        //var marker = new google.maps.Marker(
					        //{
					        //	position: latlng,
					        //	map: map
					        //});
					        //infowindow.setContent(results[1].formatted_address);
					        //infowindow.open(map, marker);
					     	// event.latLng > mouseup 이벤트가 발생하는 지도상의 좌표값을 추출한다.
				    	/* var longC = "<div style='left:600px; height:600px; position: absolute; z-index:3;'>"
				    				+"<select>";  */
				    	var longC = "<select>";
					    for(var i = 0 ; i < results.length-1 ; i++)
					   	{
					    	longC = longC + "<option>" + results[i].formatted_address + "</option>";					    	
					   	}
					    longC = longC + "</select></div>";
					    infowindow.setContent(longC);
					    //alert(longC);
						/*infowindow.setContent(
								contentString + "여기좌표:" 
								+event.latLng + "<br>" +
								results[0].formatted_address
								+ "<br>" + 
								results[1].formatted_address								
								);*/	
						//infowindow.setContent(longC);
				     	var stringAddr = results[0].formatted_address;
				     	// String.indexOf(string);
				     	// String 내에 string 있을시 0 부터 양수를 반환, 없을시 -1 반환.
				     	//alert(stringAddr.indexOf("대한민국"));
			     		//alert(results[results.length-1].formatted_address);
				     	//if(stringAddr.indexOf("대한민국") > -1)
				     	//{
				     		//var nation = stringAddr.slice(stringAddr.indexOf("대한민국"), stringAddr.indexOf("대한민국") + 4);
				     		//var nation = results[0].address_component[0].long_name;
				     	/*var nation = results[results.length-1].formatted_address;*/
			     		//stringAddr = returnNation(stringAddr, results);
			     		//stringAddr = stringAddr.replace(results[results.length-1].formatted_address, "");
			     		//stringAddr = stringAddr.replace(/(^\s*)|(\s*$)/gi, "");
			     		//stringAddr = stringAddr.replace("  ", " ");
				     	//}
				     	var nation = returnNation(results);
				     	var postal = returnPostal(results);
			     		stringAddr = stringAddr.replace(nation, "").replace(/(^\s*)|(\s*$)/gi, "");
				     	var xPoint = results[0].geometry.location.lat();
				     	var yPoint = results[0].geometry.location.lng();
				     	// 폼이름.폼내부의컨트롤이름.컨트롤의value = 자바스크립트 변수
				     	// 이렇게 하면 자바스크립트상의 변수를 해당 폼의 해당 컨트롤 value 로 넣을수 있다.
				     	aForm.nation.value = nation;
				     	aForm.postal.value = postal;
				     	aForm.stringAddr.value = stringAddr;
				     	aForm.xPoint.value = xPoint;
				     	aForm.yPoint.value = yPoint;
						infowindow.open(map, marker);
						// 맵에 비치는 중앙 지역을 마커의 위치로.
						map.setCenter(marker.position);
					      //} 
						  //else 
					      ///{
					      //  window.alert('No results found');
					      //}
					} 
					else 
					{
					      window.alert('Geocoder failed due to: ' + status);
					}
				});				
			});
			
		}
		
		function markerInit()
		{
			
		}
		
		function Bounce() 
		{
			marker.setAnimation(google.maps.Animation.BOUNCE);	
			infowindow.open(map, marker);
		}
		function bounceStop()
		{
			marker.setAnimation(null);
			infowindow.close();
		}
		function Rungeo()
		{
			// document.forms["폼이름"].elements["인풋객체이름"].value = 해당 폼의 해당 인풋객체의 value 값을 얻어서 자바스크립트 변수에 대입가능.
			var addr = document.forms["aForm"].elements["stringAddr"].value;
			//alert(addr);
			// 지오코딩 모드일땐 'address' 키워드로 생성.
			geocoder.geocode({'address':addr}, function(results, status)
			{
				if (status == google.maps.GeocoderStatus.OK && results.length > 0) 
				{					
					// results[0].geometry.location.lat() 과
					// results[0].geometry.location.lng() 값으로 분리되서 날아온다.
					infowindow.setContent(contentString + "여기좌표:" + results[0].geometry.location.lat() +","+ results[0].geometry.location.lng());
					// results[0] 결과값엔 formatted_address 로 바로 주소 문자열을 얻어올수도 있다.
			     	var stringAddr = results[0].formatted_address;
			     	var nation = returnNation(results);
			     	var postal = returnPostal(results);
		     		stringAddr = stringAddr.replace(nation, "").replace(/(^\s*)|(\s*$)/gi, "");
		     		var xPoint = results[0].geometry.location.lat();
			     	var yPoint = results[0].geometry.location.lng();
			     	// 폼이름.폼내부의컨트롤이름.컨트롤의value = 자바스크립트 변수
			     	// 이렇게 하면 자바스크립트상의 변수를 해당 폼의 해당 컨트롤 value 로 넣을수 있다.
			     	aForm.nation.value = nation;
			     	aForm.postal.value = postal;
			     	aForm.stringAddr.value = stringAddr;
			     	aForm.xPoint.value = xPoint;
			     	aForm.yPoint.value = yPoint;
			     	// 마커 위치는 google.maps.LatLng() 객체를 새로 생성해서 X,Y좌표를 생성자에 던져주면 이동 가능.
			     	marker.setPosition(new google.maps.LatLng(results[0].geometry.location.lat(),results[0].geometry.location.lng()));
					infowindow.open(map, marker);
					// 맵에 비치는 중앙 지역을 마커의 위치로.
					map.setCenter(marker.position);
				} 
				else 
				{
				      window.alert('Geocoder failed due to: ' + status);
				}
			});
		}
		</script>
	</script>
	<style type="text/css">		
		#map_view{
			position: absolute;
		    left: 0px;
		    top: 0px;
		    width: 100%;
		    height: 100%;
		}
		#insert{
			border: 5px dotted green;
			width:500px;
			height:700px;
			position: absolute;
			left: 20px;
			top: 50px;
			background: white;			
			z-index: 3;
		}
		#insertInput{			
			margin:10px 0;
			position: relative;
			left: 20px;
			top:20px;
		}
	</style>
</head>

<body onload="initialize()" class="w3-container">
	<div id="insert">
		마커를 움직여 위치를 지정하세요
		<form name="aForm" action="mapData" method="post" onkeydown="if(event.keyCode==13) return false;" enctype="application/x-www-form-urlencoded">
		<div id="insertInput">
		<div class="w3-tag w3-round w3-green" style="padding:3px">
  			<div class="w3-tag w3-round w3-green w3-border w3-border-white">
   				 국가
			</div>
		</div>
		</div>
		<input type="text" size="16" name="nation" id="insertInput" />
		<div id="insertInput">
		<div class="w3-tag w3-round w3-green" style="padding:3px">
  			<div class="w3-tag w3-round w3-green w3-border w3-border-white">
   				 주소
			</div>
		</div>
		</div>
		<input type="text" name="stringAddr" size="48" placeholder="여기에 주소 검색" id="insertInput" onkeydown="if(event.keyCode==13) Rungeo();" />
		<div id="insertInput">
		<div class="w3-tag w3-round w3-green" style="padding:3px">
  			<div class="w3-tag w3-round w3-green w3-border w3-border-white">
   				 상세주소
			</div>
		</div>
		</div>
		<input type="text" size="48" name="detailAddr" placeholder="직접 입력하세요" id="insertInput" />	
		<div id="insertInput">
		<div class="w3-tag w3-round w3-green" style="padding:3px">
  			<div class="w3-tag w3-round w3-green w3-border w3-border-white">
   				 우편번호
			</div>
		</div>
		</div>
		<input type="text" size="6" name="postal" id="insertInput" />	
		<input type="hidden" name="xPoint" />
		<input type="hidden" name="yPoint" /><br>
		<div style="text-align: center; position: relative; bottom: -55px;">
			<input type="button" value="(테스트)찍은 좌표들 맵에 뿌려보기" onclick="location.href='mapGen'"/>
			<input type="button" value="이전으로" />
			<input type="reset" value="다시입력" />
			<input type="submit" value="다음으로" />
		</div>
		</form>
	</div>
	
	<div id="id01" class="w3-modal">
	  <div class="w3-modal-content">
	    <div class="w3-container">
	      <span onclick="document.getElementById('id01').style.display='none'" 
	      class="w3-closebtn">&times;</span>
	      <select style="width: 500px;">
	      	<option selected="selected">주소지를 선택하세요..</option>
	      </select>
	    </div>
	  </div>
	</div>
	
	<div id="map_view">	
	</div>
	<!-- <img id="map_view" style="display: block;"></img> -->
</body>
</html>