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
		request.setCharacterEncoding("UTF-8");
	
	
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID=(String) session.getAttribute("userID");
		}
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("</script>");
			response.sendRedirect("login.jsp");
		} else {
			
		
			
			GMcontent=request.getParameter("content");
			GMid=request.getParameter("recvUser");
			
			int contentLength = GMcontent.length();
			
			if(contentLength>=10){
				GMtitle = GMcontent.substring(0, 10)+"...";
			} else {
				GMtitle = GMcontent.substring(0, contentLength);
			}
	
			sql = "insert into message (m_no, u_id, m_id, m_title, m_content, m_date ) ";
			sql+= "values(message_seq.nextVal, ?, ?, ?, ?, sysdate)";
			
			try{
				PST=CN.prepareStatement(sql);
				
				PST.setString(1, userID);
				PST.setString(2, GMid);
				PST.setString(3, GMtitle);
				PST.setString(4, GMcontent);

				PST.executeUpdate();
				
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('쪽지보내기 성공')");
				script.println("self.close()");
				script.println("</script>");

			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("에러:"+e);
				
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('쪽지보내기 실패')");
				script.println("self.close()");
				script.println("</script>");
			}
			
		}

	%>
	
	
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="src/bootstrap/js/bootstrap.js"></script>
</body>
</html>