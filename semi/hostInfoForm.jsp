<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="en"  style="min-height: 800px; overflow: hidden;">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<link rel="icon" href="../../favicon.ico">

<title>GroundBnB</title>

<link href="css/bootstrap.min.css" rel="stylesheet">

<link href="css/jumbotron.css" rel="stylesheet">

<script src="js/ie-emulation-modes-warning.js"></script>
<link href="css/bootstrap-social.css" rel="stylesheet">
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.6.0/css/font-awesome.min.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/ie10-viewport-bug-workaround.js"></script>
<!-- 구글 맵 -->
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBoH5tLttmCw5zCZf5i0tlFeQlVwnLiCgM&sensor=false" type="text/javascript"></script>	
<script>
var marker;
var markerTitle;
var infowindow;
var map;
var contentString;
var geocoder;
var myCity;
var X_point;
var Y_point;
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
	
	function fixMapCenter()
	{
		return map.setCenter(new google.maps.LatLng(marker.position.lat(), marker.position.lng()-0.0022131147));
	}
	
	function mapInit() 
	{		
		/*
			http://openapi.map.naver.com/api/geocode.php?key=f32441ebcd3cc9de474f8081df1e54e3&encoding=euc-kr&coord=LatLng&query=서울특별시 강남구 강남대로 456
                       위와같이 링크에서 뒤에 주소를 적으면 x,y 값을 구할수 있다.
		*/
		//X_point			= "37.49794199999999";		// Y 좌표
		//Y_point			= "127.02762099999995";		// X 좌표

		var zoomLevel		= 16;						// 지도의 확대 레벨 : 숫자가 클수록 확대됨

		markerTitle		= "마커를 드래그해 위치를 지정하세요";		// 현재 위치 마커에 마우스를 올렸을때 나타나는 정보
		var markerMaxWidth	= 1000;						// 마커를 클릭했을때 나타나는 말풍선의 최대 크기
		var markerMaxHeight = 1000;

		// 말풍선 내용
		contentString = "<h5>마커를 드래그해 위치를 지정하세요</h5>";
		//'<h2>위즈소프트</h2>'+
		//'<p>위즈소프트는 WEB Agency & SI 분야에서 10년 이상의 풍부한 경험을 보유한<br />' +
           //'전문 인력으로 구성된 E-Business 전문 기업입니다.</p>' +
           //'<img src="imgs/sqlmapconfig.PNG">'+
		//'<a href="http://www.daegu.go.kr" target="_blank">http://www.daegu.go.kr</a>'+ //링크도 넣을 수 있음
		//'</div>';

		var myLatlng = new google.maps.LatLng(X_point, Y_point);
		var mapOptions = {zoom: zoomLevel, center: new google.maps.LatLng(X_point, Y_point-0.0022131147), mapTypeId: google.maps.MapTypeId.ROADMAP}
		map = new google.maps.Map(document.getElementById('MapPanel'), mapOptions);
		geocoder = new google.maps.Geocoder();
		/*
		var bounds = new google.maps.LatLngBounds();
		var coo = new Array(new google.maps.LatLng(37.49794199999999, 127.02762099999995), 
							new google.maps.LatLng(37.59794199999999, 127.12762099999995));
		bounds.extend(coo[0]);
		bounds.extend(coo[1]);
		map.fitBounds(bounds);
		console.log(map.fitBounds);
		*/
		
		marker = new google.maps.Marker({position: myLatlng, map: map, title: markerTitle, 
										draggable:true, animation: google.maps.Animation.DROP});		
		//console.dir(marker);

		infowindow = new google.maps.InfoWindow({content: contentString, maxWidth: markerMaxWidth, maxHeight:markerMaxHeight});
		infowindow.open(map, marker);
		/* google.maps.event.addListener(marker, 'click', function() {
			infowindow.open(map, marker);
		}); */
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
					//document.getElementById("myModal").style.display = "inline-block";
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
			    	
			    	/* var longC = "<h3 style='text-align: center;'>주소를 고르세요</h3><select>";
				    for(var i = 0 ; i < results.length-1 ; i++)
				   	{
				    	longC = longC + "<option>" + results[i].formatted_address + "</option>";					    	
				   	}
				    longC = longC + "</select></div>";
				    infowindow.setContent(longC); */
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
			     	document.getElementsByName("nation")[0].value = nation;
			     	document.getElementsByName("zipCode")[0].value = postal;;
			     	document.getElementsByName("addr")[0].value = stringAddr;
			     	document.getElementsByName("xPoint")[0].value = xPoint;
			     	document.getElementsByName("yPoint")[0].value = yPoint;
			     	//aForm.nation.value = nation;
			     	//aForm.zipCode.value = postal;
			     	//aForm.addr.value = stringAddr;
			     	//aForm.xPoint.value = xPoint;
			     	//aForm.yPoint.value = yPoint;
					//infowindow.open(map, marker);
					// 맵에 비치는 중앙 지역을 마커의 위치로. 
					fixMapCenter();
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
		var addr = document.getElementsByName("addr")[0].value;
		//alert(addr);
		// 지오코딩 모드일땐 'address' 키워드로 생성.
		geocoder.geocode({'address':addr}, function(results, status)
		{
			if (status == google.maps.GeocoderStatus.OK && results.length > 0) 
			{					
				// results[0].geometry.location.lat() 과
				// results[0].geometry.location.lng() 값으로 분리되서 날아온다.
				//infowindow.setContent(contentString + "여기좌표:" + results[0].geometry.location.lat() +","+ results[0].geometry.location.lng());
				// results[0] 결과값엔 formatted_address 로 바로 주소 문자열을 얻어올수도 있다.
		     	var stringAddr = results[0].formatted_address;
		     	var nation = returnNation(results);
		     	var postal = returnPostal(results);
	     		stringAddr = stringAddr.replace(nation, "").replace(/(^\s*)|(\s*$)/gi, "");
	     		var xPoint = results[0].geometry.location.lat();
		     	var yPoint = results[0].geometry.location.lng();
		     	// 폼이름.폼내부의컨트롤이름.컨트롤의value = 자바스크립트 변수
		     	// 이렇게 하면 자바스크립트상의 변수를 해당 폼의 해당 컨트롤 value 로 넣을수 있다.
		     	document.getElementsByName("nation")[0].value = nation;
		     	document.getElementsByName("zipCode")[0].value = postal;;
		     	document.getElementsByName("addr")[0].value = stringAddr;
		     	document.getElementsByName("xPoint")[0].value = xPoint;
		     	document.getElementsByName("yPoint")[0].value = yPoint;
		     	//aForm.nation.value = nation;
		     	//aForm.zipCode.value = postal;
		     	//aForm.addr.value = stringAddr;
		     	//aForm.xPoint.value = xPoint;
		     	//aForm.yPoint.value = yPoint;
		     	// 마커 위치는 google.maps.LatLng() 객체를 새로 생성해서 X,Y좌표를 생성자에 던져주면 이동 가능.
		     	marker.setPosition(new google.maps.LatLng(results[0].geometry.location.lat(),results[0].geometry.location.lng()));
				infowindow.open(map, marker);
				// 맵에 비치는 중앙 지역을 마커의 위치로.
				fixMapCenter();
				//map.setCenter(marker.position);
			} 
			else 
			{
			      window.alert('Geocoder failed due to: ' + status);
			}
		});
	}
	</script>

