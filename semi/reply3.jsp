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
		<div id="reply">
			<form method="post" action="replyReg">
				<input type="hidden" name="no" value="${user.no}"/>
				<input type="hidden" name="hostNo" value="${user.hostNo}" />	
				<input type="hidden" name="name" value="${user.name}" />	
				<input type="hidden" name="email" value="${user.email}" />	 
				<table width="70%">
				<tr>
					<td><c:out value="${user.email}" /></td>
					<td><textarea name="content" rows="5" cols="100"></textarea></td>
					<td><input type="submit" value="등록" /></td>
				</tr>	
				</table>
			</form>
		</div>
		
		<form action="replyUpdate" method="post">
			<input type="hidden" name="email" value="${user.email}" />
			<input type="hidden" name="no" value="${user.no}" />
		<div id="replyList">
			
		  <table width='80%' border='1'>
		  <tr>
			<c:forEach var="reply" items="${replyList}">
			<c:choose>
		  		<c:when test="${user.no eq user.hostNo}">	
					<tr>
					  <td><c:out value="${user.name}" /></td>
					  <td>
					  	<textarea name="content" rows="5" cols="100"><c:out value="${comment.content}" /></textarea>
					  </td>
					  <td colspan="2">
					  	  <input type="submit" value="수정" />	
					  </td>
					 </tr>
			 	</c:when>
			 	<c:otherwise>
					<tr>
					  <td><c:out value="${user.name}" /></td>
					  <td>
					  		<c:out value="${user.content}" /></td>
					  <td><fmt:formatDate var="regDate" value="${user.regDate}" 
					                      pattern="yyyy-MM-dd HH:mm:ss" />
					      <c:out value="${regDate}" />
					  </td>
					  <td>
					  	  <a href="replyDelete?replyNo=${user.hostNo}&no=${user.no}">삭제</a>	
					  	  <a href="reply?replyNo=${user.hostNo}&no=${user.no}">수정</a>	
					  </td>
					 </tr>
			 	</c:otherwise>
			 </c:choose>	
			 </c:forEach>
			 <c:if test="${empty replyList}">
			 <tr>
			    <td colspan='4'>후기를 등록하세요</td>
			 </tr>
		 	</c:if>
		 </table>
		</div>
		</form>
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
