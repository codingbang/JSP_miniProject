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
		PrintWriter script = response.getWriter();
		
		GuserId=request.getParameter("userid");
		GuserPwd=request.getParameter("pwd");
		
		if(!GuserId.equals(userID)){
			script.println("<script>");
			script.println("alert('로그인한 아이디와 입력한 아이디가 불일치합니다.')");
			script.println("self.close()");
			script.println("</script>");
			
		} else {
			
			sql = "select count(*) as cnt from users where u_id=? and u_pwd=?";
			try {
				PST=CN.prepareStatement(sql);
				
				PST.setString(1, GuserId);
				PST.setString(2, GuserPwd);
				
				RS=PST.executeQuery();
				
				if(RS.next()){
					Gtotal = RS.getInt("cnt");
				}
				
				
				if(Gtotal>0){
					sql2 = "delete from users where u_id='"+userID+"'";
					try{
						ST2=CN.createStatement();
						ST2.executeQuery(sql2);
						
						script.println("<script>");
						script.println("alert('회원 탈퇴가 완료되었습니다..')");
						script.println("opener.location.href='main.jsp'");
						script.println("self.close()");
						script.println("</script>");
						
						session.invalidate();
						
					} catch (Exception e) {
						e.printStackTrace();
						script.println("<script>");
						script.println("location.href='myPage.jsp'");
						script.println("</script>");

					}
				} else {
					script.println("<script>");
					script.println("alert('회원정보가 정확하지 않습니다.')");
					script.println("location.href='myPage.jsp'");
					script.println("</script>");
				}
			}catch (Exception e) {
				e.printStackTrace();
			}
			
		}
		
		
		
		
		
	%>
	
	
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="src/bootstrap/js/bootstrap.js"></script>
</body>
</html>