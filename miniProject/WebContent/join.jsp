<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- bootstrap css&meta  -->
<meta name="viewport" content="width=device-width initial-scale=1.0">
<link rel="stylesheet" href="src/bootstrap/css/bootstrap.css">
<!-- css -->
<link rel="stylesheet" href="src/css/myCarouselCss.css">
<link rel="stylesheet" href="src/css/teamCss.css">
<link rel="stylesheet" href="src/css/join.css">

<!-- script  -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="src/js/join.js"></script>


<title>Insert title here</title>
</head>
<body>
	<jsp:include page="topNav.jsp" flush="false"/>
	
	
	
	<!-- 회원가입 정보 입력란 -->
	<div class="container myjoin">
		<div class="col-lg-1"></div>
		<div class="col-lg-10">
			<div
				style="background-color: #f2f2f2; padding-top: 20px; padding-bottom: 20px; margin-bottom: 30px;">
				
				
				<h2 align="center">-회원가입-</h2>
				<br>

				<form id="joinForm" name="joinForm" method="post" action="joinAction.jsp">

					<!-- 아이디 -->
					<div class="form-group joinpadding">
						<div class="row">
							<div class="divLeft" style="padding-right: 30px;">
								<label>아이디</label>
							</div>
							<div class="divLeft">
								<input type="text" class="form-control" name="userId"
									id="userId" placeholder="아이디를 입력해주세요" maxlength="60" size="30"
									onkeyup="checklen(this, 30);"> 
									<label id="userIdLabel"></label><br>
							</div>
							<div class="divLeft" style="padding-left: 15px;">
								<button id="" type="button" class="btn btn-primary form-control"
									onclick="checkId()">중복확인</button>
							</div>
							
							
						</div>
					</div>


					<p>
						<!-- 패스워드 -->
					<div class="form-group joinpadding">
						<div class="row">
							<div class="divLeft" style="padding-right: 16px;">
								<label>비밀번호</label>
							</div>
							<div class="divLeft">
								<input type="password" class="form-control" name="pwd1"
									id="pwd1" placeholder="6~16자 사이로 입력해주세요"
									onkeyup="checklen(this,32); checkPwdReg();" maxlength="60" size="30">
									<label id="pwdLabel1"></label><br>
							</div>
						</div>
					</div>



					<!-- 패스워드 확인 -->
					<div class="form-group joinpadding">
						<div class="row">
							<div class="divLeft" style="padding-right: 15px;">
								<label style="text-align: center;">비밀번호<br>확인</label>
							</div>
							<div class="divLeft">
								<input type="password" class="form-control" name="pwd2"
									id="pwd2" onkeyup="checkPwd()" placeholder="비밀번호를 동일하게 입력해주세요"
									maxlength="60" size="30"> <label id="pwdLabel2"></label><br>
							</div>
						</div>
					</div>



					<!-- 이름 입력 -->
					<div class="form-group joinpadding">
						<div class="row">
							<div class="divLeft" style="padding-right: 45px;">
								<label>이름</label>
							</div>
							<div class="divLeft">
								<input type="text" class="form-control" name="userName" id="userName"
									placeholder="이름을 입력해 주세요" onkeyup="checklen(this,15)"
									maxlength="15" size="24"><br>
							</div>
						</div>
					</div>
					
					<!-- 이메일 입력 -->
					<div class="form-group joinpadding">
						<div class="row">
							<div class="divLeft" style="padding-right: 30px;">
								<label>이메일</label>
							</div>
							<div class="divLeft">
								<input type="text" class="form-control" name="userEmail" id="userEmail"
									placeholder="aaa@aaa.aa형식으로 입력해 주세요" onblur="emailcheck()"
									onkeyup="checklen(this,30)" size="40">
									<label id="email_ch"></label><br>
							</div>
						</div>
					</div>
					
					

					<!-- 전화 번호 선택 -->
					<div class="form-group joinpadding">
						<div class="row">
							<div class="divLeft" style="padding-right: 15px;">
								<label>휴대전화</label>
							</div>
							<div class="divLeft" style="padding-right: 5px;">
								<select class="form-control" name="phone1" id="phone1"
									style="width: 80px;">
									<option value="010">010</option>
									<option value="011">011</option>
								</select>
								<label id="numLable">숫자3~4자리 입력하세요.</label>
							</div>
							<div id="divPhone2" class="divLeft" style="margin-left:-81.5px; padding-left: 5px;">
								<input type="text" class="form-control" name="phone2"
									id="phone2" size="8" maxlength="4" onchange="phone()"
									placeholder="ex)0000">
							</div>
							<div class="divLeft" style="padding-left: 5px;">
								<input type="text" class="form-control" name="phone3"
									id="phone3" size="8" maxlength="4" onchange="phone()"
									placeholder="ex)0000"> <br>
							</div>
							<div>
							
							</div>
						</div>
					</div>


					<!-- 우편번호 -->
					<div class="form-group joinpadding">
						<div class="row">
							<div class="divLeft" style="padding-right: 15px;">
								<label>우편번호</label>
							</div>
							<div class="divLeft" style="padding-right: 5px;">
								<input type="text" class="form-control" size="10" id="zipCode"
									name="zipCode" readonly>
							</div>
							<div class="divLeft" style="padding-right: 5px;">
								<input type="button" class="btn btn-default"
									onclick="DaumPostcode()" value="우편번호검색" />
							</div>
						</div>
						<br>
						<p>
							<!-- 상세주소 -->
						<div class="row">
							<div class="divLeft" style="padding-right: 15px;">
								<label>상세주소</label>
							</div>
							<div class="divLeft" style="padding-right: 5px;">
								<input type="text" class="form-control" name="address1"
									id="address1" size="30" readonly>
							</div>
							<div class="divLeft" style="=pazdding-right: 5px;">
								<input type="text" class="form-control" name="address2"
									id="address2" size="30" onkeyup="checklen(this,30)"
									placeholder="나머지 주소를 입력 해 주세요"> <br>
							</div>
						</div>
					</div>

					<!-- URL -->
					<div class="form-group joinpadding">
						<div class="row">
							<div class="divLeft" style="padding-right: 42px;">
								<label>URL</label>
							</div>
							<div class="divLeft">
								<input type="text" class="form-control" name="url" id="url"
									size="30" onkeyup="checklen(this,20)">
							</div>
						</div>
					</div>




					<!-- 이벤트 처리 버튼 -->
					<div class="row" align="center" style="padding-top: 20px; padding-bottom: 20px;">
						<button id="addBtn" type="button" class="btngray btn btn-primary" onclick="check()">회원가입</button>
						
						<a href="main.jsp">
							<button type="button" class="btngray btn btn-default">메인으로</button>
						</a>
						<button type="reset" class="btngray btn btn-default">다시작성</button>
						 
					</div>


				</form>
			</div>
		</div>
		<div class="col-lg-1"></div>
	</div>
	
	
	
	
	<jsp:include page="footer.jsp" flush="false"/>
	
	
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="src/bootstrap/js/bootstrap.js"></script>
</body>
</html>