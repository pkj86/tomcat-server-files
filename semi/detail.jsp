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
<link href="css/bootstrap-social.css" rel="stylesheet">
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
<script src="js/ie-emulation-modes-warning.js"></script>
<style>
</style>
</head>

<body>

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<%@ include file="attach/header.jsp"%>

	<script>
		function dateChk() {
			var myAlert = document.getElementById("myAlert1");
			var ckin = document.getElementById("checkIn");
			var ckout = document.getElementById("checkOut");
			console.log(ckin.value, ckout.value);
			if (ckin.value >= ckout.value) {
				myAlert.style.display = "inline-block";
				return false;
			}

			return true;
		}
		
	</script>


	<br>
	<div class="row">
		<div class="col-md-8 col-md-offset-2">
			<div class="container col-md-6" align="center">
				<img class="img-responsive img-rounded" alt="" src="/semiProject01/down?path=${p.imgPath}/&realName=${p.imgRealName}&draw=Y"> <br>
				<form class="form-inline" method="get" accept-charset="utf-8" action="/semiProject01/apply?guestEmail=${user.email}" onsubmit="return dateChk();">
					<div class="panel panel-default">
						<div class="panel-body">
							<div class="form">
								<div class="col-md-12" align="left">
									<fmt:formatDate value="${p.startDate}" pattern="yyyy-MM-dd" var="startDate" />
									<fmt:formatDate value="${p.endDate}" pattern="yyyy-MM-dd" var="endDate" />
									<input type="hidden" name="guestEmail" value="${user.email}">
									<input type="hidden" name="hostNo" value="${s.hostNo}">
									<c:choose>
										<c:when test="${user.email == s.hostEmail}">
											<c:if test="${s.hostingStatus == 'W'}">
												
											</c:if>											
											<c:if test="${s.hostingStatus == 'A'}">
												
											</c:if>											
										</c:when>
										<c:otherwise>
											<label for="checkIn">체크인 </label>
											<br>
											<input type="date" name="checkIn" class="form-control" id="checkIn" width="50%" min="${startDate}" max="${endDate}" required>
											<br>
											<br>
											<label for="checkOut">체크아웃</label>
											<br>
											<input type="date" name="checkOut" class="form-control" id="checkOut" width="50%" min="${startDate}" max="${endDate}" required>
											<br>
											<br>
											<label for="ppl">숙박인원</label>
											<br>
											<select name="ppl" class="form-control" id="ppl" required>
												<c:forEach begin="1" end="${d.houseCapacity}" step="1" var="cnt">
													<option value="${cnt}">${cnt}명</option>
												</c:forEach>
											</select>
										</c:otherwise>
									</c:choose>
								</div>
								<br>
								<!-- 경보 시작 -->
								<div id="myAlert1" style="display: none;">
									<br>
									<div class="alert alert-danger" role="alert">
										<strong>경고! </strong>&nbsp;&nbsp;체크인, 체크아웃 날짜를 확인하세요.
									</div>
								</div>
								<!-- 경보 끝 -->
								<div class="col-md-12">
									<div class="col-md-6 col-md-offset-6">
										<c:if test="${s.hostingStatus == 'W'}">
											<c:choose>
												<c:when test="${user.email != s.hostEmail}">
													<button type="submit" style="width: 100%" class="form-control btn btn-success">
														<span class="fa fa-credit-card"></span>
														&nbsp;&nbsp;즉시예약하기
													</button>
												</c:when>
												<c:otherwise>
													<button type="button" onclick="location.href='/semiProject01/hostUpdate?hostNo=${s.hostNo}'" style="width: 100%" class="form-control btn btn-info">
														<span class="fa fa-pencil"></span>
														&nbsp;&nbsp;글수정
													</button>
													<br>
													<br>
													<button type="button" onclick="location.href='/semiProject01/deleteBoard?hostNo=${s.hostNo}'" style="width: 100%" class="form-control btn btn-danger">
														<span class="fa fa-times"></span>
														&nbsp;&nbsp;글삭제
													</button>
													<br>
												</c:otherwise>
											</c:choose>
										</c:if>
										<c:if test="${s.hostingStatus == 'A'}">
											
											<c:choose>
												<c:when test="${user.email == s.hostEmail}">
													<fmt:formatDate value="${s.checkIn}" pattern="yyyy-MM-dd" var="guestCheckIn" />
													<fmt:formatDate value="${s.checkOut}" pattern="yyyy-MM-dd" var="guestCheckOut" />
													<div class="col-md-12" align="left">
													<label>신청인 </label>
													<br>
													<span>${guest.name}</span>
													<br>
													<br>
													<label>체크인</label>
													<br>
													<span>${guestCheckIn}</span>
													<br>
													<br>
													<label>체크아웃</label>
													<br>
													<span>${guestCheckOut}</span>
													<br>
													<br>
													</div>
													<button type="button" onclick="location.href='/semiProject01/response?res=accept&hostNo=${s.hostNo}'" style="width: 100%" class="form-control btn btn-success">
														<span class="fa fa-smile-o"></span>
														&nbsp;&nbsp;수락
													</button>
													<br>
													<br>
													<button type="button" onclick="location.href='/semiProject01/response?res=reject&hostNo=${s.hostNo}'" style="width: 100%" class="form-control btn btn-warning">
														<span class="fa fa-times"></span>
														&nbsp;&nbsp;거절
													</button>
												</c:when>
												<c:when test="${user.email == s.guestEmail}">
													<button type="button" onclick="location.href='/semiProject01/main'" style="width: 100%" class="form-control btn btn-success">
														<span class="fa fa-meh-o"></span>
														&nbsp;&nbsp;수락대기중
													</button>
												</c:when>
												<c:otherwise>
													<button type="submit" style="width: 100%" class="form-control btn btn-warning" disabled="disabled">
														<span class="fa fa-close"></span>
														&nbsp;&nbsp;예약중
													</button>
												</c:otherwise>
											</c:choose>
										</c:if>
										<c:if test="${s.hostingStatus == 'C'}">
											<button type="submit" style="width: 100%" class="form-control btn btn-default" disabled="disabled">
												<span class="fa fa-github"></span>
												&nbsp;&nbsp;예약완료
											</button>
											<br>
										</c:if>
										<br>
										<c:if test="${user.email != s.hostEmail && not empty host.fb}">
											<a style="margin-top: 10px; width: 100%;" class="btn btn btn-social btn-facebook" href="https://www.facebook.com/${host.email}"><span class="fa fa-facebook"></span>페이스북 방문</a>
										</c:if>
									</div>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
			<div class="container col-md-6" align="left">
				<div class="col-md-12" align="left">
					<h3>${p.houseDesc}</h3>
					<br>
				</div>
				<div class="col-md-12" align="left">
					<span style="color: gray;">
						&nbsp;&nbsp;${p.houseCost}
						<span class="fa fa-krw" aria-hidden="true"></span>
						/ day
					</span>
					<br> <br> <br>
				</div>
				<div class="col-md-3" align="center">
					<div style="width: 60%;">
						<span class="fa fa-building fa-3x"></span>
					</div>
					<br>
					<span>${d.houseType}</span>
				</div>
				<div class="col-md-3" align="center">
					<div style="width: 60%;">
						<span class="fa fa-users fa-3x"></span>
					</div>
					<br>
					<span>인원 ${d.houseCapacity}명</span>
				</div>
				<div class="col-md-3" align="center">
					<div style="width: 60%;">
						<span class="fa fa-key fa-3x"></span>
					</div>
					<br>
					<span>침실 ${d.houseRoom}개</span>
				</div>
				<div class="col-md-3" align="center">
					<div style="width: 60%;">
						<span class="fa fa-moon-o fa-3x"></span>
					</div>
					<br>
					<span>침대 ${d.houseBed}개</span>
				</div>
				<div class="col-md-12" style="font-size: 12px;">
					<br> <br> <br>
					<h4 style="font-weight: bold">상세 설명</h4>
					<br>
					<span>${d.houseDetail}</span>
					<br>
					<hr>
					<div class="col-md-2">
						<span>숙소</span>
					</div>
					<div class="col-md-5">
						<span>
							숙박 가능 인원 :
							<span style="font-weight: bold">${d.houseCapacity}</span>
						</span>
						<br>
						<span>
							침실 :
							<span style="font-weight: bold">${d.houseRoom}</span>
						</span>
						<br>
						<span>
							침대 :
							<span style="font-weight: bold">${d.houseBed}</span>
						</span>
						<br>
					</div>
					<div class="col-md-5">
						<span>
							집 유형:
							<span style="font-weight: bold">${d.houseType}</span>
						</span>
						<br>
						<span>
							숙소 유형:
							<span style="font-weight: bold">${d.roomType}</span>
						</span>
						<br>
					</div>
					<br> <br> <br> <br>
					<hr>
					<div class="col-md-2">
						<span>가격</span>
					</div>
					<div class="col-md-5">
						<span>
							추가 인원 요금 :
							<span style="font-weight: bold">없음</span>
						</span>
						<br>
					</div>
					<div class="col-md-5">
						<span>
							1일 요금:
							<span style="font-weight: bold">${p.houseCost}</span>
						</span>
						<br>
					</div>
				</div>
			</div>
		</div>
	</div>



	<div class="container">
		<!-- 코드시작 -->

		<!-- 코드 종료 -->
		<footer class="footer">
			<%@ include file="attach/footer.jsp"%>
		</footer>
	</div>


	<script src="js/bootstrap.min.js"></script>
	<script src="js/ie10-viewport-bug-workaround.js"></script>
</body>
</html>
