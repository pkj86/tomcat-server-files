<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%request.setCharacterEncoding("utf-8"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<title>게시글 등록하기</title>
</head>
<body>
<div class="container">
	<div class="header">
		<%@ include file="/include/topMenu.jsp" %>
	</div>	
	<div class="content">
		<h2>게시글 등록하기</h2>
<form class="writeform" action='write.do' method='POST' enctype="multipart/form-data">
<hr>			
<table width='80%' border='1'>
<tr>
	<th>글제목</th>
	<td><input type='text' name='title' size=50 placeholder='글 제목을 입력하세요' />
	</td>
	
</tr>
<tr>
	<th>글쓴이</th>
	<td><input type='text' name='writer' size=30 readonly="readonly" value="${user.name}"/></td>
</tr>
<tr>
	<th>글내용</th>
	<td><textarea rows='10' name='content' cols='70'>글 내용을 입력하세요</textarea></td>
</tr>
<tr>
<td colspan='2'>
	 <input type='submit' value='글 등록'/>
	 <input type='button' value='취소하고 목록으로' onclick="location.href='list.do'"/>
     <input type="file" name="attachFile" value="첨부파일"/>
</td>
</tr>
</table>
</hr>
</form>
	<%--<form class="writeform" method="post" action="${pageContext.request.contextPath}/file/upload" enctype="multipart/form-data">
	</form>--%>
	</div>
	<div class="footer">
		<%@ include file="/include/bottom.jsp" %>
	</div>
</div>
	
</body>
</html>