var flag=false;
var flag_id=false;
var flag_pwd=false;
var flag_phone=false;
var flag_email=false;


function check(){
	var userId = joinForm.userId.value;
	var pwd1=joinForm.pwd1.value;
	var pwd2=joinForm.pwd2.value;
	
	var userName=joinForm.userName.value;
	var userEmail=joinForm.userEmail.value;
	var phone1=joinForm.phone1.value;
	var phone2=joinForm.phone2.value;
	var phone3=joinForm.phone3.value;
	
	var zipCode=joinForm.zipCode.value;
	var address1=joinForm.address1.value;
	var address2=joinForm.address2.value;
	
	if (userId==null||userId=="") {
		alert("아이디를 입력하세요.");
		joinForm.userId.focus();
		return;
	}
	
	if (userName==null||userName=="") {
		alert("이름을 입력하세요.");
		joinForm.userName.focus();
		return;
	}
	
	if (pwd1==null||pwd1=="") {
		alert("비밀번호를 입력하세요.");
		joinForm.pwd1.focus();
		return;
	}
	
	if (pwd2==null||pwd2=="") {
		alert("비민번호를 재입력하세요.");
		joinForm.pwd2.focus();
		return;
	}
	
	if (zipCode==null||zipCode==""||address1==null||address1==""||address2==null||address2=="") {
		alert("주소를 입력하세요.");
		joinForm.zipCode.focus();
		return;
	}
	
	if (phone2==null||phone2==""||phone3==null||phone3=="") {
		alert("전화번호를 입력하세요.");
		joinForm.phone2.focus();
		return;
	}
	
	flag=true;
	
	if (flag_id==false) {
		alert("아이디 중복체크를 해주세요.");
		return;
	}
	
	if (flag_pwd==false) {
		alert("비밀번호가 일치하지 않습니다.");
		joinForm.pwd2.focus();
		return;
	}
	if (flag_phone==false) {
		alert("전화번호를 올바르게 입력하세요.");
		joinForm.phone2.focus();
		return;
	}
	
	if (flag==true&&flag_id==true&&flag_pwd==true&&flag_phone==true&&flag_email==true) {
		document.getElementById("joinForm").submit();
	} else {
		return;
	}
	
}


function checkId(){
	var userId = joinForm.userId.value;
	var label = document.getElementById("userIdLabel");
	
	if (userId==""||userId==null) {
		label.innerHTML="<font color='red'>아이디를 입력하세요.</font>";
		joinForm.userId.focus();
		return;
	} 
	label.innerHTML="";
	window.open("openCheckId.jsp?userId="+userId,"","width=470,height=200,top=100,left=100");
	flag_id_t();
}



function flag_id_t(){
	flag_id=true;
}



function checkPwd(){
	var str = document.getElementById("pwdLabel2");
	if (joinForm.pwd1.value == joinForm.pwd2.value) {
		str.innerHTML="비밀번호가 일치합니다";
		flag_pwd=true;
	} else {
		str.innerHTML = "<font color='red'>비밀번호가 일치하지 않습니다.</font>";
	}
}

function checkPwdReg(){
	var pwd1=joinForm.pwd1.value;
	//var pwd_reg=/^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{6,16}$/;
	var pwd_reg=/^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,16}$/;
	var label=document.getElementById("pwdLabel1");
	var test = pwd_reg.test(pwd1);
	if (test==false) {
		//msg="<font color='red'>6~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.</font>";
		msg="<font color='red'>6~16자 영문 대소문자 및 숫자 조합을 사용하세요.</font>";
		label.innerHTML=msg;
		return;
	} else {
		label.innerHTML="";
	}

}

function emailcheck(){
	var userEmail=joinForm.userEmail.value;
	var mail_reg=/^([\S]{2,16})@([a-zA-Z]{2,10})\.([a-zA-Z]{2,10})$/;
	if (mail_reg.test(userEmail)==false) {
		msg="<font color='red'>이메일 형식 체크하세요</font>";
		document.getElementById("email_ch").innerHTML=msg;
		joinForm.userEmail.value="";
		return;
	} else {
		flag_email=true;
		document.getElementById("email_ch").innerHTML="";
	}
}



function checklen(obj, maxByte){
	var strValue = obj.value;
	var strLen = strValue.length;
	var totalByte = 0;
	var len = 0;
	var oneChar="";
	var str2="";
	
	for (var i = 0; i < strLen; i++) {
		oneChar=strValue.charAt(i);
		if (escape(oneChar).length > 4) {
			totalByte += 2;
		} else {
			totalByte++;
		}
		if (totalByte <= maxByte) {
			len = i+1;
		}
	}
	
	if (totalByte > maxByte) {
		alert(maxByte+"Byte를 초과 입력 불가");
		str2=strValue.subStr(0, len);
		obj.value = str2;
	}
}




function DaumPostcode(){
	new daum.Postcode({
		oncomplete: function(data) {
			var fullAddr = '';
			var extraAddr ='';
			
			if (data.userSelectedType === 'R') {
				fullAddr = data.roadAddress;
			} else {
				fullAddr = data.jibunAddress;
			}
			
			if (data.userSelectedType === 'R') {
				if (data.bname != '') {
					extraAddr += data.bname;
				}
				if (data.buildingName !== '') {
					extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
				}
				fullAddr += (extraAddr !== '' ? ' ('+extraAddr+')' : '');
			}
			
			document.getElementById("zipCode").value = data.zonecode;
			document.getElementById('address1').value = fullAddr;
			
			document.getElementById('address2').focus();
		}
	})
	.open();
}



function phone(){
	var str2=joinForm.phone2.value;
	var str3=joinForm.phone3.value;
	var num_reg=/[(0-9)]{3,4}/;
	var label=document.getElementById("numLable");
	var test2=num_reg.test(str2);
	var test3=num_reg.test(str3);
	var div = document.getElementById("divPhone2");
	
	if (test2==false||test3==false) {
		label.innerHTML="숫자3~4자리 입력하세요";
		div.style.marginLeft = "-81.5px";
		div.style.paddingLeft = "9px";
	} else {
		div.style.marginLeft = "-5px";
		div.style.paddingLeft = "6px";
		label.innerHTML="";
		flag_phone=true;
	}

}
