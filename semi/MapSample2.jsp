<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
	<title></title>
	<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBoH5tLttmCw5zCZf5i0tlFeQlVwnLiCgM" type="text/javascript"></script>	
	<script type="text/javascript">	
	//var marker;
	//var infowindow;
	var map;
	//var contentString;
	var geocoder;
	//var myCity;
	//var markerTitle;
	var xcoords = [];
	//alert("coords"+xcoords[0]);
	var ycoords = [];
	var titles = [];
	var latLng;
	var markerTitle;
	var marker = [];
	var infowindow;
	var count;
		function goToDetail(no)
		{
			var URL = "/semiProject01/detail?hostNo="+no;
			location.replace(URL);
		}
		
		function initMarker(cnt)
		{
			count = cnt;
			for(var i = 0 ; i < count ; i++)
			{
				titles.push(document.getElementsByName("VOaddr")[i].value);
				xcoords.push(document.getElementsByName("VOx")[i].value);
				ycoords.push(document.getElementsByName("VOy")[i].value);			
			}
			initialize();
		}
		function initialize() 
		{		
			//alert("OONLOAD");
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
			var contentString = '<div align="center">관광지</div>';//= '<div>' +
			//'<h2>위즈소프트</h2>'+
			//'<p>위즈소프트는 WEB Agency & SI 분야에서 10년 이상의 풍부한 경험을 보유한<br />' +
            //'전문 인력으로 구성된 E-Business 전문 기업입니다.</p>' +
            //'<img src="imgs/sqlmapconfig.PNG">'+
			//'<a href="http://www.daegu.go.kr" target="_blank">http://www.daegu.go.kr</a>'+ //링크도 넣을 수 있음
			//'</div>';

			var myLatlng = new google.maps.LatLng(X_point, Y_point);
			var mapOptions = {zoom: zoomLevel, center: myLatlng, mapTypeId: google.maps.MapTypeId.ROADMAP}
			map = new google.maps.Map(document.getElementById("map_view"), mapOptions);
			geocoder = new google.maps.Geocoder();

			infowindow = new google.maps.InfoWindow({content: contentString, maxWidth: markerMaxWidth, maxHeight:markerMaxHeight});
			
			markerInit();
			google.maps.event.addListener(marker, 'click', function() {
				infowindow.open(map, marker);
			});	
		}
		
		function markerInit()
		{			
			for(var i = 0 ; i < count ; i++)
			{
				markerDrops(i, i * 300);
			}	
		}	
		
		function markerDrops(i, time)
		{
			window.setTimeout(function() {
				latLng = new google.maps.LatLng(xcoords[i], ycoords[i]);
				markerTitle = titles[i];
				marker.push(new google.maps.Marker({position: latLng, map: map, title: markerTitle, draggable:false, animation: google.maps.Animation.DROP}));
				infowindow = new google.maps.InfoWindow({content: markerTitle, maxWidth: 500, maxHeight:100});
				infowindow.open(map, marker[i]);
			  }, time);			
			//alert(marker.length);
		}
		
		function Bounce(idx) 
		{
			map.setCenter(marker[idx].position);
			marker[idx].setAnimation(google.maps.Animation.BOUNCE);	
			infowindow.open(map, marker);
		}
		function bounceStop(idx)
		{
			if(marker[idx].getAnimation() != null)
			{
				marker[idx].setAnimation(null);
			}
			//infowindow.close();
		} 
		</script>
	
	<style type="text/css">
		#map_view{
			position: absolute;
		    left: 50%;
		    top: 55px;
		    z-index: 3;
		    width: 50%;
		    height: 75%;
		}
	</style>
</head>
	<!-- <body onload="initialize()"> -->
	<body>
	<div id="map_view">	
	</div>
	<!-- <form name="aForm" action="mapData" method="post" onkeydown="if(event.keyCode==13) return false;">	
	<input type="submit" value="test" /> -->
	<!-- </form>	 -->
	<!-- <img src="/imgs/tile.jpg" onmouseover="Bounce()" onmouseleave="bounceStop()"> -->
</body>
</html>