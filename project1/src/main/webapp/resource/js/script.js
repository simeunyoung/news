function start() {
	document.myform.id.focus();
}

// 로그인 유효성
function loginCheck() {
	if (!document.myform.id.value) {
		alert("아이디를 입력하지 않으셨습니다.");
		document.myform.id.focus();
		return false;
	}
	if (!document.myform.pw.value) {
		alert("비밀번호를 입력하지 않으셨습니다.");
		document.myform.pw.focus();
		return false;
	}
}

// 회원가입 유효성
function inputCheck() {
	userinput = eval("document.userinput");
	if (!userinput.id.value) {
		alert("아이디를 입력하세요.");
		userinput.id.focus();
		return false;
	}
	if (!userinput.pw.value) {
		alert("비밀번호를 입력하세요.");
		userinput.pw.focus();
		return false;
	}
	if (!userinput.pwCheck.value) {
		alert("비밀번호 확인을 입력하세요.");
		userinput.pwCheck.focus();
		return false;
	}
	if (!userinput.name.value) {
		alert("이름을 입력하세요.");
		userinput.name.focus();
		return false;
	}
	if (!userinput.nick.value) {
		alert("닉네임을 입력하세요.");
		userinput.nick.focus();
		return false;
	}
	if (!userinput.birthdate.value) {
		alert("생년월일을 입력하세요.");
		userinput.birthdate.focus();
		return false;
	}
	if (!userinput.email.value) {
		alert("이메일을 입력하세요.");
		userinput.email.focus();
		return false;
	}
	if (!userinput.tel.value) {
		alert("핸드폰번호를 입력하세요.");
		userinput.tel.focus();
		return false;
	}
}


// 아이디 중복 검사
	function openConfirmId(userinput){
		// 아이디 입력했는지 검사
		var id = userinput.id.value;
		if(id == ""){
			alert("아이디를 입력하세요.")
			return;
		}
		
		// url과 사용자 입력 id를 조합
		url = "confirmId.jsp?id="+id;
		
		// 새로운 윈도우를 열기
		open(url, "confirm" , "toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizeble=no,width=300,height=200");
	}