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
	<br>
	<br>
	<div class="container">
		<div class="row">
			<div class="col-md-6">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h2 class="panel-title">호스팅</h2>
					</div>
					<div class="panel-body">
						<c:if test="${empty hList}">
							호스팅 내역이 없습니다.
						</c:if>

						<c:forEach var="h" items="${hList}">
							<fmt:formatDate value="${h.startDate}" pattern="yy.MM.dd" var="startDate" />
							<fmt:formatDate value="${h.endDate}" pattern="yy.MM.dd" var="endDate" />
							<div class="col-md-12">
								<div class="col-md-6">
									<img alt="" src="/semiProject01/down?path=${h.imgPath}/&realName=${h.imgRealName}&draw=Y" width="100%" class="img-rounded"> <br> <br>
								</div>
								<div class="col-md-6">
									<h4>${h.houseDesc}</h4>
									<p>
										<span style="font-weight: bold;">호스팅 가능일</span>
										<br> ${startDate} - ${endDate}<br>
										<c:if test="${h.hostingStatus == 'W'}">
											<h4>
												<span class="label label-info">신청 대기</span>
											</h4>
										</c:if>
										<c:if test="${h.hostingStatus == 'A'}">
											<h4>
												<span class="label label-warning">응답 대기중</span>
											</h4>
										</c:if>
										<c:if test="${h.hostingStatus == 'C'}">
											<h4>
												<span class="label label-default">완료</span>
											</h4>
										</c:if>
										<a class="btn btn-xs btn-default" href="/semiProject01/detail?hostNo=${h.hostNo}" role="button">상세보기</a>
									</p>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
			<div class="col-md-6">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h2 class="panel-title">게스팅</h2>
					</div>
					<div class="panel-body">
						<c:if test="${empty gList}">
							게스팅 내역이 없습니다.
						</c:if>
						<c:forEach var="g" items="${gList}">
							<fmt:formatDate value="${g.checkIn}" pattern="yy.MM.dd" var="startDate" />
							<fmt:formatDate value="${g.checkOut}" pattern="yy.MM.dd" var="endDate" />
							<div class="col-md-12">
								<div class="col-md-6">
									<img alt="" src="/semiProject01/down?path=${g.imgPath}/&realName=${g.imgRealName}&draw=Y" width="100%" class="img-rounded"> <br> <br>
								</div>
								<div class="col-md-6">
									<h4>${g.houseDesc}</h4>
									<p>
										<span style="font-weight: bold;">게스팅 예약일</span>
										<br>${startDate} - ${endDate}<br>
										<c:if test="${g.hostingStatus == 'A'}">
											<h4>
												<span class="label label-warning">응답 대기중</span>
											</h4>
										</c:if>
										<c:if test="${g.hostingStatus == 'C'}">
											<h4>
												<span class="label label-default">완료</span>
											</h4>
										</c:if>
										<a class="btn btn-xs btn-default" href="/semiProject01/detail?hostNo=${g.hostNo}" role="button">상세보기</a>
									</p>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
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
