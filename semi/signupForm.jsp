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

<title>GroundBnB</title>

<link href="css/bootstrap.min.css" rel="stylesheet">

<link href="css/signin.css" rel="stylesheet">
<link href="css/bootstrap-social.css" rel="stylesheet">

<script src="js/ie-emulation-modes-warning.js"></script>
<style>
body{
	padding-top:0px;
	padding-bottom:0px;	
}
</style>
</head>

<body>

	<div class="container-fluid">
		<div class="row">
			<div class="col-md-8" style="height:100%; background: url('images/signup.jpg') 0px no-repeat;">
				<div align="center">
					<br>
					<br>
					<br>
					<br>
					<br>
					<div style="background: url('images/gray.png') 0px repeat; display: inline-block">
						<br>
						<h1 style="color: white; padding: 0 100px;">지금 GroundBnB에 가입하세요!</h1>
						<br>
					</div>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
				</div>
			</div>
			<div class="col-md-4">
				<form class="form-signin" action="/semiProject01/signUp" method="post">
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<c:if test="${not empty msg}">
						<h3>${msg}</h3>
					</c:if>
					<c:if test="${empty msg}">
						<br>
					</c:if>
					<label for="inputName" class="sr-only">Name</label> 
					<input type="text" id="inputName" name="name" class="form-control" placeholder="Pick a username" required autofocus> 
					<br>
					<label for="inputEmail" class="sr-only">Email address</label> 
					<input type="email" id="inputEmail" name="email" class="form-control" placeholder="Your email address" required> 
					<br>
					<label for="inputPassword" class="sr-only">Password</label> 
					<input type="password" id="inputPassword" name="password" class="form-control" placeholder="Create a password" required>
					<h6 style="color: gray;">Use at least four characters.</h6>
					<button class="btn btn-lg btn-primary btn-block" type="submit">Sign up for GroundBnB</button>
					<br>
					<br>
				</form>

			</div>
		</div>
	</div>


	<script src="js/ie10-viewport-bug-workaround.js"></script>
</body>
</html>
