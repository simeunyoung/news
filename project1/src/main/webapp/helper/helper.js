// qnaForm에서 작성자에 포커스하는 기능
function begin() {
		document.qnaform.name.focus();
}

function check() {
	
	if(!document.qnaform.name.value) {
		alert("작성자를 입력하세요");
		return false;
	}
	
	if(!document.qnaform.email.value) {
		alert("답변받을 이메일을 입력하세요");
		return false;
	}
	
	if(!document.qnaform.content.value) {
		alert("내용을 입력하세요");
		return false;
	}
}