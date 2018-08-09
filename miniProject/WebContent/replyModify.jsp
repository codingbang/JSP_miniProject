<%@page import="sun.font.CreatedFontTracker"%>
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
	
	
	/* var replyId = null; */

     $('#replyBtn').click(function() {
    	var rno = $('#rno').val();
        var replyArea =$('#replyArea').val();
			if(replyArea.length == 0 ){
        	   $('#replyNullCheckModal').modal('show');
           	}else{
           		$('#replyModifyForm').submit();
            }
	});
	
         
});
</script>



</head>
<body>
	<%
		GRno = Integer.parseInt(request.getParameter("rno"));
		try{
			ST=CN.createStatement();
			sql="select * from bbsreply where br_no="+GRno;
			RS=ST.executeQuery(sql);
			
			if(RS.next()){
				GuserId=RS.getString("u_id");
				GBno=RS.getInt("b_no");
				GRcontent=RS.getString("br_content");
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	
	%>

   <!--  댓글 수정 부분 -->
	<div class="container" id=regReply>
		<div class="row">
     		<div class="col-lg-2"></div>
      		<div class="col-lg-8">
      			<form action="replyModifyAction.jsp" method="post" id="replyModifyForm">
      				<input type="hidden" name="rno" id="rno"  value="<%=GRno %>">
					<input type="hidden" name="bno" id="bno" value="<%=GBno %>">
					<table id="registerReplyTable" class="table">
	            		<tr>
	               			<td>
	               				<textarea class="form-control" id="replyArea" name="rcontent" rows="6" style="resize: none;"><%=GRcontent %></textarea>
	               			</td>
	           			</tr>
	           			
						<tr align="right">
			               <td>
			                  <input type="button" id="replyBtn" name="replyBtn" class="btn btn-primary" value="댓글수정">
			               </td>
						</tr>
					</table>
				</form>
			</div>
		</div>
		<div class="col-lg-2"></div>
	</div><!-- 댓글 수정 끝 -->
	
	
	
	
	
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
		
	
	<script src="src/bootstrap/js/bootstrap.js"></script>
</body>
</html>