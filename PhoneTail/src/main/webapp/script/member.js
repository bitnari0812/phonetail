function login_Check(){
	if(document.login.userid.value==''){
		alert("아이디를 입력하세요.");
		document.login.userid.focus();
		return false;
	}else if(document.login.pwd.value==''){
		alert("비밀번호를 입력하세요.");
		document.login.pwd.focus();
		return false;
	}else{
		return true;
	}
}