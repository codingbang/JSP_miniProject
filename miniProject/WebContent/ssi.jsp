<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Insert title here</title>
</head>
<body>
	<%!
		Connection  CN;
		Statement ST, ST2;
		PreparedStatement PST;
		ResultSet RS, RS2;
		String sql, sql2;
		String data;
		
		
		/* 회원정보 변수 */
		String GuserId;
		String GuserPwd;
		String GuserName;
		String GuserPhone;
		String GuserEmail;
		String GuserAddr1;
		String GuserAddr2;
		String GuserAddrcode;
		String GuserUrl;
		Date GuserJoinday;
		
		/* 게시판정보 변수 */
		int Grownum;
		int GBno;
		String GBtitle;
		String GBcontent;
		Date GBdate;
		int GBstarpoint;
		int GBhitcount;
		String GBoriginal;
		String GBupload;
		int GBfileSize;
				
		//파일명 중복시 번호붙이기 위한 변수
		static int Gcount = 1;
		
		/* 페이징관련 */
		int GtotalPage;
		int GtotalBoard;
		
		/* 댓글 관련 */
		int GRno;
		String GRid;
		String GRcontent;
		Date GRdate;
		int GRCount;
		int GreplyCount;
		
		/* 쪽지 관련 */
		int GMno;
		String GMid; //받는 사람아이디
		String GMtitle;
		String GMcontent;
		Date GMdate;
		
		int Gno, G;
		int Gtotal;
		String Gname, Gtitle;
		
		
		int i;
		
		
		Date Gdate, dt;
	
	%>
	
	<%
		try{
		 	Class.forName( "oracle.jdbc.driver.OracleDriver" );
		 	String url="jdbc:oracle:thin:@127.0.0.1:1521:XE";
		 	String id = "study";
		 	String pwd = "study";
		 	CN=DriverManager.getConnection(url, id, pwd);
		 	//System.out.println("DB Connect Success" );	 
		}catch(Exception ex){
			ex.printStackTrace();
			System.out.println("DB Connect Failed=" + ex);	 
		}
	%>
	
</body>
</html>