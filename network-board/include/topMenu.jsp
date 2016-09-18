<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<ul>
<c:choose>
	<c:when test="${empty user}">
		<li><a href="${pageContext.request.contextPath}/login/loginForm.do">로그인</a></li>
	</c:when>
	<c:otherwise>
		<li><a href="${pageContext.request.contextPath}/login/logout.do">로그아웃</a></li>		
	</c:otherwise>
</c:choose>
	<li><a href="${pageContext.request.contextPath}/jspboard/list.do">자유게시판</a></li>
</ul>
	<c:if test="${!empty user}">
		<span style="color:red; font-weight: bold; font-size: 20px;">
			<c:out value="${user.name}"></c:out>
		</span>님 로그인 중
	</c:if>
<%--<table width="100%">
  <tr>
    <th align="left" width="50%"><h1>NETWORK-BOARD</h1></th>
    <th align="right" width="40%">로그인</th>
    <th align="right">자유게시판</th>
  </tr>  
</table>--%>
<hr> 
