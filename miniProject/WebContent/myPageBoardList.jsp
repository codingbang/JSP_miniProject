<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ include file="ssi.jsp" %>
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
<link rel="stylesheet" href="src/css/mytable.css">

<!-- script  -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="src/js/userDelete.js"></script>
<title>Insert title here</title>


</head>
<body>
	<jsp:include page="topNav.jsp" flush="false"/>
	
	
	<!-- 로그인 세션 정보 가져오기 -->
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
		
		
		
		/* 페이징 */
		int nowPageNo; //현재 페이지 번호
		String pageNo;
		int showPage=5; //한 페이지에 보여줄 게시글 수
		//GtotalBoard=0; //총 게시글 수
		//GtotalPage =0; //총 페이지 수
		int startPage; //현재 페이지 기준 시작 페이지
		int endPage; //현재 페이지 기준 마지막 페이지
		int startRow; //페이지 별 시작 글번호
		int endRow;	//페이지 별 마지막 글번호
		
		try{
			ST=CN.createStatement();
			sql="select count(*) as cnt from bbs where u_id='"+userID+"'";
			RS=ST.executeQuery(sql);
			if(RS.next()) {
				GtotalBoard = RS.getInt("cnt");
			}
		} catch (Exception e){
			e.printStackTrace();
		}
		
		//주소에 페이지번호(Parameter)가 없을때
		pageNo=request.getParameter("pageNo");
		if(pageNo==null || pageNo==""){
			pageNo="1";
		}
		nowPageNo = Integer.parseInt(pageNo);
		
		//시작 행 과 마지막 행 구하기
		startRow=(nowPageNo-1)*5+1;
		endRow=startRow+4;
		
		
		//총 게시글 수가 보여줄 행 개수에 따른 전체 페이지 수 처리
		//ex)전체 게시글 293개, 보여줄 행 10개 일 때 전체 페이지 수는 30페이지가 나와야함.
		//293/10= 29에 나머지 값 3 이다. 3개의 게시글을 보여주기 위해 페이지 수 1 증가.
		if(GtotalBoard%showPage==0){
			GtotalPage=GtotalBoard/showPage;
		} else {
			GtotalPage=(GtotalBoard/showPage)+1;
		}
		
		//시작 페이지와 마지막 페이지 구하기
		startPage=nowPageNo - (nowPageNo-1)%showPage;
		endPage=startPage+4;
		
		//만약 마지막 페이지가 전체 페이지 수 보다 크면
		//마지막 페이지는 전체페이지 수로 변경
		if(endPage>GtotalPage){
			endPage=GtotalPage;
		}
		
		
		
	%>
	
	
	<div class="container">
		<div class="row">
			<h3>내가 쓴 글</h3>
		</div>
		<div class="row">
			<div class="myPage-container">

				<div class="row">
					<div id="myPage-nav" class="col-xs-2" align="right">
						<ul class="nav nav-pills nav-stacked">
							<li role="presentation"><a
								href="myPageMessageList.jsp">쪽지함</a></li>
							<li role="presentation" class="active"><a
								href="myPageBoardList.jsp">내가
									쓴 글</a></li>
							<li role="presentation"><a
								href="myPageReplyList.jsp">내가
									쓴 댓글</a></li>
							<li role="presentation"><a
								href="myPageModifyUser.jsp">회원
									정보 수정</a></li>
							<li role="presentation">
								<a href="#" onclick="openDeleteUsere()"><span style="color: #ff4d4d">회원 탈퇴</span></a></li>
						</ul>
					</div>
					<div class="row">
					<div class="col-md-1"></div>
						<div class="col-md-9"><br>
							<div class="row"><br></div>


							<div class="col-md-12">
							<table border="1" id="table1"
								class="table table-striped table-bordered table-hover">
								<tr align="center" valign="middle" bordercolor="#333333">
									<th class="col-md-1 mythstyle">번호</th>
									<th class="col-md-4 mythstyle">제목</th>
									<th class="col-md-1 mythstyle">작성자</th>
									<th class="col-md-1 mythstyle">작성일</th>
									<th class="col-md-1 mythstyle">조회수</th>
								</tr>
								
								<%
									try{
										ST=CN.createStatement();
										sql =  "SELECT * ";
										sql += "FROM ";
										sql += "   (SELECT rownum as rn, temp.* ";
										sql += "       FROM ";
										sql += "           (SELECT * ";
										sql += "               FROM bbs where u_id='"+ userID+"'";//+searchSql;
										sql += "               ORDER BY b_date DESC ";
										sql += "           ) temp ";
										sql += "   ) ";
										sql += "WHERE rn between " +startRow+ " and "+endRow+ " ORDER BY b_date desc";
										RS=ST.executeQuery(sql);
										
										i=1;
										int temp = 0;
										while(RS.next()){
											Grownum = RS.getInt("rn");
											GuserId= RS.getString("u_id");
											GBtitle = RS.getString("b_title");
											GBdate = RS.getDate("b_date");
											GBhitcount = RS.getInt("b_hitcount");
											GBno=RS.getInt("b_no");
											
											i=i+1;
											temp=temp+1;
								%>
											<tr>
												<td><%=Grownum %></td>
												<td><a href="boardDetail.jsp?no=<%=GBno %>"><%=GBtitle %></a></td>
												<td><%=GuserId %></td>
												<td><%=GBdate %></td>	
												<td><%=GBhitcount %></td>	
											</tr>
								<% 
										} //while end
										
										
										if(temp==0){
								%>
											<tr>
												<td colspan="5">게시글이 존재하지 않습니다.</td>
											</tr>
								<%
										}
									} catch(Exception e){
										e.printStackTrace();
									}
								%>
	
							</table>
							
							</div>
							
							<!-- 페이징 -->
							<div id="paging" align="center">
								<nav>
									<ul class="pagination">
									    <%
											if(startPage>showPage) {
												out.print("<li><a href='myPageBoardList.jsp?pageNo="+(startPage-showPage)+"' aria-label='Previous'>");
												out.println("&laquo;</a></li>");
											} 
									    	for(int i = startPage; i<=endPage; i++){
									    		if(nowPageNo==i){
									    			out.println("<li class='active'><a href='myPageBoardList.jsp?pageNo="+i+"'>"+i+"</a></li>");
									    		} else {
									    			out.println("<li><a href='myPageBoardList.jsp?pageNo="+i+"'>"+i+"</a></li>");
									    		}
									    		
									    	}
										    if(endPage<GtotalPage) {
										    	out.print("<li><a href='myPageBoardList.jsp?pageNo="+(startPage+showPage)+"' aria-label='Next'>");
												out.println("&raquo;</a></li>");
											}
										%>
									</ul>
								</nav>
							</div>
							<div class="col-md-1"></div>
						</div>
						
						
					</div>
				</div>
			</div>
		</div>
	</div>
	
	
	<jsp:include page="footer.jsp" flush="false"/>
	
	
	
	<script src="src/bootstrap/js/bootstrap.js"></script>
</body>
</html>