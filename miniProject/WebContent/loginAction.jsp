<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ include file="ssi.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>jSP게시판 Study</title>
</head>
<body>
	<%
		String userID = null;
		//세션 정보가 있으면 userID 변수에 저장
		if(session.getAttribute("userID") != null){
			userID=(String) session.getAttribute("userID");
		}
		//세션정보를 가져오지 못해 userID변수에 값이없으면
		if(userID != null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href='main.jsp'");
			script.println("</script>");
		}
		
		GuserId = request.getParameter("userId");
		GuserPwd = request.getParameter("userPwd");
		
		sql = "select count(*) as cnt from users where u_id=? and u_pwd=?";
		try {
			PST=CN.prepareStatement(sql);
			
			PST.setString(1, GuserId);
			PST.setString(2, GuserPwd);
			
			RS=PST.executeQuery();
			
			if(RS.next()){
				Gtotal = RS.getInt("cnt");
			}
			
			PrintWriter script = response.getWriter();
			if(Gtotal>0){
				session.setAttribute("userID", GuserId);
				script.println("<script>");
				script.println("alert('로그인에 성공하였습니다.')");
				script.println("location.href='main.jsp'");
				script.println("</script>");
			} else {
				script.println("<script>");
				script.println("alert('없는 아이디거나 비밀번호가 틀렸습니다.')");
				script.println("location.href='login.jsp'");
				script.println("</script>");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}

	%>
	

</html>