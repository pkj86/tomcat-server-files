<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<!--
	파일 전송의 필수사항
	1. post 방식으로만.
	2. form 의 encType 속성값을 multipart/form-data 로 설정한다. 
 -->
	<form method="post" action="${pageContext.request.contextPath}/file/upload" enctype="multipart/form-data">
		<input type="text" name="msg" /><br>
		<input type="file" name="attachFile" /><br>
		<input type="submit" value="전송" />
	</form>
</body>
</html>