<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Insert title here</title>
</head>
<body>
<div class="container">
	<div class="header">
		<%@ include file="/include/topMenu.jsp" %>
	</div>	
	<div class="content">
		<h2>로그인</h2>
	<hr>
	<form action="${pageContext.request.contextPath}/login/login.do" method="post">
		id : <input type="text" name="id" /><br>
		pw : <input type="password" name="pass" /><br>
		<input type="submit" value="로그인" />
	</form>
	</div>
	<div class="footer">
		<%@ include file="/include/bottom.jsp" %>
	</div>
</div>	
</body>
</html>