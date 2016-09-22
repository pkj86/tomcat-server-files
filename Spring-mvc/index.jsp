<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<a href="${pageContext.request.contextPath}/hello/hello.do">
		hello
	</a><br>
	<a href="${pageContext.request.contextPath}/method/method.do">
		호출
	</a><br>
	<a href="${pageContext.request.contextPath}/form/joinForm.do">
		form
	</a><br>
	<a href="${pageContext.request.contextPath}/ajax/resBody.do">
 		문자열 응답
 	</a><br />
 	<a href="${pageContext.request.contextPath}/ajax/resBody.json">
	 	JSON 응답
	</a><br />
	<a href="${pageContext.request.contextPath}/ajax/resVOBody.json">
	 	JSON VO 응답
	</a><br />
	<a href="${pageContext.request.contextPath}/ajax/resStringListBody.json">
	 	JSON List(문자열) 응답
	</a><br />
	<a href="${pageContext.request.contextPath}/ajax/resVOListBody.json">
		JSON List(VO) 응답
	</a><br />
	<a href="${pageContext.request.contextPath}/file/uploadForm.do">
	 	파일 업로드
	</a><br />
	<a href="${pageContext.request.contextPath}/interceptor/loginForm.do">
	 	로그인폼
	</a><br />
	<a href="${pageContext.request.contextPath}/path/paramMemberInfo.do?id=a">
		PathVariable 파라미터
	</a><br />
	<a href="${pageContext.request.contextPath}/path/b/pathMemberInfo.do">
		PathVariable 경로처리
	</a><br />
</body>
</html>