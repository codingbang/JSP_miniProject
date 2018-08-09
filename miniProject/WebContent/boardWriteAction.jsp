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
			request.setCharacterEncoding("UTF-8");
			String savePath = application.getRealPath("./storage");
			int fileSize = 1024*1024*25;
			
			File file;
			if(!(file = new File(savePath)).isDirectory()){
			    file.mkdirs();
			}
			 
			MultipartRequest mr = new MultipartRequest(request, savePath, fileSize, "UTF-8", new MyFileRenamePolicy());

			//오리지날 파일네임
			//System.out.println(filename);
			//톰켓 서버 폴더에 저장되는 이름. (uploadName)
			//response.getWriter().append(savePath + "/" + filename);
			ServletContext context = request.getSession().getServletContext();
			GBoriginal=mr.getOriginalFileName("file1");
			GBupload=mr.getFilesystemName("file1");
			GBtitle=mr.getParameter("title");
			GBcontent=mr.getParameter("content");
			
			
			System.out.println(GBtitle);
		
			
			sql = "insert into bbs (b_no, u_id, b_title, b_content, b_date, ";
			sql+= "b_starpoint, b_hitcount, b_originalFileName, b_uploadFileName, b_fileSize)";
			sql+= "values(bbs_seq.nextVal, ?, ?, ?, sysdate, null, 0, ?, ?, 0)";
			
			try{
				PST=CN.prepareStatement(sql);
				
				PST.setString(1, userID);
				PST.setString(2, GBtitle);
				PST.setString(3, GBcontent);
				PST.setString(4, GBoriginal);
				PST.setString(5, GBupload);
				
				PST.executeUpdate();
				
				response.sendRedirect("boardList.jsp");
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