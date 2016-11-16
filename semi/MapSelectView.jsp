<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- 

 -->
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<link rel="icon" href="../../favicon.ico">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
<title>GroundBnB</title>
<style type="text/css">
	*{word-break:break-all;}
	html, body{		
		margin: 0; padding: 0;
		height: 100%;
		position: relative;
	}
	#map{
		position: absolute;
	    left: 0px;
	    top: 55px;
	    z-index: 3;
	    width: 50%;
	    height: 75%;
	    overflow: auto;
	}
	label{
		position:relative;
		top:20px;
		text-align:center;		
		z-index: 1000;	
		text-overflow:ellipsis;
		overflow: hidden;
		white-space: nowrap;
		width: 250px;
		text-align: left;
	}
	#back{		
		text-align: center;
		visibility:hidden;		
		position:absolute;
		background-color: black;
		background-position: center center;
		border:5px dotted yellow;
		border-radius:4%;
		left:0px; top: 0px;
		opacity: 0.3;
		width: 250px; height: 250px;
		z-index: 1100;
	}
	img{z-index: 0;}
	#top{float: left; margin: 20px; position: relative; width: 250px; height: 250px; display:table; z-index: 9000;}
	#top:HOVER > #back{		
		visibility: visible;
	}
	footer{
		width:100%;
		left:0px;
		bottom:0px;
		position: absolute;
	}
</style>
<link href="css/bootstrap.min.css" rel="stylesheet">

<link href="css/jumbotron.css" rel="stylesheet">
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
<script src="js/ie-emulation-modes-warning.js"></script>
</head>
<body onload="initMarker(${fn:length(resultList)})" >
<nav class="navbar navbar-inverse navbar-fixed-top">
	<div class="container">
		<%@ include file="attach/header.jsp"%>
	</div>
</nav>
<div class="container">
		<div class="row">
		<div class="w3-row">
		  <div class="w3-container w3-half" id="map" >
		    <table>
			<tr>
			<td><h3>예약할 숙소를 선택하세요</h3><br>
			<c:forEach items="${resultList}" var="vo" varStatus="idx">
			<div id="top" onmouseover="Bounce(${idx.index})" onmouseout="bounceStop(${idx.index})" onclick="goToDetail(${vo.hostNo});">	
				<!--<img src="../imgs/ba.png" width="250px" height="250px" />-->
				<img alt="" src="/semiProject01/down?path=${vo.imgPath}/&realName=${vo.imgRealName}&draw=Y" width="100%" class="img-rounded">
				<div id="back">
				</div>
				<label><c:out value="${vo.addr}" /></label><br>
				<label><c:out value="${vo.houseDesc}" /></label><br>
				<label><c:out value="일당 ${vo.houseCost} ￦" /></label>
			</div>
				<input type="hidden" name="VOaddr" value="${vo.addr}"/>
				<input type="hidden" name="VOx" value="${vo.xPoint}"/>
				<input type="hidden" name="VOy" value="${vo.yPoint}"/>				
			</c:forEach>
			</td>
			
			</tr>
			</table>
			
		  </div>
  
			  <div class="w3-container w3-half">
			    <%@ include file="MapSample2.jsp" %>
			  </div>
  	</div>
  </div>
<footer>
			<%@ include file="attach/footer.jsp"%>
			</footer>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/ie10-viewport-bug-workaround.js"></script>		
</body>
</html>