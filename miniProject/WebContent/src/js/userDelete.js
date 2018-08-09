function openDeleteUsere(){
	window.open("openDeleteUser.jsp","dd","width=470,height=300,top=100,left=100");
}

function reCheck(){
	alert('본인확인을 위해 아이디와 비밀번호를 다시 입력해주세요.');
}
function deleteUserBtn(){
	var flag_id = false;
	var flag_pwd = false;
	
	var userid = deleteUserForm.userid.value;
	var pwd=deleteUserForm.pwd.value;

	
	if (userid==null||userid=="") {
		alert("아이디를 입력하세요.");
		flag_id=false;
		deleteUserForm.userid.focus();
		return;
	}else {
		flag_id=true;
	}
	
	if (pwd==null||pwd=="") {
		alert("비민번호를 입력하세요.");
		flag_pwd=false;
		deleteUserForm.pwd.focus();
		return;
	} else {
		flag_pwd=true;
	}
	
	if (flag_id==true&&flag_pwd==true) {
		if(confirm("정말로 탈퇴를 하시겠습니까?")){
			location.href="myPageDeleteUserAction.jsp?userid="+userid+"&pwd="+pwd;
		}
	} else {
		return;
	}
	
	
}
