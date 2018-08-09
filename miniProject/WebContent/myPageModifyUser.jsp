<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ include file="ssi.jsp" %>
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
<script src="src/js/userDelete.js"></script>
<script src="src/js/modifyUser.js"></script>


<title>Insert title here</title>
</head>
<body>
	<jsp:include page="topNav.jsp" flush="false"/>
	
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		} 
	%>
	
	
	<div class="container">
		<div class="row">
			<h3>회원 정보 수정</h3>
		</div>
		<div class="row">
			<div class="myPage-container">

				<div class="row">
					<div id="myPage-nav" class="col-xs-2" align="right">
						<ul class="nav nav-pills nav-stacked">
							<li role="presentation"><a
								href="myPageMessageList.jsp">쪽지함</a></li>
							<li role="presentation"><a
								href="myPageBoardList.jsp">내가
									쓴 글</a></li>
							<li role="presentation"><a
								href="myPageReplyList.jsp">내가
									쓴 댓글</a></li>
							<li role="presentation" class="active"><a
								href="myPageModifyUser.jsp">회원
									정보 수정</a></li>
							<li role="presentation">
								<a href="#" onclick="openDeleteUsere()"><span style="color: #ff4d4d">회원 탈퇴</span></a></li>
						</ul>
					</div>
					
					<div class="row">
					<div class="col-md-1"></div>
						<div class="col-md-9"><br>
						
							<%
								ST=CN.createStatement();
								sql = "select * from users where u_id='"+userID+"'";
								RS=ST.executeQuery(sql);
								
								if(RS.next()){
									
									GuserId = RS.getString("u_id");
									GuserName = RS.getString("u_name");
									GuserPhone = RS.getString("u_phone");
									GuserEmail = RS.getString("u_email");
									GuserAddr1 = RS.getString("u_addr1");
									GuserAddr2 = RS.getString("u_addr2");
									GuserAddrcode = RS.getString("u_addrcode");
									GuserUrl = RS.getString("u_url");
								}
								
								
								String uPhone1;
								String uPhone2;
								if(GuserPhone.length()==11) {
									uPhone1 = GuserPhone.substring(3, 7);
									uPhone2 = GuserPhone.substring(7, 11);
								} else {
									uPhone1 = GuserPhone.substring(3, 6);
									uPhone2 = GuserPhone.substring(6, 10);
								}
								
							
							
							%>
							
							<!-- 회원 정보 입력란 -->
						<div class="container myjoin" style="margin-top: -65px;">
							<div class="col-lg-1"></div>
							<div class="col-lg-10">
							
								<div
									style="background-color: #f2f2f2; padding-top: 20px; padding-bottom: 20px; margin-bottom: 30px;">
									<h2 align="center">-회원정보 수정-</h2>
									<br>
					
									<form id="userModifyFrom" name="userModifyFrom" method="post" action="myPageUserModifyAction.jsp">
					
										<!-- 아이디 -->
										<div class="form-group joinpadding">
											<div class="row">
												<div class="divLeft" style="padding-right: 30px;">
													<label>아이디</label>
												</div>
												<div class="divLeft">
													<input type="text" class="form-control" name="userId"
														id="userId" value="<%=GuserId %>" maxlength="60" size="30"
														onkeyup="checklen(this, 30);" disabled="disabled" readonly="readonly"> 
														<label id="userIdLabel"></label><br>
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
					
					
					
										<!-- 이름 -->
										<div class="form-group joinpadding">
											<div class="row">
												<div class="divLeft" style="padding-right: 45px;">
													<label>이름</label>
												</div>
												<div class="divLeft">
													<input type="text" class="form-control" name="userName" id="userName"
														value="<%=GuserName %>" onkeyup="checklen(this,15)"
														maxlength="15" size="24" disabled="disabled" readonly="readonly"><br>
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
														onkeyup="checklen(this,30)" size="40" value="<%=GuserEmail%>">
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
														placeholder="ex)0000" value="<%=uPhone1%>">
												</div>
												<div class="divLeft" style="padding-left: 5px;">
													<input type="text" class="form-control" name="phone3"
														id="phone3" size="8" maxlength="4" onchange="phone()"
														placeholder="ex)0000" value="<%=uPhone2%>"> <br>
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
														name="zipCode" value="<%=GuserAddrcode %>" readonly>
												</div>
												<div class="divLeft" style="padding-right: 5px;">
													<input type="button" class="btngray btn btn-default"
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
														id="address1" size="30" value="<%=GuserAddr1 %>" readonly>
												</div>
												<div class="divLeft" style="=pazdding-right: 5px;">
													<input type="text" class="form-control" name="address2"
														id="address2" size="30" onkeyup="checklen(this,30)"
														value="<%=GuserAddr2 %>"> <br>
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
											<button id="addBtn" type="button" class="btngray btn btn-primary" onclick="check()">회원수정</button>

											<button type="reset" class="btngray btn btn-default">다시작성</button>
											 
										</div>
					
					
									</form>
								</div>
							</div>
							<div class="col-lg-1"></div>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>
</div>
	
	
	
	
	
	
	
	<jsp:include page="footer.jsp" flush="false"/>
	
	
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="src/bootstrap/js/bootstrap.js"></script>
</body>
</html>