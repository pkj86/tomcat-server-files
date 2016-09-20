<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 	 	
	List<BoardVO> list = (List<BoardVO>)request.getAttribute("list");
	String pattern = "yyyy-MM-dd";
	SimpleDateFormat sdf = new SimpleDateFormat(pattern);
--%>			
<c:set var="list" value="${list}" scope="request"/>
		<html>
		<head>
			<meta charset='utf-8'>
			<title>전체 게시글 목록</title>
			<style> 
/* div {
    position: relative;
    animation-name: example;
    animation-duration: 4s;
}

@keyframes example {
    0%   {left:0px;}
    50%  {left:200px;}
    100% {left:0px;}
} */
</style>
		</head>
		<body>
		<div class="container">
	<div class="header">
		<%@ include file="/include/topMenu.jsp" %>
	</div>	
	<div class="content">
			<h2>전체 글 보기</h2>
		<c:if test="${fn:length(list) == 0}">
			<tr><td colspan='4'>아무 글도 없습니다...</td></tr>			
		</c:if>
		<c:if test="${fn:length(list) != 0}">
			전체<c:out value="${fn:length(list)}" />개의 글
			<hr>
			<table width='80%' border='1'>
			<tr>
				<th>글번호</th>
				<th>글제목</th>
				<th>글쓴이</th>
				<th>등록일시</th>
			<c:forEach var="vo" items="${list}">
				<tr>				
					<td><c:out value="${vo.postNo}"/>
					<td><a href='detail.do?postNo=<c:out value="${vo.postNo}"/>'><c:out value="${vo.title}"/></a></td>
					<td><c:out value="${vo.writer}"/></td>
					<td><fmt:formatDate var="regDate" value="${vo.regDate}" pattern="yyyy-MM-dd"/><c:out value="${regDate}"/></td>
				</tr>				
			</c:forEach>			
		</c:if>
			</table>
		<tr><td colspan='4'><input type='button' value='글 등록' onclick="location.href='writeForm.do'"/></td></tr>
			</hr>
	</div>
	<div class="footer">
		<%@ include file="/include/bottom.jsp" %>
	</div>
</div>
		
		</body>
		</html>