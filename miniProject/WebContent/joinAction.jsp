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
		request.setCharacterEncoding("UTF-8");
	
	
		GuserId=request.getParameter("userId");
		GuserPwd=request.getParameter("pwd2");
		GuserName=request.getParameter("userName");
		
		GuserEmail=request.getParameter("userEmail");
		GuserAddr1=request.getParameter("address1");
		GuserAddr2=request.getParameter("address2");
		GuserAddrcode=request.getParameter("zipCode");
		GuserUrl=request.getParameter("url");
		
		String uPhone1 = request.getParameter("phone1");
		String uPhone2 = request.getParameter("phone2");
		String uPhone3 = request.getParameter("phone3");
		GuserPhone=uPhone1 + uPhone2 + uPhone3;
		
		System.out.printf("%s-%s-%s-%s-%s-%s-%s-%s-%s\n",
				GuserId,GuserPwd,GuserName,GuserEmail,
				GuserAddr1,GuserAddr2,GuserAddrcode,GuserUrl,GuserPhone);
		
		String sql = "insert into users values(?, ?, ?, ?, ?, ?, ?, ?, ?, sysdate)";
		
		try{
			PST=CN.prepareStatement(sql);
			
			PST.setString(1, GuserId);
			PST.setString(2, GuserPwd);
			PST.setString(3, GuserName);
			PST.setString(4, GuserPhone);
			PST.setString(5, GuserEmail);
			PST.setString(6, GuserAddr1);
			PST.setString(7, GuserAddr2);
			PST.setString(8, GuserAddrcode);
			PST.setString(9, GuserUrl);
			
			PST.executeUpdate();
			
			session.setAttribute("userID", GuserId);
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('회원 가입을 축하드립니다!')");
			script.println("location.href='main.jsp'");
			script.println("</script>");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("에러:"+e);
			
			response.sendRedirect("join.jsp");
		}
		
	%>
	
	
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="src/bootstrap/js/bootstrap.js"></script>
</body>
</html>