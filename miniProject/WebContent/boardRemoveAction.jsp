<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="ssi.jsp"%>
<%@ page import="java.io.File" %>
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
			
			GBno=Integer.parseInt(request.getParameter("no"));
			GBupload=request.getParameter("file");

			sql="delete from bbs where b_no="+GBno;
			
			try{
				ST=CN.prepareStatement(sql);
				
				ST.executeUpdate(sql);
				
				String fileName = GBupload;
				String fileDir = "./storage";
				String filePath=request.getRealPath(fileDir)+"/";
				filePath+=fileName;
				
				File file = new File(filePath);
				System.out.println(file.getName());
				if( file.exists()) {
					file.delete(); // 파일이 존재하면 파일을 삭제한다.
				}
				
				response.sendRedirect("boardList.jsp");
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("에러:"+e);
				response.sendRedirect("boardList.jsp");
			}
			

	%>
	
	
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="src/bootstrap/js/bootstrap.js"></script>
</body>
</html>