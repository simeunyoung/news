function start() {
	document.myform.id.focus();
}
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

