<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<c:set var="rList" value="${rList}" scope="request"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="../js/jquery-3.1.0.js"></script>
<style type="text/css">
	a{
		text-decoration: none;
		background-color: white;
		width: 100px;
		border-radius: 5px;
		border: 5px dotted white;
	}
	#replyList{
		width: 80%;
		box-sizing: border-box;
		border: 5px solid #331100;
		border-radius: 5px;
		background-color: #ffcc00;
	}
	span{
		box-sizing: border-box;
		border: 1px solid black;
		display: inline-block;
		padding: 10px 0px 10px 10px;
	}
	.replys{		
		width: 100%;
	}
	.rWriter{
		text-align: center;
		border: none;
		width: 20%;
		border-right: 3px dotted #331100;
		border-bottom: 3px dotted #331100;
	}
	.rContent{
		border: none;
		width: 50%;
		border-right: 3px dotted #331100;
		border-bottom: 3px dotted #331100;
		padding-left: 20px;
	}
	.rTime{
		text-align: center;
		border: none;
		width: 20%;
		border-right: 3px dotted #331100;
		border-bottom: 3px dotted #331100;
	}
	.btns{
		text-align: center;
		border: none;
		border-bottom: 3px dotted #331100;
		width: 10%;
	}
	#replyUpdateDiv{
		background-color: salmon;
	}
	#replyUpdateDiv > span{
		width: 20%;
		text-align: center;
	}
</style>
</head>
<body>
<!-- <script type="text/javascript">
	function open_win(post) {
		window.open('reply.jsp', '댓글수정', 'width=1300, height=200, left=300, top=300, location=no, realzable=no');		
	}
</script> -->
<!-- 댓글 목록 표시 -->
<div id="replyList">
	
</div>
<!-- 댓글 수정 폼 -->
<div id="replyUpdateDiv">
	<input type="hidden" name="replyNo" />
	<span></span>
	<textarea name="rContent" rows="1" cols="150"></textarea>
	<button>수정</button>
</div>
<%-- <table width='80%' border='1'>
<c:choose>
	<c:when test="${empty rList}">
		<th colspan="3" align="center">작성된 댓글이 하나도 없습니다. 지금 댓글을 작성해 보세요</th>
	</c:when>
	<c:otherwise>
	<c:forEach var="replys" items="${rList}">
	<tr>
		<th width="15%" align="center">
			<c:out value="${replys.rWriter}" />
		</th>
		<td width="70%" align="center">
			<c:out value="${replys.rContent}" />
		</td>
		<td align="center">
			<fmt:formatDate var="regDate" value="${replys.rRegDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
			<c:out value="${regDate}"/>
			<input type="button" onclick="javascript:open_win(${postNo});" value="수정"/>
		</td>
	</tr>
	</c:forEach>
	</c:otherwise>
</c:choose> --%>
	<form id="replyRegForm" action="writeReply.do" method="post">
	<!-- <tr> -->
		<!-- <td align="center"> -->
		<input type="hidden" name="postNo" value="${param.postNo}"/>
		<input type='text' size='10px' name='rWriter' readonly="readonly" value="${user.name}"/>
		<!-- </td> -->
		<!-- <td align="center"> -->
		<textarea cols='150' rows="1" name='rContent'>댓글 내용을 입력</textarea>
		<!-- </td> -->
		<!-- <td align="center"> -->
		<input type="submit" value="댓글입력"/>
		<!-- </td>
	</tr> -->
	</form>
<!-- </table> -->
<script type="text/javascript">
	// 댓글 목록 조회
	function replyList()
	{
		$.ajax({
			url: "${pageContext.request.contextPath}/jspboard/replyList.do",
			data: {postNo: "${param.postNo}"},
			dataType: "json"
		})
		.done(makeReplyList);
	}
	
	function makeReplyList(result)
	{
		console.log("댓글목록생성 함수 호출됨...");
		console.dir(result);
		
		var html = "";
		for(var i = 0 ; i < result.length ; i++)
		{
			var reply = result[i];
			html += "<div id='reply"+reply.replyNo+"' class='replys'>";
			html += "<span class='rWriter'>"+reply.rWriter+"</span>";
			html += "<span class='rContent'>"+reply.rContent+"</span>";
			var date = new Date(reply.rRegDate);
			var time = date.getFullYear() + "-" + date.getMonth() + "-" + date.getDate() + " " 
					 + date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();
			html += "<span class='rTime'>"+time+"</span>";
			html += "<span class='btns'>";
			if('${user.name}' == reply.rWriter)
			{
				html += "<a href='#1' onclick='replyUpdate("+reply.replyNo+");'>수정</a>";
				html += "<a href='#1' onclick='replyDelete("+reply.replyNo+");'>삭제</a>";				
			}else
			{
				html += "&nbsp;";
			}
			html += "</span>";
			html += "</div>";
		}
		if(result.length == 0)
		{
			html += "<div>댓글이 없습니다</div>";
		}
		$("#replyList").html(html);
	}
	// 페이지 로딩시 댓글목록 호출
	replyList();
	
	// 댓글 등록 처리
	$("#replyRegForm").submit(function(){
		var f = document.querySelector("#replyRegForm");
		$.ajax({
			url: "${pageContext.request.contextPath}/jspboard/writeReply.do",
			type: "post",
			data: {postNo: f.postNo.value, rContent: f.rContent.value, rWriter: f.rWriter.value},
			dataType: "json"
		})
		.done(function(result){
			f.rContent.value = "";
			replyList();
		});
		return false;
	});
	
	function replyDelete(replyNo)
	{
		$.ajax({
			url: "${pageContext.request.contextPath}/jspboard/deleteReply.do",
			data: {postNo: "${param.postNo}", replyNo: replyNo},
			dataType: "json"			
		})
		.done(makeReplyList);
	}
	// 처음엔 숨김
	$("#replyUpdateDiv").hide();
	// 댓글 수정 버튼 처리
	$("#replyUpdateDiv > button").click(function(){
		var $parent = $(this).parent();
		var content = $parent.find("textarea").val();
		var replyNo = $parent.find("input").val();
		console.log(content, replyNo);
		$.ajax({
			url: "${pageContext.request.contextPath}/jspboard/updateReply.do",
			data: {postNo: "${param.postNo}", replyNo: replyNo, rContent: content}
		})
		.done(function(){
			// 수정된 내용 초기화
			$parent.find("span").html("");
			$parent.find("textarea").val("");
			$parent.find("input").val("");
			// 수정된 내용 업데이트 하기(화면)
			$("#reply" + replyNo + " > span:eq(1)").html(content);			
			$("#reply" + replyNo).show();
			$("#replyList").after($parent.hide());
		});
	});
	
	function replyUpdate(replyNo)
	{
		// 기존 숨겨진 div 들을 화면에 보이게 함
		$("#replyList > div[id^=reply]").show();
		var $cDiv = $("#reply" + replyNo);
		$("#replyUpdateDiv > input").val(replyNo);
		$("#replyUpdateDiv > span:eq(0)").html($cDiv.find("span:eq(0)").html());
		$("#replyUpdateDiv > textarea").val($cDiv.find("span:eq(1)").html());
		$cDiv.after($("#replyUpdateDiv").show());
		$cDiv.hide();
	}
</script>
</body>
</html>