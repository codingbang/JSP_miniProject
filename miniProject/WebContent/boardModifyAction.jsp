<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="ssi.jsp"%>
<%@ page import="java.io.PrintWriter" %>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.MyFileRenamePolicy" %>
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
			
			String savePath = application.getRealPath("./storage");
			int fileSize = 1024*1024*25;
			
			File file;
			if(!(file = new File(savePath)).isDirectory()){
			    file.mkdirs();
			}
			 
			MultipartRequest mr = new MultipartRequest(request, savePath, fileSize, "UTF-8", new MyFileRenamePolicy());

			ServletContext context = request.getSession().getServletContext();
			GBoriginal=mr.getOriginalFileName("file2");
			GBupload=mr.getFilesystemName("file2");
			GBno=Integer.parseInt(mr.getParameter("no"));
			GBtitle=mr.getParameter("title");
			GBcontent=mr.getParameter("content");
			
			String addBoriginal;
			String addBupload;
			addBoriginal=mr.getOriginalFileName("file3");
			if(addBoriginal ==null) {
				
				sql="update bbs set b_title=?, b_content=?, b_originalFileName=?, b_uploadFileName=? where b_no="+GBno;
				
				try{
					PST=CN.prepareStatement(sql);
					
					PST.setString(1, GBtitle);
					PST.setString(2, GBcontent);
					PST.setString(3, GBoriginal);
					PST.setString(4, GBupload);
					
					PST.executeUpdate();
					

					response.sendRedirect("boardDetail.jsp?no="+GBno);
				} catch (Exception e) {
					e.printStackTrace();
					System.out.println("에러:"+e);
					
					response.sendRedirect("boardList.jsp");
				}
				
			} else {
				addBupload=mr.getFilesystemName("file3");
				
				sql="update bbs set b_title=?, b_content=?, b_originalFileName=?, b_uploadFileName=?, b_date=sysdate where b_no="+GBno;
				
				try{
					PST=CN.prepareStatement(sql);
					
					PST.setString(1, GBtitle);
					PST.setString(2, GBcontent);
					PST.setString(3, addBoriginal);
					PST.setString(4, addBupload);
					
					PST.executeUpdate();
					

					response.sendRedirect("boardDetail.jsp?no="+GBno);
				} catch (Exception e) {
					e.printStackTrace();
					System.out.println("에러:"+e);
					
					response.sendRedirect("boardList.jsp");
				}
			}



			
			

	%>
	
	
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="src/bootstrap/js/bootstrap.js"></script>
</body>
</html>