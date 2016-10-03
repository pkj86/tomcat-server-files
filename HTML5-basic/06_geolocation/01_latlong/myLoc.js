window.onload = getMyLocation;

function getMyLocation() {
	// 위치정보 지원 여부 확인
	if (navigator.geolocation) {
		console.log("위치정보 지원함");
		
		navigator.geolocation.getCurrentPosition(
				displayLocation, displayError);
	}
	else {
		console.log("위치정보 지원하지 않음")
	}
}

// 위치정보 조회 성공시 호출 콜백함수
function displayLocation(position) {
	// 위도 
	var latitude = position.coords.latitude;
	// 경도
	var longitude = position.coords.longitude;
	
	// 위치를 보여줄 객체 조회
	var location = document.getElementById("location");
	location.innerHTML = 
		"당신의 위치 : 위도(" + latitude + "), 경도(" + longitude + ")";
}

// 위치정보 조회 실패시 호출 콜백함수
function displayError(error) {
	var errorTypes = 
		["알려지지 않은 에러 발생", "권한 거부", "위치 정보를 찾지 못함", "요청 응답시간 초과"];
	
	var errHtml = errorTypes[error.code];
	
	console.log(errorTypes[error.code]);
	if (error.code == 0 || error.code == 2) {
		console.log(error.message);
		errHtml += "<br />" + error.message;  
	}
	
	var location = document.getElementById("location");
	location.innerHTML = errHtml;
}















