<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="en">
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

</head>

<body>


	<%@ include file="attach/header.jsp"%>




	<!--  코드시작 -->
<div class="jumbotron" style="background: url('images/pic1234.jpg'); background-size: 100%;">
		<div class="container" align="center">
			<h1 style="color: white">Hello, world!</h1>
			<br>
			<br>
			<br>
			<br>
		</div>
	</div>

		<div class="row">
			<c:forEach var="p" items="${pList}">
				<fmt:formatDate value="${p.regDate}" pattern="yyyy.MM.dd" var="regDate"/>
				<div class="col-md-4 link_page">
					<img alt="" src="/semiProject01/down?path=${p.imgPath}/&realName=${p.imgRealName}&draw=Y" width="90%" class="img-rounded">
					<h3>${p.houseDesc}</h3>
					<span>${p.houseCost}<span class="fa fa-krw" aria-hidden="true"></span> / day</span><span style="padding-left:110px">${regDate}</span><br><br>
					<p><a class="btn btn-default" href="/semiProject01/detail?hostNo=${p.hostNo}" role="button">상세보기&raquo;</a></p>
				</div>
			</c:forEach>
		</div>
<div class="row">
  <div class="col-md-6 col-md-offset-1">
  		<a type="button" class="btn btn-default btn-lg" href='/semiProject01/listAddress'>받은 쪽지함</a>
		<a type="button" class="btn btn-primary btn-lg" href='/semiProject01/listSend'>보낸 쪽지함</a>
  
  <table class="table table-striped" width='85%' border='1'>
			<tr>
				<th width='15%'>번호</th>
				<th width='20%'>수신자</th>
				<th>내용</th>
			</tr>
			<c:forEach var="aa" items="${list}">
				<tr>
					<td width='15%'><c:out value="${aa.no}" /></td>
					<td width='20%'><c:out value="${aa.addressee}"/></td>
					<td><c:out value="${aa.message}"/></td>
				</tr>
			</c:forEach>
			<c:if test="${empty list}">
				<tr>
					<td colspan='4'>게시물이 존재하지 않습니다.</td>
				</tr>
			</c:if>
		</table></div>
  		<div class="col-md-3 col-md-offset-1">
  			
		</div>
</div>

		<footer>
			<%@ include file="attach/footer.jsp"%>
		</footer>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/ie10-viewport-bug-workaround.js"></script>
</body>
</html>