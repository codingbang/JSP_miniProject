<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
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
	$("#removeBtn").click(function() {
		$('#removeCheckModal').modal('show');
	})
	$("#modalRemoveYes").click(function() {
		$('#removeBtn').submit();
	})
	


     $('#replyBtn').click(function() {
       
        var replyArea =$('#replyArea').val();
			if(replyArea.length == 0 ){
        	   $('#replyNullCheckModal').modal('show');
           	}else{
           		$('#replyWriteForm').submit();
            }
	});
	
	
	/* 댓글 수정처리 */
	$('.replyModifyBtn').click(function() {
		var nowBtn = $(this).attr("id");
		
		var idIdx = nowBtn.replace(/[^0-9]/g,"");
		var rno = $('#rno'+idIdx).val();
		
		window.open("replyModify.jsp?rno="+rno,"modify","width=570,height=250, top=150, left=500, resizable=no");
	});
	
	
	
	/* 댓글 삭제처리 */
	$(".replyRemoveBtn").click(function() {
		$('#replyRemoveCheckModal').modal('show');
		
		var nowBtn = $(this).attr("id");
	
		var idIdx = nowBtn.replace(/[^0-9]/g,"");
		var rno = $('#rno'+idIdx).val();
		
		$("#reply_remove_button").click(function() {
			
			var bno = $('#bno'+idIdx).val();
			location.href="replyRemoveAction.jsp?rno="+rno+"&bno="+bno;
	})
		
	})
	
	
	
	
         
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
		
		GuserId = request.getParameter("userId");
		GBno=Integer.parseInt(request.getParameter("no"));
		
		try{
			ST=CN.createStatement();
			sql="select * from bbs where b_no="+GBno;
			RS=ST.executeQuery(sql);
			
			if(RS.next()){
				GuserId=RS.getString("u_id");
				GBno=RS.getInt("b_no");
				GBtitle=RS.getString("b_title");
				GBcontent=RS.getString("b_content");
				GBdate=RS.getDate("b_date");
				//GBstarpoint=RS.getInt("b_starpoint");
				GBhitcount=RS.getInt("b_hitcount");
				GBhitcount=GBhitcount+1;
				GBoriginal=RS.getString("b_originalFileName");
				GBupload=RS.getString("b_uploadFileName");
	
	%>

			<div class="row">
				<h3 align="center">게시글 상세 화면</h3>
			</div>
		   
		   <!-- 게시글 상세 정보 -->
		   <div>
			   <div class="row">
			      <div class="col-md-2"></div>
			      <div class="col-md-8">
			         <table class="table">
			            <tr>
			               <td><b>번호</b></td>
			               <td><%=GBno %></td>
			            </tr>
			            <tr>
			               <td><b>작성자</b></td>
			               <td><%=GuserId %></td>
			            </tr>
			            <tr>
			               <td><b>작성일자</b></td>
			               <td><%=GBdate %></td>
			            </tr>
			            <tr>
			               <td><b>조회수</b></td>
			               <td><%=GBhitcount %></td>
			            </tr>
			            <!-- 조회수 처리 -->
			            <%
			            	ST2=CN.createStatement();
							sql2 = "UPDATE bbs SET b_hitcount=" + GBhitcount + " where b_no=" +GBno;
						 	ST2.executeUpdate(sql2);
						 	System.out.print(sql2);
			            
			            %>
			            <tr>
			               <td><b>제목</b></td>
			               <td colspan="3"><%=GBtitle %></td>
			            </tr>
			            <%
			            	System.out.println(1);
			            	if(GBoriginal != null) {
			            %>
			            <tr>
			               <td><b>첨부파일</b></td>
			               <td><a href="fileDownload.jsp?fileUpName=<%=GBupload %>&fileDownName=<%=GBoriginal %>&no=<%=GBno%>"><%=GBoriginal %></a></td>
			            </tr>
			            <%
			            	}
			            %>
			
			            <tr height="200">
			               <td><b>내용</b></td>
			               <td colspan="3" width="400px" nowrap>
			              	<br><%=GBcontent %>
			              </td>
			            </tr>
			            <%	System.out.println(2);
			            	int idx = GBoriginal.indexOf("."); 
			            	String fileNames = GBoriginal.substring(idx+1);

				            if(fileNames.equals("jpg")||fileNames.equals("png")||fileNames.equals("gif")||fileNames.equals("jpeg")
				            		||fileNames.equals("bmp")){
	      	
				        %>
				            	<tr>
					            	<td><b>첨부한 이미지</b></td>
					            	<td colspan="3"><img src="<%=request.getContextPath()%>/storage/<%=GBupload%>"  width=250 height=250></td>
					            </tr>
					            	
				       	<%
				            }
								}
							}catch(Exception e) {
									e.printStackTrace();
									System.out.println(sql);
								}
			            %>

			         </table>
			      </div>
			      <div class="col-md-2"></div>
			   </div>
		   </div><!-- 게시글 상세정보 끝 -->
			


   
		<!-- 댓글 불러오는곳 -->
		<div class="row">
			<div class="col-lg-2"></div>
			<div class="col-lg-8" >
			
				<table id="replyTable" class="table table-hover" style="background-color: #f2f2f2;">
				<font color="red" size="3"><b>댓글</b></font>
					<thead>
						<tr>
							<th>작성자</th>
							<th>내용</th>
							<th>작성일</th>
						</tr>
					</thead>
	
					<tbody>
						<%
							try{
								sql = "SELECT br.br_no, br.br_content, br.br_date, br.u_id ";
								sql += "FROM bbs b, bbsreply br ";
								sql += "WHERE b.b_no = br.b_no and b.b_no="+GBno;
								
								ST=CN.createStatement();
								RS=ST.executeQuery(sql);
								
								i=0;
								while(RS.next()){
									GRno=RS.getInt("br_no");
									GRid=RS.getString("u_id");
									GRcontent=RS.getString("br_content");
									GRdate=RS.getDate("br_date");	
						%>
									<tr>
										<td id="rid"><%=GRid %></td>
										<td><p><%=GRcontent %><p></td>
										<td><%=GRdate %></td>
							<%
										i=i+1;
										if(userID != null && userID.equals(GRid)){
											
							%>				
										
											<td align="right">
												<input type="hidden" id="rno<%=i%>" name="rno" value="<%=GRno%>">
												<input type="hidden" id="bno<%=i%>" name="bno" value="<%=GBno%>">
												<input class="btn btn-warning replyModifyBtn" id="replyModifyBtn<%=i%>"name="" type="button"
												value="수정">
												<input class="btn btn-danger replyRemoveBtn" id="replyRemoveBtn<%=i%>" type="button"
												value="삭제">
											</td>
	
									</tr>
									
						<%
										}
								}
							} catch (Exception e) {
								e.printStackTrace();
							} 
						%>
						
					</tbody>
					
				</table>
			</div>
			<div class="col-lg-2"></div>
		</div>

   <%
		if(userID != null){	
	%>
   <!--  댓글 등록 부분 -->
	<div class="container" id=regReply>
		<div class="row">
     		<div class="col-lg-2"></div>
      		<div class="col-lg-8">
      			<form action="replyWriteAction.jsp" method="post" id="replyWriteForm">
      				<input type="hidden" name="no" id="no"  value="<%=GBno %>">
					<input type="hidden" name="userId" id="userId" value="<%=userID %>">
					<table id="registerReplyTable" class="table">
	            		<tr>
	               			<td>
	               				<textarea class="form-control" id="replyArea" name="rcontent" rows="6" style="resize: none;"></textarea>
	               			</td>
	           			</tr>
	           			
						<tr align="right">
			               <td>
			                  <input type="button" id="replyBtn" name="replyBtn" class="btn btn-primary" value="댓글등록">
			               </td>
						</tr>
					</table>
				</form>
			</div>
		</div>
		<div class="col-lg-2"></div>
	</div><!-- 댓글 등록 끝 -->
	<%
		}
	%>
	
	<!-- 수정/삭제버튼 -->
	<div class="row">
		<!-- 게시글 수정 삭제 버튼 -->
		<div class="row">
			<div class="col-lg-5"></div>
			<div class="col-lg-2" role="group">
				<%
					if(userID != null && userID.equals(GuserId)){	
				%>
				<div style="float: left; width: 33%;"> 
					
		            <form action="boardModify.jsp" method="get">
						<input type="hidden" name="no" value="<%=GBno %>"> 
						<input type="submit" class="btn btn-default" value="수정">
		            </form>
	          	</div>
	          	<div style="float: left; width: 33%;"> 
		            <form action="boardRemoveAction.jsp" method="get" id="removeBtn">
						<input type="hidden" name="no"  value="<%=GBno %>">
						<input type="hidden" name="file"  value="<%=GBupload %>"> 
	                    <input type="button" class="btn btn-default" value="삭제">
	                </form>
		         
	          	</div>
	          	<div style="float: left; width: 33%;"> 
					<form action="boardList.jsp" method="get">
						<input type="submit" class="btn btn-default" value="목록 조회">
					</form>
	          	</div>
	          	<%
		             } else {
		        %>
	          	<div align="center"> 
					<form action="boardList.jsp" method="get">
						<input type="submit" class="btn btn-default" value="목록 조회">
					</form>
	          	</div>
		        
		        <%
		             }
		        %>	
			</div>
			<div class="col-lg-5"></div>
		</div>
	</div>
	
	
	<!-- 모달영역 -->
	<!-- 게시글 삭제 확인여부 -->
	<div class="modal fade" id="removeCheckModal">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title">삭제 안내</h4>
	      </div>
	      <div class="modal-body">
	        <p>게시글을 정말로 삭제 하시겠습니까?</p>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	        <button type="button" id="modalRemoveYes" class="btn btn-primary">Yes</button>
	      </div>
	    </div>
	  </div>
	</div><!-- 게시글 삭제 모달 끝 -->
	
	
	<!-- 댓글 내용 null여부 확인 모달 -->
	<div class="modal fade" id="replyNullCheckModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">

		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body" id="body1">
					<div id="body2" style="display: block;">
						<h4 align="center">댓글 내용이 비어있습니다.</h4>
					</div>
				</div>
				<div class="modal-footer" id="buttonbtn1">
					<div id="buttonbtn2" style="display: block;">
						<button id="yesToAll" class="btn btn-primary"
							data-dismiss="modal">확인</button>
					</div>
				</div>
			</div>
		</div>
	</div><!-- 댓글 내용 null여부 모달 끝 -->
	
			
	<!-- 댓글 삭제 확인 여부 모달 -->
	<div class="modal fade" id="replyRemoveCheckModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body" id="body1">
					<div id="body2" style="display: block;">
						<h4 align="center">댓글을 삭제하시겠습니까?</h4>
					</div>
				</div>
				<div class="modal-footer" id="buttonbtn1">
					<div id="buttonbtn2" style="display: block;">
						<button id="reply_remove_button" class="btn btn-primary"
							data-dismiss="modal">예</button>
						<button id="denied_button" class="btn btn-primary"
							data-dismiss="modal">아니요</button>
					</div>
				</div>
			</div>
		</div>
	</div><!-- 댓글 삭제 확인 여부 모달 끝 -->
	
	
	
	<jsp:include page="footer.jsp" flush="false"/>
	
	
	
	<script src="src/bootstrap/js/bootstrap.js"></script>
</body>
</html>