<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%request.setCharacterEncoding("utf-8"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
		<head>
		<meta charset='utf-8'>
		<title>게시글 수정</title>
		</head>
		<body>
		<div class="container">
	<div class="header">
		<%@ include file="/include/topMenu.jsp" %>
	</div>	
	<div class="content">
		<h2>게시글 수정</h2>
		<form action='update.do' method='POST'>
		<hr>
		<table width='80%' border='1'>
		<tr>
			<th>글번호</th>
		<input type='hidden' name='postNo' value='<c:out value="${param.postNo}"/>'/>
			<td><input type='text' disabled size='10' value='<c:out value="${param.postNo}"/>'></td>
		</tr>
		<tr>
			<th>글제목</th>
			<td><input type='text' name='title' size='50' value='<c:out value="${param.title}"/>'></td>
		</tr>
		<tr>
			<th>글쓴이</th>
			<td><input type='text' disabled size='30' value='<c:out value="${param.writer}"/>'></td>
		</tr>
		<tr>
			<th>내용</th>
			<td><textarea rows='10' cols='70' name='content'><c:out value="${param.content}"/></textarea></td>
		</tr>
		<tr>
			<th>등록일시</th>			
			<td><fmt:formatDate var="regDate" value="${vo.regDate}" pattern="yyyy-MM-dd"/>
			<c:out value="${regDate}"/></td>
		</tr>
		<tr><td colspan='2'><input type='submit' value='수정'/>
			<input type='button' value='취소하고목록으로' onclick="location.href='list.do'"/></td></tr>
		</table>
		</hr>
		</form>
	</div>
	<div class="footer">
		<%@ include file="/include/bottom.jsp" %>
	</div>
</div>
		
		</body>
		</html>