</head>

<body style="min-height: 800px; overflow: hidden;">
		<%@ include file="attach/header.jsp"%>
		<!-- 코드시작 -->
		<%@ include file="houseForm.jsp" %>		
		<!-- 코드종료 -->
		<footer style="position:absolute; left: 0px; bottom: 20px; z-index: -100;">
		<%@ include file="attach/footer.jsp"%>
		</footer>
<script type="text/javascript">
	var thisMode = "";
	//var maxYear;
	(function isModify(bool)
	{
		thisMode = bool;
		//alert(bool);
		//alert(thisMode);
		if(thisMode == 'InsertMode')		// 입력일때
		{
			X_point	= "37.49794199999999";		// Y 좌표
			Y_point	= "127.02762099999995";		// X 좌표
			//var sdf = new SimpleDateFormat("yyyy-MM-dd");
			var curDay = new Date();
			//curDay = curDay.getFullYear() + "-" + (curDay.getMonth()+1) + "-" + curDay.getDate();
			document.getElementsByName("startDate")[0].min = curDay;
			document.getElementsByName("endDate")[0].min = curDay;
			//curDay = new Date();
			//maxYear = new Date(curDay.getFullYear()+1, curDay.getMonth() + 1, curDay.getDate());
			//document.getElementsByName("startDate")[0].max = maxYear;
			//document.getElementsByName("endDate")[0].max = maxYear;
		}
		else if(thisMode == 'UpdateMode')	// 수정일때
		{
			X_point = '${l.xPoint}';
			Y_point = '${l.yPoint}';
			document.getElementsByName("startDate")[0].min = document.getElementsByName("startDate")[0].value;
			/* 1단계 데이터들 로딩 */
			document.getElementsByName("houseType")[0].value = '${d.houseType}';
			var roomTypeRadio = document.getElementsByName("roomType");
			var rType = '${d.roomType}';
			for(var i = 0 ; i < roomTypeRadio.length ; i++)
			{
				if(roomTypeRadio[i].value == rType)
				{
					roomTypeRadio[i].checked = true;
				}
			}
			document.getElementsByName("houseCapacity")[0].value = '${d.houseCapacity}';
			document.getElementsByName("houseRoom")[0].value = '${d.houseRoom}';
			document.getElementsByName("houseBed")[0].value = '${d.houseBed}';
			document.getElementsByName("houseBath")[0].value = '${d.houseBath}';
			/* 2단계 데이터 로딩 */
			document.getElementsByName("nation")[0].value = '${l.nation}';
			document.getElementsByName("addr")[0].value = '${l.addr}';
			document.getElementsByName("zipCode")[0].value = '${l.zipCode}';
			document.getElementsByName("detailAddr")[0].value = '${l.detailAddr}';
			document.getElementsByName("xPoint")[0].value = X_point;
			document.getElementsByName("yPoint")[0].value = Y_point;
			/* 3단계 데이터 로딩 */
			document.getElementsByName("cost")[0].value = '${p.houseCost}';
			document.getElementsByName("startDate")[0].value = '${sDate}';
			document.getElementsByName("endDate")[0].value = '${eDate}';
			document.getElementsByName("houseDesc")[0].value = '${p.houseDesc}';
			document.getElementsByName("hostDetail")[0].value = '${d.houseDetail}';
			//document.getElementsByName("hostEmailH")[0].value = "${email}";
			/* 4단계 데이터 로딩 */
			document.getElementById("form").action = "hostUpdate";
			document.getElementById("submitBtn").value = "수정완료";
		}
	})('${istrue}');
	/* 상세정보 입력 관련 변수 */
	/* var hostNum;
	var houseType;
	var roomType;
	var hostState;
	var houseCapacity;
	var houseRoom;
	var houseBed;
	var houseBath; */
	/* 위치정보 입력 관련 변수 */
	/* var nation;
	var addr;
	var zipCode;
	var detailAddr;
	var xPoint;
	var yPoint; */
	/* 미리보기 입력 관련 변수 */
	/* var email;
	var hostDate;
	var houseImg;
	var houseDesc;
	var houseCost; */
	
	/* 입력 단계별 처리 함수 부분 */
	function inputData(step)
	{		
		switch(step)
		{
		case "step1":
			/* var email = ${email};
			alert(email); */
			document.getElementsByName("houseTypeH")[0].value = document.getElementsByName("houseType")[0].value;
			var roomTypeRadio = document.getElementsByName("roomType");
			for(var i = 0 ; i < roomTypeRadio.length ; i++)
			{
				if(roomTypeRadio[i].checked == true)
				{
					document.getElementsByName("roomTypeH")[0].value = roomTypeRadio[i].value;
				}
			}
			//document.getElementsByName("hostStateH")[0].value = false;
			document.getElementsByName("houseCapacityH")[0].value = document.getElementsByName("houseCapacity")[0].value;
			document.getElementsByName("houseRoomH")[0].value = document.getElementsByName("houseRoom")[0].value;
			document.getElementsByName("houseBedH")[0].value = document.getElementsByName("houseBed")[0].value;
			document.getElementsByName("houseBathH")[0].value = document.getElementsByName("houseBath")[0].value;
			// 테스트용 얼럿창
			/* alert("집종류:"+document.getElementsByName("houseTypeH")[0].value+"\n"
					+"방종류:"+document.getElementsByName("roomTypeH")[0].value+"\n"
					//+"예약상태:"+document.getElementsByName("hostStatusH")[0].value+"\n"
					+"수용인원:"+document.getElementsByName("houseCapacityH")[0].value+"\n"
					+"침실갯수:"+document.getElementsByName("houseRoomH")[0].value+"\n"
					+"침대갯수:"+document.getElementsByName("houseBedH")[0].value+"\n"
					+"욕실갯수:"+document.getElementsByName("houseBathH")[0].value); */
			break;
		case "step2":
			document.getElementsByName("nationH")[0].value = document.getElementsByName("nation")[0].value;
			document.getElementsByName("addrH")[0].value = document.getElementsByName("addr")[0].value;
			document.getElementsByName("zipCodeH")[0].value = document.getElementsByName("zipCode")[0].value;
			document.getElementsByName("detailAddrH")[0].value = document.getElementsByName("detailAddr")[0].value;
			document.getElementsByName("xPointH")[0].value = document.getElementsByName("xPoint")[0].value;
			document.getElementsByName("yPointH")[0].value = document.getElementsByName("yPoint")[0].value;
			//테스트용 얼럿창
			/* alert("국가:"+document.getElementsByName("nationH")[0].value+"\n"
					+"주소:"+document.getElementsByName("addrH")[0].value+"\n"
					+"우편번호:"+document.getElementsByName("zipCodeH")[0].value+"\n"
					+"상세주소:"+document.getElementsByName("detailAddrH")[0].value+"\n"
					+"X좌표:"+document.getElementsByName("xPointH")[0].value+"\n"
					+"Y좌표:"+document.getElementsByName("yPointH")[0].value); */
			break;
		case "step3":
			document.getElementsByName("costH")[0].value = document.getElementsByName("cost")[0].value;
			document.getElementsByName("startDateH")[0].value = document.getElementsByName("startDate")[0].value;
			document.getElementsByName("endDateH")[0].value = document.getElementsByName("endDate")[0].value;
			document.getElementsByName("houseDescH")[0].value = document.getElementsByName("houseDesc")[0].value;
			document.getElementsByName("hostDetailH")[0].value = document.getElementsByName("hostDetail")[0].value;			
			document.getElementsByName("hostEmailH")[0].value = "${email}";
			
			/*
			alert("요금:"+document.getElementsByName("costH")[0].value+"\n"
					+"시작일:"+document.getElementsByName("startDateH")[0].value+"\n"
					+"종료일:"+document.getElementsByName("endDateH")[0].value+"\n"
					+"소개제목:"+document.getElementsByName("houseDescH")[0].value+"\n"
					+"소개내용:"+document.getElementsByName("hostDetailH")[0].value+"\n"
					+"이메일:"+document.getElementsByName("hostEmailH")[0].value); */
			break;
		case "step4":
			break;
		}
	}
	function calcDate()
	{
		var cost = document.getElementsByName("cost")[0].value;
		
		var sDateV = document.getElementsByName("startDate")[0].value;
		var sDateArr = sDateV.split("-");
		document.getElementsByName("endDate")[0].min = sDateV;
		//document.getElementsByName("endDate")[0].max = maxYear;
		
		var eDateV = document.getElementsByName("endDate")[0].value;
		var eDateArr = eDateV.split("-");
		//alert(sDateArr[0] + sDateArr[1] + sDateArr[2]);
		var sDate = new Date(sDateArr[0], sDateArr[1], sDateArr[2]);
		var eDate = new Date(eDateArr[0], eDateArr[1], eDateArr[2]);
		var interval = eDate.getTime() - sDate.getTime();
		var intervalDate = Math.floor(interval / (1000 * 60 * 60 * 24));
		
		/* 3군데 다 입력됬을때만 총 요금을 계산. */		
		if(cost != "" && sDateV != "" && eDateV != "")
		{ document.getElementsByName("costResult")[0].value = (intervalDate + 1) * parseInt(cost); }
	}
  /* function onDragEnter(event)
  {    
  	event.preventDefault();                            
  }    
  function onDragOver(event)
  {    
    event.preventDefault();      
  }                  
  function onDrop(event){  
	var dropBox = document.getElementById("dropbox");          
	//var dropImage = document.createElement("img");
    event.stopPropagation();
    event.preventDefault(); 
    var file = event.dataTransfer.files[0];      
             
    var reader = new FileReader();    
    
    reader.onload = (function(aFile){return function(e) 
    {         
        var result = e.target.result; 
          //dropImage.src = result;                                                                            
          dropBox.innerHTML = "<img src='"+result+"'/>";               
    }; 
      })(file);
      
    reader.readAsDataURL(file);
  }  */                     
  
  /* dropImage.addEventListener("load", function(e) {
    //이미지 로딩 시 추가 처리할 로직 기입(사이즈 조절 등)           
  }, true);  */         
