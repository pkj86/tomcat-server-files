<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- 

 -->
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
<title>숙소의 좌표를 마커로 표현하기</title>
<style type="text/css">
	*{word-break:break-all;}
	html, body{		
		margin: 0; padding: 0;
	}
	#map{
		position: absolute;
	    left: 0px;
	    top: 0px;
	    z-index: 3;
	    width: 50%;
	    height: 100%;
	    overflow: auto;
	}
	label{
		border: 2px solid blue;
		position:absolute;
		margin-top:35%; 
		left:25%; right:25%;
		visibility:inherit;
		line-height:100%;
		color: yellow;
		vertical-align:middle;		
		z-index: 1000;		
	}
	#back{		
		text-align: center;
		visibility:hidden;		
		position:absolute;
		background-color: black;
		background-position: center center;
		left:0px; top: 0px;
		opacity: 0.8;
		width: 250px; height: 250px;
		z-index: 1100;
	}
	img{z-index: 0;}
	#top{float: left; margin: 20px; position: relative; width: 250px; height: 250px; display:table; border:2px solid red; z-index: 9000;}
	#top:HOVER > #back{		
		visibility: visible;
	}
</style>
</head>
<body onload="initMarker(${fn:length(list)})" >
<div class="w3-row">
  <div class="w3-green w3-container w3-half" id="map" >
    <table>
	<tr>
	<td>여기는 숙소 목록 나오는 곳<br>
	<c:forEach items="${list}" var="vo" varStatus="idx">
	<div id="top" onmouseover="Bounce(${idx.index})" onmouseout="bounceStop(${idx.index})">	
		<img src="../imgs/ba.png" width="250px" height="250px" />
		<div id="back">
			<label><c:out value="${vo.addrString}" /></label>
		</div>
	</div>
		<input type="hidden" name="VOaddr" value="${vo.addrString}"/>
		<input type="hidden" name="VOx" value="${vo.xCoord}"/>
		<input type="hidden" name="VOy" value="${vo.yCoord}"/>				
	</c:forEach>
	</td>
	
	</tr>
	</table>
  </div>
  <div class="w3-container w3-half">
    <%@ include file="MapSample2.jsp" %>
  </div>
</div>
		<%--><nav id="map" class="w3-sidenav w3-white">
			<a><%@ include file="MapSample.jsp" %></a>		
		</nav>--%>
</body>
</html>