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
			
		
			
			GRcontent=request.getParameter("rcontent");
			GBno=Integer.parseInt(request.getParameter("no"));
	
			sql = "insert into bbsreply (br_no, br_content, br_date, b_no, u_id ) ";
			sql+= "values(bbsreply_seq.nextVal, ?, sysdate, ?, ?)";
			
			try{
				PST=CN.prepareStatement(sql);
				
				PST.setString(1, GRcontent);
				PST.setInt(2, GBno);
				PST.setString(3, userID);

				PST.executeUpdate();
				
				response.sendRedirect("boardDetail.jsp?no="+GBno);
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("에러:"+e);
				
				response.sendRedirect("boardDetail.jsp?no="+GBno);
			} 
			
		}

	%>
	
	
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="src/bootstrap/js/bootstrap.js"></script>
</body>
</html>