</script>
<script type="text/javascript">
/* 이미지 전환을 위한 자바스크립트 공간 */

var mapPanel = document.getElementById("MapPanel");
var img1 = document.getElementById("img1");
var img2 = document.getElementById("img2");
var img3 = document.getElementById("img3");
var slideArray = new Array(img1, mapPanel, img2, img3);

var slideMax = slideArray.length - 1;
var curSlideNo = 0;
var nextSlideNo = null;
var fadeStart = false;
var curSlideLevel = 1;
var nextSlideLevel = 0.3;

for (i = 0; i <= slideMax; i++) {
	if (i == curSlideNo)
	{
		changeOpacity(slideArray[i], 1);
	}
	else 
	{
		changeOpacity(slideArray[i], 0);
	}
}

function startSlide(dir)
{
	if (fadeStart === true) return;
	if( dir == "prev" ) 
	{
		nextSlideNo = curSlideNo - 1;
		//console.log("prevmove:"+curSlideNo +"->"+nextSlideNo);
		// nextSlideNo 가 1번 일때 맵 띄우기
		if ( nextSlideNo < 0 ) nextSlideNo = slideMax;
	}
	else if( dir == "next" ) 
	{
		nextSlideNo = curSlideNo + 1;
		//console.log("nextmove:"+curSlideNo+"->"+nextSlideNo);
		// nextSlideNo 가 1번 일때 맵 띄우기
		if ( nextSlideNo > slideMax ) nextSlideNo = 0;
	}
	else
	{
		fadeStart = false;
		return;
	}
	// nextSlideNo 가 1번 일때 맵 띄우기
	//console.log("현재"+nextSlideNo);
	
	if(nextSlideNo == 1)
	{
		mapPanel.style.width = "100%";
		mapPanel.style.height = "800px";
		if(map == null){ mapInit(); } 
	}else
	{ 
		mapPanel.style.width = "0%";
		mapPanel.style.height = "0px";
		//map = null;
	}
	fadeStart = true;
	changeOpacity(slideArray[curSlideNo], curSlideLevel);
	changeOpacity(slideArray[nextSlideNo], nextSlideLevel);
	fadeInOutAction(dir);
}

