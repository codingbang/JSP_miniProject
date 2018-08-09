<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<title>Insert title here</title>

<script>
$(document).ready(function() {
	
	$('.message').click(function() {
		var nowBtn = $(this).attr("id");
		console.log(nowBtn);
		
		var idIdx = nowBtn.replace(/[^0-9]/g,"");
		console.log(idIdx);
		var userId = $('#userId'+idIdx).val();
		console.log(userId);
		
		window.open("message.jsp?userId="+userId,"send","width=570,height=380, top=150, left=500, resizable=no");
	});
	
	/* $('#showPageFiled').change(function() {
		var showPage = $(this).val();
	}); */
	
	
});
</script>

</head>
<body>
	<jsp:include page="topNav.jsp" flush="false"/>
	
	
	<!-- 로그인 세션 정보 가져오기 -->
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
	%>
	
	<%
	
		/* 검색 */
		String searchSql="";
		String keyword="", keyValue="";
		String returnpage="";
	
		keyValue=request.getParameter("keyfield"); //title
		keyword=request.getParameter("keyword");  //p입력
		if(keyValue==null||keyValue==""||keyword==null||keyword==""){
			searchSql=" where b_title like '%%' ";	
			keyValue="";
			keyword="";
		}else{
			searchSql=" where "+keyValue+" like '%"+ keyword+"%' "; 
		}
	
		System.out.println(searchSql);
		returnpage="&keyfield="+keyValue+"&keyword="+keyword; 
		
		
		/* 페이징 */
		int nowPageNo; //현재 페이지 번호
		String pageNo;
		int showPage=10; //한 페이지에 보여줄 게시글 수
		//GtotalBoard=0; //총 게시글 수
		//GtotalPage =0; //총 페이지 수
		int startPage; //현재 페이지 기준 시작 페이지
		int endPage; //현재 페이지 기준 마지막 페이지
		int startRow; //페이지 별 시작 글번호
		int endRow;	//페이지 별 마지막 글번호
		
		try{
			ST=CN.createStatement();
			sql="select count(*) as cnt from bbs " + searchSql;
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
		String showPages= request.getParameter("showPage");
		if(showPages==null || showPages==""){
			showPage=10;
		}
		nowPageNo = Integer.parseInt(pageNo);
		
		//시작 행 과 마지막 행 구하기
		startRow=(nowPageNo-1)*10+1;
		endRow=startRow+9;
		
		
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
		endPage=startPage+9;
		
		//만약 마지막 페이지가 전체 페이지 수 보다 크면
		//마지막 페이지는 전체페이지 수로 변경
		if(endPage>GtotalPage){
			endPage=GtotalPage;
		}
		
		
		
	%>
	
	
	<!-- 게시판 리스트 -->
	<div class="container">
		<h2>자유게시판</h2>
		<!-- <div class="row">
			<div class="col-lg-2"></div>
			<div class="col-lg-9"></div>
			<div class="col-lg-1" align="right">
				<div style="margin-right: 75px;" >
					<select id="showPageFiled" class="form-control" style=" width: 90px;">
						<option>10</option>
						<option value="10">10개씩 보기</option>
						<option value="15">15개씩 보기</option>
						<option value="20">20개씩 보기</option>
					</select>
				</div>
			</div>
		</div> -->
		<div class="row">
			<table class="table table-striped table-hover table-responsive mytable">
				<thead>
					<tr style="text-align: center;" >
						<th>번호</th>
						<th>작성자</th>
						<th>제목</th>
						<th>작성일</th>
						<th>조회수</th>
					</tr>
				</thead>
				<tbody>
					<%
						try{
							ST=CN.createStatement();
							
							sql =  "SELECT * ";
							sql += "FROM ";
							sql += "   (SELECT rownum as rn, temp.* ";
							sql += "       FROM ";
							sql += "           (SELECT u_id, b_title, b_date, b_hitcount, b_no ";
							sql += "               FROM bbs "+searchSql;
							sql += "               ORDER BY b_date DESC ";
							sql += "           ) temp ";
							sql += "   ) ";
							sql += "WHERE rn between " +startRow+ " and "+endRow+ "ORDER BY b_date desc";
							
							
							/* sql = "select * from (select rownum as rn, u_id, b_title, b_date, b_hitcount, b_no from bbs ";
							sql += " where rn between "+ startRow + " and "  +endRow +")";
							sql += " order by b_date desc"; */
							
							RS=ST.executeQuery(sql);
						
						i=0;
						while(RS.next()){
							Grownum = RS.getInt("rn");
							GuserId= RS.getString("u_id");
							GBtitle = RS.getString("b_title");
							GBdate = RS.getDate("b_date");
							GBhitcount = RS.getInt("b_hitcount");
							GBno=RS.getInt("b_no");
							
							i=i+1;
							
						
							try{
								ST2=CN.createStatement();
								sql2 = "select count(*) as cnt from bbsreply where b_no="+GBno;
								RS2 = ST2.executeQuery(sql2);
								if(RS2.next()) {
									GreplyCount = RS2.getInt("cnt");
								}
							} catch (Exception e) {
								e.printStackTrace();
							}
					%>
						<tr>
							<td class="mytable-tds"><%=Grownum %></td>
							<%
								if(userID != null && userID.equals(GuserId)){	
							%>
									<td class="mytable-id"><%=GuserId %></td>
							<%
								} else {	
							%>
									<td class="mytable-id">
										<input type="hidden" id="userId<%=i%>" name="muserId" value="<%=GuserId%>">
										<a class="message" id="message<%=i%>"><%=GuserId %></a>
									</td>
							<%
								}
							%>
							<td class="mytable-title"><a href="boardDetail.jsp?no=<%=GBno %>"><%=GBtitle %>
							<span style="color: red; size: 4px;">[<%= GreplyCount %>]</span></a></td>
							<td class="mytable-tds"><%=GBdate %></td>
							<td class="mytable-tds"><%=GBhitcount %></td>
						</tr>
					
					<%
							}
						} catch (Exception e){
							e.printStackTrace();
						}
					
					%>
				</tbody>
			</table>
		</div>
		
		
		<!-- 페이징 -->
		<div id="paging" align="center">
			<nav>
				<ul class="pagination">
				    <%
						if(startPage>showPage) {
							out.print("<li><a href='boardList.jsp?pageNo="+(startPage-showPage)+returnpage+"' aria-label='Previous'>");
							out.println("&laquo;</a></li>");
						} 
				    	for(int i = startPage; i<=endPage; i++){
				    		if(nowPageNo==i){
				    			out.println("<li class='active'><a href='boardList.jsp?pageNo="+i+"'>"+i+"</a></li>");
				    		} else {
				    			out.println("<li><a href='boardList.jsp?pageNo="+i+returnpage+"'>"+i+"</a></li>");
				    		}
				    		
				    	}
					    if(endPage<GtotalPage) {
					    	out.print("<li><a href='boardList.jsp?pageNo="+(startPage+showPage)+returnpage+"' aria-label='Next'>");
							out.println("&raquo;</a></li>");
						}
					%>
				</ul>
				<!-- 글작성 버튼 -->
				<a href="boardWrite.jsp" class="btn btn-primary pull-right">글쓰기</a>
			</nav>
		</div>
		
			

		<div class="row">
			<div class="form-group" style="padding-left: 400px;">
				<div class="row">
					<form name="serach-form" class="form-horizontal" action="boardList.jsp" method="get">
						<div class="form-group">
							<select name="keyfield" class="form-control col-lg-2" style="width: 100px;">
								<option value="u_id">작성자</option>
								<option value="b_content">내용</option>
								<option value="b_title">제목</option>	
							</select>
							<input type="text" class="form-control col-lg-8" name="keyword" style="width: 200px;">
							<input type="submit" id="searchbtn" class="btn btn-default col-lg-1" value="검색">
						</div>
							
						<div> 
								
						</div>
							
						<div class="input-group form-group">
								
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	
	
	<jsp:include page="footer.jsp" flush="false"/>
	
	
	
	<script src="src/bootstrap/js/bootstrap.js"></script>
</body>
</html>