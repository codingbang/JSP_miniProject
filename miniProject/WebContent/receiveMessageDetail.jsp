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

<!-- script  -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>

<script>
$(document).ready(function() {
	
	$('#closeBtn').click(function() {
		self.close();
	});
	
	$('#sendBtn').click(function() {
		var user = $('#sendUser').val();
		window.open("message.jsp?userId="+user,"send","width=570,height=380, top=150, left=500, resizable=no");
	});
	
	
});
</script>

<title>Insert title here</title>
</head>
<body>

	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("</script>");
			response.sendRedirect("login.jsp");
		} else {
			GMno = Integer.parseInt(request.getParameter("no"));
			try {
				ST=CN.createStatement();
				sql = "select * from message where m_no="+GMno;
				RS=ST.executeQuery(sql);
				
				if(RS.next()){
					GMno = RS.getInt("m_no");
					GuserId = RS.getString("u_id"); //보낸사람
					GMid=RS.getString("m_id"); //받는사람
					GMtitle = RS.getString("m_title");
					GMcontent = RS.getString("m_content");
					GMdate = RS.getDate("m_date");
				}
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
	%>
	<div class="popup_memo">
	<div class="popup_title" align="center" style="background-color: gold; height: 35px; padding-top: 8px;">
		<font style="font-size: 5; font-weight: bold">받은 쪽지</font>
	</div>
	<div class="popup_middle">
		<div class="popup_middle_in">
	  	  	<ul class="message_name">
	  			<li><em>보낸사람 :</em><%= GuserId %> </li>		
	  		</ul>
	  	<div class="message" align="center">
	  		<form method="post" id="messageForm">
	  			<input type="hidden" id="sendUser" name="sendUser" value="<%=GuserId%>">
		  		<textarea style="width:450px;height:190px;" name="content" readonly="readonly"><%=GMcontent %></textarea>
		  		<!-- <p style="height:10px;text-align:right;margin-right:20px;font-size:11px;color:#5e5e5e;">500자 (최대 500자까지 가능)</p> -->
		  	    <p><button id="sendBtn" type="button" class="btn btn-primary">답장하기</button></p>
	  	    </form>
	  		<p style="height:10px;font-size:11px;color:#ab3023;">스팸문자를 받으신 경우에는 관리자에게 문의 부탁드립니다.</p>
	  	</div>
	   </div>
	</div>
	<div class="popup_bottom" align="right">
		<button type="button" class="btn btn-default" id="closeBtn">창닫기</button>
	</div>
</div>
	
	
	
	
	<script src="src/bootstrap/js/bootstrap.js"></script>
</body>
</html>