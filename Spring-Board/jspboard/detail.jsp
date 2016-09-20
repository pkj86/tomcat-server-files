<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
		<%--String pattern = "yyyy-MM-dd HH:mm:ss";
		SimpleDateFormat sdf = new SimpleDateFormat(pattern);
		BoardVO vo = (BoardVO)request.getAttribute("vo");
		--%>
<%--<c:set var="vo" value="${BoardVO}" scope="request" />--%>
<html>
<head>
<meta charset='utf-8'>
<title>게시글 상세보기</title>
</head>
<body>
<div class="container">
	<div class="header">
		<%@ include file="/include/topMenu.jsp" %>
	</div>	
	<div class="content">
		<h2>게시글 상세보기</h2>
<%--
if(vo != null)
{--%>
<c:if test="${ vo != null }">
	<form action='updateForm.do' method='POST'>
	<hr>
	<input type='hidden' name='postNo' value='<c:out value="${param.postNo}" />'/>
	<input type='hidden' name='title' value='<c:out value="${vo.title}" />'/>
	<input type='hidden' name='writer' value='<c:out value="${vo.writer}" />'/>
	<input type='hidden' name='content' value='<c:out value="${vo.content}" />'/>
	<fmt:formatDate var="regDate" value="${vo.regDate}" pattern="yyyy-MM-dd"/>
	<input type='hidden' name='regDate' value='<c:out value="${vo.regDate}" />'/>			
	<table width='80%' border='1'>
	<tr>
		<th>글번호</th>
		<td><input type='text' disabled size=10 value='<c:out value="${param.postNo}"/>'/></td>
	</tr>
	<tr>
		<th>글제목</th>
		<td><input type='text' disabled size=50 value='<c:out value="${vo.title}" />'/></td>
	</tr>
	<tr>
		<th>글쓴이</th>
		<td><input type='text' disabled size=30 value='<c:out value="${vo.writer}" />'/></td>
	</tr>
	<tr>
		<th>글내용</th>
		<td height="500px">
		<c:if test="${fVo != null}">
		<img align="top" src="${pageContext.request.contextPath}/down?path=${fVo.path}&realName=${fVo.realName}&oriName=${fVo.oriName}"/><br>
		</c:if>
		<c:out value="${vo.content}" />
		</td>
	</tr>
	<tr>
		<th>등록일시</th>
		<td><input type='text' disabled size=30 value='<c:out value="${regDate}" />'/></td>
	</tr>
	<tr>
		<th>첨부파일</th>
		<td>
		<c:choose>
			<c:when test="${fVo != null}">
			${fVo.oriName} (${fVo.fileSize} byte)
			<a href="${pageContext.request.contextPath}/down?path=${fVo.path}&realName=${fVo.realName}&oriName=${fVo.oriName}">
			${fVo.oriName}</a>
			</c:when>
			<c:otherwise>
			첨부 파일 없음
			</c:otherwise>
		</c:choose>
		</td>
	</tr>
	<tr><td colspan='2'>
		<c:if test="${user.name == vo.writer}">
		<input type='button' value='글 삭제하기' onclick="location.href='delete.do?postNo=<c:out value="${param.postNo}"/>'"/>
		<input type='submit' value='글 수정'/>
		</c:if>
		<input type='button' value='목록으로' onclick="location.href='list.do'"/></td></tr>
	</table>
	<hr>
	</form>
	댓글창
	<%@ include file="reply.jsp" %>
</c:if>
<c:if test="${ vo == null }">
	<tr><td colspan='2'>글이 존재하지 않습니다...</td></tr>
	<input type='button' value='목록으로' onclick="location.href='list.do'"/></td></tr>
	<meta http-equiv='refresh' content='2; url=list.do'>
</c:if>
	</div>
	<div class="footer">
		<%@ include file="/include/bottom.jsp" %>
	</div>
</div>
	</body>
	</html>