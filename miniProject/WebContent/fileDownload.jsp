<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.InputStream"%>
<%@ page import="java.io.OutputStream"%>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.io.PrintWriter" %>
<%@ include file="ssi.jsp" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> [fileDownload.jsp]</title>
	<style type="text/css">
	  *{font-size:20pt; font-weight:bold; }
	</style>
</head>
<body>

   <%
   request.setCharacterEncoding("UTF-8");
   	GBno=Integer.parseInt(request.getParameter("no"));
    String path=application.getRealPath("./storage");
    String bUpload=request.getParameter("fileUpName");
    String boriginal = request.getParameter("fileDownName");
    File file=new File(path,bUpload);

    response.setHeader("Content-Disposition", "attachment;filename="+boriginal);
    
    try{
      InputStream is=new FileInputStream(file);
      OutputStream os=response.getOutputStream();
      
      byte[] temp =new byte[(int)file.length()];
      is.read(temp,0, temp.length );
      os.write(temp);
      is.close(); os.close(); 
      PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href=boardDetail.jsp?no="+GBno);
		script.println("</script>");
    }catch(Exception ex){System.out.println("다운에러:"+ex);}
   %>
   
</body>
</html>