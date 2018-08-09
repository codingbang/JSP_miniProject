<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="ssi.jsp"%>
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

<!-- script  -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="src/smartEditor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>

<script type="text/javascript"> 
var oEditors = [];

$(function(){ 
	nhn.husky.EZCreator.createInIFrame ({
	oAppRef: oEditors, 
	elPlaceHolder: "editor", 
	//SmartEditor2Skin.html 파일이 존재하는 경로 
	sSkinURI: "src/smartEditor/SmartEditor2Skin.html",	
	htParams : { 
		// 툴바 사용 여부 (true:사용/ false:사용하지 않음) 
		bUseToolbar : true,	
		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음) 
		bUseVerticalResizer : true,	
		// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음) 
		bUseModeChanger : true,	
		fOnBeforeUnload : function(){ } 
		}, 
		
		/* 
		//수정할때 사용
		fOnAppLoad : function(){ 
			//기존 저장된 내용의 text 내용을 에디터상에 뿌려주고자 할때 사용 
			oEditors.getById["editor"].exec("PASTE_HTML", ["기존 DB에 저장된 내용을 에디터에 적용할 문구"]); 
		},  */
		fCreator: "createSEditor2" 
	}); 
	$("#savebutton").click(function() {
		//id가 smarteditor인 textarea에 에디터에서 대입
		oEditors.getById["editor"].exec("UPDATE_CONTENTS_FIELD", []);
		//폼 submit
		$("#modifyForm").submit();
	})
	
	$("#fileRemovebtn").click(function() {
		$('#removeCheckModal').modal('show');
		
		$("#modalRemoveYes").click(function() {
			var bno= $("#bno").val();
			var uploadFile = $("#uploadFile").val();
			location.href="fileRemove.jsp?no="+bno+"&upload="+uploadFile;
		})
	}) 

});


	

</script>


<title>Insert title here</title>
</head>
<body>
	<jsp:include page="topNav.jsp" flush="false" />

	<%
		GBno = Integer.parseInt(request.getParameter("no"));
		
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
				GBoriginal=RS.getString("b_originalFileName");
				GBupload = RS.getString("b_uploadFileName");
			}
				
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println(sql);
		}
	%>

	<div class="row">
		<div class="col-md-12 col-lg-12">
			<h3 align="center"><b>게시글 수정</b></h3>
		</div>
	</div>
	
	<div class="row">
		<div class="col-md-1 col-lg-1"></div>
		
		<div class="col-md-10 col-lg-10">
			<form
				action="boardModifyAction.jsp" method="post" enctype="multipart/form-data" id="modifyForm">
				<table class="table">
					<tr>
						<td><b>제목</b></td>
						<td><input type="text" id="title" name="title" class="form-control" style="width: 766px;" size="80"
						value="<%=GBtitle %>"></td>
					</tr>
					<tr>
						<td><b>내용</b></td>
						<td><textarea name="content" id="editor" rows="10" cols="100"
								style="width: 766px; height: 412px;"><%=GBcontent %></textarea></td>
					</tr>
					
					<%
						if(GBoriginal!=null){

					%>
					<tr>
						<td><b>File</b></td>
						<td>
							<input type="file" id="file2" name="file2">
							<%=GBoriginal %>
							<input type="hidden" id="uploadFile" name="no" value="<%=GBupload %>">
							<button id="fileRemovebtn" class="btn btn-default" type="button">삭제</button>
						</td>
					</tr>
					
					<%
						} else {
					%>
						<tr>
							<td><b>File</b></td>
							<td>
								<input type="file" id="file3" name="file3">
								<input type="hidden" id="uploadFile" name="no" value="<%=GBupload %>">
							</td>
						</tr>

					<%
						}
					%>


					
					<tr align="center">
						<td colspan="2">
							<div class="col-lg-3"></div>
							<div class="col-lg-3" role="group">
								<div style="float: left; width: 33%;">
									<form action="boardModifyAction.jsp" method="post">
										<input type="hidden" id="bno" name="no" value="<%= GBno %>">
										<input type="submit" id="savebutton" class="btn btn-primary" value="게시글 수정">
									</form>
								</div>
								<div style="float: left; width: 33%;">
									<form action="boardDetail.jsp" method="post">
										<input type="hidden" name="userId" value="<%= GuserId %>">
										<input type="submit" class="btn btn-default" value="돌아가기">
									</form>
								</div>
								<div style="float: left; width: 33%;">
									<form action="boardList.jsp">
										<input type="submit" class="btn btn-default" value="게시글 목록">
									</form>
								</div>
							</div>
							<div class="col-lg-6"></div>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div class="col-md-1 col-lg-1"></div>
	</div>
	
	
	
	<!-- 모달영역 -->
	<!-- 제목 및 내용 null 여부 확인 모달 -->
	<div class="modal fade" id="myModal1" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">

		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body" id="body1">
					<div id="body2" style="display: block;">
						<h4 align="center">제목 혹은 내용이 비어있습니다.</h4>
					</div>
				</div>
				<div class="modal-footer" id="buttonbtn1">
					<div id="buttonbtn2" style="display: block;">
						<button id="confirm_button" class="btn btn-primary"
							data-dismiss="modal">확인</button>
					</div>
				</div>
			</div>
		</div>
	</div><!-- 제목 및 내용 null 여부 확인 모달 -->
	
	<!-- 게시글 삭제 확인여부 -->
	<div class="modal fade" id="removeCheckModal">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title">삭제 안내</h4>
	      </div>
	      <div class="modal-body">
	        <p>첨부파일을 정말로 삭제 하시겠습니까?</p>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	        <button type="button" id="modalRemoveYes" class="btn btn-primary">Yes</button>
	      </div>
	    </div>
	  </div>
	</div><!-- 게시글 삭제 모달 끝 -->
	<!-- 모달영역 끝 -->

	<jsp:include page="footer.jsp" flush="false" />



	<script src="src/bootstrap/js/bootstrap.js"></script>
</body>
</html>