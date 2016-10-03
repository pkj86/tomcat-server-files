window.onload = getMyLocation;

function getMyLocation(){
	if(navigator.geolocation){
		console.log("위치정보 지원함");
		
		var watchBtn = document.getElementById("watch");
		watchBtn.onclick = watchLocation;
		
		var clearWatchBtn = document.getElementById("clearWatch");
		clearWatchBtn.onclick = clearWatch;
	}else{
		console.log("위치정보 지원하지 않음");
	}
}

var watchId = null;
function watchLocation(){
	// 옵션 활용
	var watchOption = {
		enableHighAccuracy: true,
		timeout: 3000
	};
	watchId = navigator.geolocation.watchPosition(
							displayLocation, displayError, watchOption);
}
function claerWatch(){
	navigator.geolocation.clearWatch(watchId);
}

// 이전 좌표 정보 기억
var prevCoodrs = null;

// 위치정보 조회 성공시 호출 콜백함수
function displayLocation(position){
	// 위도 가져오기
	var latitude = position.coords.latitude;
	// 경도 가져오기
	var longitude = position.coords.longitude;
	
	// 위치를 보여줄 객체 조회
	var location = document.getElementById("location");
	location.innerHTML = "당신의 위치 : 위도(" + latitude + "), 경도(" + longitude + ")<br />"
						 + "정확도 : " + position.coords.accuracy + "meter";
	
	// 두 지점간의 거리를 km로 반환
	var km = computeDistance(position.coords, ourCoords);
	var distance = document.getElementById("distance");
	distance.innerHTML = "강남역까지의 거리 : " + km + "km";
	
	// 거리가 20m 이상일 경우에만 마커를 추가
	// 지도관련 함수 호출
	if(map == null){
		showMap(position.coords);
		prevCoodrs = position.coords;
	} else {
		var meters = computeDistance(position.coords, prevCoodrs) * 1000;
		if (meters > 20) {
			// 새로운 위치로 지도를 이동시키고 마커 추가
			mapToPosition(position.coords);
			prevCoodrs = position.coords;
		}
	}
	
	
}

var map = null;

function showMap(coords){
	// 위치 정보 객체 생성
	var latAndLng = new google.maps.LatLng(coords.latitude, coords.longitude);
	
	var mapOptions = {
		zoom: 10, // 0 ~ 21 까지 설정 가능, 숫자가 클수록 확대
		center: latAndLng, // 지도의 중심 좌표 설정 
		mapTypeId: google.maps.MapTypeId.ROADMAP // ROADMAP(도로), SATELLITE(위성), HYBRID
	};
	// 지도를 표시할 영역
	var mapDiv = document.getElementById("map");
	// 지도 객체 생성(화면상에 생성된 맵 객체를 보여줄 영역과 생성할 때 사용할 옵션)
	map = new google.maps.Map(mapDiv, mapOptions);
	
	// 마커에 마우스를 올렸을때 보여줄 툴팁
	var title = "당신의 현재 위치입니다.";
	// InfoWindow 객체에 보여줄 컨텐츠
	var content = "위치(위도 : " + coords.latitude + ", 경도 : " + coords.longitude + ")";
	// 마커추가 함수 호출
	addMarker(map, latAndLng, title, content);
	
}

// 위치정보 조회 실패시 호출 콜백함수
function displayError(error){
	var errorTypes = 
		["알려지지 않은 에러 발생", "권한 거부", "위치 정보를 찾지 못함", "요청 응답시간 초과"];
	
	var errHtml = errorTypes[error.code];
	
	console.log(errorTypes[error.code]);
	if(error.code == 0 || error.code == 2){
		console.log(error.message);
		errHtml += "<br />" + error.message;
	}
	
	var location = document.getElementById("location");
	location.innerHTML = errHtml;
	
}

//참고 주소 (location 정보 가져옴)
//http://maps.googleapis.com/maps/api/geocode/xml?address=%EA%B0%95%EB%82%A8%EC%97%AD&language=ko&sensor=false
var ourCoords = {
		latitude: 37.4979420,
		longitude: 127.0276210
}

/**
 *  출발지와 목적지의 거리를 km로 반환
 *  구면 코사인 법칙 : 구면 삼각법
 */
function computeDistance(startCoords, destCoords) {
	var startLatRads  = degreesToRadians(startCoords.latitude );
	var startLongRads = degreesToRadians(startCoords.longitude);
	var destLatRads   = degreesToRadians(destCoords.latitude  );
	var destLongRads  = degreesToRadians(destCoords.longitude );

	var Radius = 6371; // radius of the Earth in km 지구 둘레 
	var distance = Math.acos(
			       		Math.sin(startLatRads) * Math.sin(destLatRads) + 
			       		Math.cos(startLatRads) * Math.cos(destLatRads) *
			       		Math.cos(startLongRads - destLongRads)
			       ) * Radius;

	return distance;
}
/**
 *  1(라디안) = 180 / Math.PI, 1(degree) = Math.PI / 180
 *  반지름이 1일 경우 원의 전체 둘레 : 2 * Math.PI
 */
function degreesToRadians(degrees) {
	radians = (degrees * Math.PI) / 180;
	console.log(degrees  + " - " + (degrees * Math.PI) + " - " + radians);
	return radians;
}

function addMarker(map, latlng, title, content){
	var markerOption = {
			position: latlng, // 마커 생성 위치
			map: map,
			title: title, 	  // 마우스를 클릭할 때 보여줄 툴팁
			clickable: true,  // 클릭시 정보창을 보여주기 위해 true 설정
	};
	
	// 마커 객체 생성
	var marker = new google.maps.Marker(markerOption);
	
	// 마커 클릭 시 정보창에 대한 옵션
	var infoWindowOptions = {
			content: content,
			position: latlng
	}
	
	var infoWindow = new google.maps.InfoWindow(infoWindowOptions);
	
	// 마커 클릭 이벤트 설정
	google.maps.event.addListener(marker, "click", function(){
		infoWindow.open(map);
	});
}

/**
 * 지도 좌표 정보를 매개변수로 받아서 해당 위치로 지도를 이동시키고
 * 해당 위치에 마커를 추가
 * @param coords
 */
function mapToPosition(coords) {
	var latitude = coords.latitude;
	var longitude = coords.longitude;
	
	var latlng = new google.maps.LatLng(latitude, longitude);
	
	// 새로운 위치가 지도 중앙에 오도록 지도를 이동
	map.panTo(latlng);
	
	var title = "새로운 위치로 이동됨";
	var content = "위치 : " + latitude + ", " + longitude;
	addMarker(map, latlng, title, content);
}











