<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
<script src="js/ie-emulation-modes-warning.js"></script>
</head>

<body>
	<c:if test="${not empty authFail}">
		<script>
			alert("로그인이 필요합니다.");
		</script>
	</c:if>
	<nav class="navbar navbar-inverse navbar-fixed-top">
		<div class="container">
			<%@ include file="attach/header.jsp"%>
		</div>
	</nav>

	<div class="jumbotron" style="background: url('images/img2.jpg'); background-size: 100%;">
		<div class="container" align="center">
			<h1 style="color: white">Hello, world!</h1>
			<br> <br> <br>
		</div>
		<div class="row">
			<div class="col-md-8 col-md-offset-2">
				<form class="form-inline" action="searchHost" method="post">
					<div class="form-group">
						<input type="text" class="form-control" name="destination" placeholder="어디로 가세요?">
					</div>
					<div class="form-group">
						<input type="date" class="form-control" name="departDate">
					</div>
					&nbsp;&nbsp;<a style="color: white; font-size: 20px; font-weight: bold;">→</a>&nbsp;&nbsp;
					<div class="form-group">
						<input type="date" class="form-control" name="destDate">
					</div>
					<div class="form-group">
						<select class="form-control col-md-2" name="findCapacity">
							<c:forEach begin="1" end="16" var="n">
								<option value="${n}">숙박인원 ${n}명</option>
							</c:forEach>
							<option value="17">숙박인원 16+명</option>
						</select>
					</div>
					<div class="form-group">
						<button type="submit" class="form-control btn btn-primary">숙소 검색</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<div class="container">
		<div class="row">
			<c:forEach var="p" items="${pList}">
				<fmt:formatDate value="${p.regDate}" pattern="yyyy.MM.dd" var="regDate" />
				<div class="col-md-4 link_page">
					<img alt="" src="/semiProject01/down?path=${p.imgPath}/&realName=${p.imgRealName}&draw=Y" width="90%" class="img-rounded">
					<h3>${p.houseDesc}</h3>
					<span>${p.houseCost}<span class="fa fa-krw" aria-hidden="true"></span>
						/ day
					</span>
					<span style="padding-left: 110px">${regDate}</span>
					<br>
					<br>
					<p>
						<a class="btn btn-default" href="/semiProject01/detail?hostNo=${p.hostNo}" role="button">상세보기&raquo;</a>
					</p>
				</div>
			</c:forEach>
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
