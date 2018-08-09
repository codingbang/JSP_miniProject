<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="ssi.jsp"%>
<%@ page import="java.io.PrintWriter" %>
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
		request.setCharacterEncoding("UTF-8");

		GuserPwd=request.getParameter("pwd2");
	
		GuserEmail=request.getParameter("userEmail");
		GuserAddr1=request.getParameter("address1");
		GuserAddr2=request.getParameter("address2");
		GuserAddrcode=request.getParameter("zipCode");
		GuserUrl=request.getParameter("url");
		
		String uPhone1 = request.getParameter("phone1");
		String uPhone2 = request.getParameter("phone2");
		String uPhone3 = request.getParameter("phone3");
		GuserPhone=uPhone1 + uPhone2 + uPhone3;
		
		String msg = "update users set u_pwd=?, u_phone=?, u_email=?, u_addr1=?, u_addr2=?, u_addrcode=?, u_url=? ";
		msg += " where u_id='"+userID+"'";
		
		try{
			PST=CN.prepareStatement(msg);
			
			PST.setString(1, GuserPwd);
			PST.setString(2, GuserPhone);
			PST.setString(3, GuserEmail);
			PST.setString(4, GuserAddr1);
			PST.setString(5, GuserAddr2);
			PST.setString(6, GuserAddrcode);
			PST.setString(7, GuserUrl);
			
			PST.executeUpdate();
			
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('회원정보 수정이 완료되었습니다.')");
			script.println("location.href='main.jsp'");
			script.println("</script>");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("에러:"+e);
			
			response.sendRedirect("myPageModifyUser.jsp");
		}
		
	%>
	
	
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="src/bootstrap/js/bootstrap.js"></script>
</body>
</html>