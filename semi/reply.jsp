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



	<div class="container">
		<!--  코드시작 -->
		
		<div id="reply">
			<form method="post" action="replyReg">
				<table class="replyTable">
					<tr>
						<td><span class="replyInline">
									<input type="hidden" id="name" name="name" value="${user.name}">
									<input type="hidden" id="replyEmail" name="replyEmail" value="${user.replyEmail}"/>
									<input type="hidden" id="hostEmail" name="hostEmail" value="${user.hostEmail}">
								    <textarea id="content" name="content" style="width: 100%" rows="4"></textarea>
									<button type="submit" id="submit" >후기등록</button>
						</span></td>
						<td><c:out value="${hostEmail}"/></td>
					</tr>	
				</table>
				<table class="table table-condensed">
					<tr>
						<td><span style='float: right'>
								<button type="button" id="update" class="">수정</button>
								<button type="button" id="delete" class="">삭제</button>
								<button type="button" id="write" class="">글쓰기</button>
						</span></td>
					</tr>
				</table>
			</form>
		</div>





		<footer>
			<%@ include file="attach/footer.jsp"%>
		</footer>
	</div>

	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/ie10-viewport-bug-workaround.js"></script>
</body>
</html>
