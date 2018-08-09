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
		$('#messageForm').submit();
	});
	
	$('#content').keydown(function() {
        var textLength = $(this).val().length;
 		var maxTextLenngth = 500;
 		$('#lengthCheck').text(textLength+"/");

        
        // 제한된 길이보다 입력된 길이가 큰 경우 제한 길이만큼만 자르고 텍스트영역에 넣음
        if (textLength > maxTextLenngth) {
        	$('#lengthCheck').text(500+"/");
            $(this).val($(this).val().substr(0, maxTextLenngth));
            $('#maxText').css('color','red');
        }else {
        	$('#maxText').removeAttr('style');
        }
        
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
			System.out.println(userID);
		}
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("</script>");
			response.sendRedirect("login.jsp");
		} else {
			GuserId = request.getParameter("userId");
		}
	%>
	<div class="popup_memo">
	<div class="popup_title" align="center" style="background-color: gold; height: 35px; padding-top: 8px;">
		<font style="font-size: 5; font-weight: bold">쪽지 보내기</font>
	</div>
	<div class="popup_middle">
		<div class="popup_middle_in">
	  	  	<ul class="message_name">
	  			<li><em>받는사람 :</em><%= GuserId %> </li>	  		
	  		</ul>
	  	<div class="message" align="center">
	  		<form action="messageWriteAction.jsp" method="post" id="messageForm">
	  			<input type="hidden" id="recvUser" name="recvUser" value="<%=GuserId%>">
		  		<textarea style="width:450px;height:190px;" id="content" name="content"></textarea>
		  		<div>
		  			<p style="height:10px;text-align:right;margin-right:20px;font-size:11px;color:#5e5e5e;">
		  				<span id="lengthCheck">0/</span>
		  				<span id="maxText">500자 (최대 500자까지 가능)</span>
		  			</p>	  	
		  	    </div>
		  	    <p><button id="sendBtn" type="button" class="btn btn-primary">쪽지보내기</button></p>
	  	    </form>
	  		<p style="height:10px;font-size:11px;color:#ab3023;">특정 목적을 위한 스팸내용을 전송할 시 경고 없이 이용이 제한될 수 있습니다.</p>
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