function fadeInOutAction(dir)
{
	curSlideLevel = curSlideLevel - 0.1;
	nextSlideLevel = nextSlideLevel + 0.1;
	if( curSlideLevel <= 0 ) 
	{
		changeOpacity(slideArray[curSlideNo], 0);
		changeOpacity(slideArray[nextSlideNo], 1);
		if(dir == "prev")
		{
			curSlideNo = curSlideNo - 1;
			if (curSlideNo < 0) curSlideNo = slideMax;
		}
		else
		{
			curSlideNo = curSlideNo + 1;
			if (curSlideNo > slideMax) curSlideNo = 0;
		}
		curSlideLevel = 1;
		nextSlideLevel = 0.3;
        fadeStart = false;
		return;
	}
	changeOpacity(slideArray[curSlideNo], curSlideLevel);
	changeOpacity(slideArray[nextSlideNo], nextSlideLevel);
	setTimeout(function () {
		fadeInOutAction(dir);
	}, 100);
}

function changeOpacity(obj,level)
{
	//console.dir("arrays:"+slideArray);
	//console.log("objs"+obj);
	obj.style.opacity = level; 
	obj.style.MozOpacity = level; 
	obj.style.KhtmlOpacity = level;
	obj.style.MsFilter = "'progid:DXImageTransform.Microsoft.Alpha(Opacity=" + (level * 100) + ")'";
	obj.style.filter = "alpha(opacity=" + (level * 100) + ");";	
}

</script>
	
</body>
</html>
