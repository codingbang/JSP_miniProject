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


<script>
 function reCheckId(){
	 var openUserId = checkUserId.userId1.value;
	 
	 if (openUserId==null || openUserId=="") {
		alert("중복체크할 아이디를 입력해주세요.");
		checkUserId.userId1.focus();
	} else {
		document.location.href="openCheckId.jsp?userId="+openUserId;
	}
 }
 
 function useBtn() {
	var openUserId = checkUserId.userId1.value;
	opener.joinForm.userId.value=openUserId;
	opener.joinForm.userId.focus();
	opener.joinForm.userId.readOnly =true;
	self.close();
 }
 
</script>
</head>
<body>
<%
	data = request.getParameter("userId");
	System.out.println(data);
%>

<div align="center" style="padding-top: 55px;">
<form action="" method="post" name="checkUserId" >
   <input type="text" id="userId1" name="userId1" placeholder="사용할 아이디를 입력하세요." class="form-control" style="width: 220px;"
   value="<%=data%>"/>
   <br>
   <input type="button" id="checkButtonId" name="checkButtonId" class="btn btn-primary" value="중복확인" onclick="reCheckId()">
   <input type="button" id="useButton" name="useButton" class="btn" onclick="useBtn()" value="아이디사용" disabled>
   <div id = text ></div>
   <span></span>
</form>

<%

		try{
			ST=CN.createStatement();
			sql="select count(*) as cnt from users where u_id='"+data+"'";
			RS=ST.executeQuery(sql);
			
			if(RS.next()==true){
				Gtotal=RS.getInt("cnt");
			}
			if(Gtotal>0){	
				
	%>
				<script type="text/javascript">
					alert("<%=data%> 은(는) 이미 사용중인 아이디입니다.");
					var useButton = document.getElementById('useButton');
					useButton.disabled = true;
				</script>
	
	<%
			} else {
	%>
			<script type="text/javascript">
				alert("<%=data%>은(는) 사용가능한 아이디입니다.");
				var useButton = document.getElementById('useButton');
				useButton.disabled = false;
				useButton.className += " btn-danger";
			</script>
	
	<%		}
		} catch (Exception e) {
			e.printStackTrace();
		}
	
	%>
</div>
<!-- bootstrap js -->
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="src/bootstrap/js/bootstrap.js"></script>
</body>
</html>
