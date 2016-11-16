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

<script src="js/ie-emulation-modes-warning.js"></script>

</head>

<body>


	<%@ include file="attach/header.jsp"%>



	<div class="container">
		<br>
		<div class="row">
			<div class="col-md-6 col-md-offset-3">
			<form class="form-inline" method="post" accept-charset="utf-8" action="/semiProject01/pwUpdate">
				<div class="panel panel-default">
					<div class="panel-heading">
						<c:if test="${not empty msg}">
							<h3 class="panel-title" style="color: #c9302c;">*${msg}</h3>
						</c:if>
						<c:if test="${empty msg}">
							<h3 class="panel-title">Change password</h3>
						</c:if>
					</div>
					<div class="panel-body">
						<div class="form">
							
							<label for="oldpw">Old password</label> 
							<br>
							<input type="password" name="oldpw" class="form-control" id="oldpw" width="50%" required>
							<br>
							<br>
							<label for="newpw">New password</label> 
							<br>
							<input type="password" name="newpw" class="form-control" id="newpw" width="50%" required>
							<h6 style="color: gray;">Use at least four characters.</h6>
							<br>
							<input type="submit" class="form-control btn btn-primary" value="Update password">
						</div>
					</div>
				</div>
			</form>
			<br>
			<form class="form-inline" method="post" accept-charset="utf-8" action="/semiProject01/nameUpdate">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">Change username</h3>
					</div>
					<div class="panel-body">
						<div class="form" >
							<label for="newname">New username</label> 
							<br>
							<input type="text" name="newname" class="form-control" id="newname" width="50%" required>
							<br>
							<br>
							<input type="submit" class="form-control btn btn-primary" value="Update username">
						</div>
					</div>
				</div>
			</form>
			<br>
			<form class="form-inline" method="post" accept-charset="utf-8" action="/semiProject01/deleteAccount">
				<div class="panel panel-danger">
					<div class="panel-heading">
						<h3 class="panel-title">Delete account</h3>
					</div>
					<div class="panel-body">
						<div class="form">
						<input type="submit" class="form-control btn btn-danger" value="Delete your account">
						</div>
					</div>
				</div>
			</form>
				<br>
		
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
