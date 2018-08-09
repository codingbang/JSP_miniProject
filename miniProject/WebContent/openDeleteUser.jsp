<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="ssi.jsp" %>
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>아이디 중복 확인</title></head>
<!-- bootstrap css&meta  -->
<meta name="viewport" content="width=device-width initial-scale=1.0">
<link rel="stylesheet" href="src/bootstrap/css/bootstrap.css">


<script src="src/js/userDelete.js"></script>

</head>
<body onload="reCheck()">

<div class="container">
		<div class="col-lg-3"></div>
		<div class="col-lg-6">
			<div class="jumbotron" style="height: 300px;">
				<form method="post" action="loginAction.jsp" name="deleteUserForm">
					<h3 style="text-align: center;">탈퇴 확인</h3>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="아이디" name="userid" maxlength="20">
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="비밀번호" name="pwd" maxlength="20">
					</div>
					<input type="button" class="btn btn-primary form-control" onclick="deleteUserBtn()" value="탈퇴하기">
				</form>
			</div>
		</div>
		<div class="col-lg-3"></div>
	</div>
<!-- bootstrap js -->
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="src/bootstrap/js/bootstrap.js"></script>
</body>
</html>
