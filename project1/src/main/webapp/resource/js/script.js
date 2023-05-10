function start() {
	document.myform.id.focus();
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
      var url = "confirmId.jsp?id="+id;
      
      // 새로운 윈도우를 열기
      open(url, "confirm" , "toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizeble=no,width=300,height=200");
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
	}else if(!(userinput.id.value.length >= 5 && userinput.id.value.length <= 20)){ 
		alert("아이디는 5 ~ 20자 이내로 입력해주세요.");
		userinput.id.focus(); 
		return false;
	}else if ((userinput.id.value.match(/\d/g) || []).length < 1) { 
	    alert("아이디는 숫자가 하나 이상 포함되어야 합니다."); 
	    userinput.id.focus(); 
	    return false; 
	}
	
	if (!userinput.pw.value) {
		alert("비밀번호를 입력하세요.");
		userinput.pw.focus();
		return false;
	}else if(!(userinput.pw.value.length >= 8 && userinput.pw.value.length <= 16)){ 
		alert("비밀번호는 8 ~ 16자 이내로 입력해주세요.");
		userinput.pw.focus(); 
		return false;
	}else if (!userinput.pw.value.match(/[!@#$%^&*(),.?":{}|<>]/)) {
	    alert("비밀번호는 특수문자가 하나 이상 포함되어야 합니다."); 
	    userinput.pw.focus(); 
	    return false; 
	}
	
	if (!userinput.pwCheck.value) {
		alert("비밀번호 확인을 입력하세요.");
		userinput.pwCheck.focus();
		return false;
	}else if (!(userinput.pwCheck.value == userinput.pw.value)) {
		alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
		userinput.pwCheck.focus();
		return false;
	}
	
	if (!userinput.name.value) {
		alert("이름을 입력하세요.");
		userinput.name.focus();
		return false;
	}else if (userinput.name.value.length > 40) {
		alert("이름은 40자 이내로 입력해주세요.");
		userinput.name.focus();
		return false;
	}else if (userinput.name.value.match(/[!@#$%^&*(),.?":{}|<>]/)) {
		alert("이름에 특수문자는 사용 불가능 합니다.");
		userinput.name.focus();
		return false;
	}
	
	if (!userinput.nick.value) {
		alert("닉네임을 입력하세요.");
		userinput.nick.focus();
		return false;
	}else if (userinput.nick.value.length > 40) {
		alert("닉네임은 40자 이내로 입력해주세요..");
		userinput.nick.focus();
		return false; 
	}
	if (!userinput.birthdate.value) {
		alert("생년월일을 입력하세요.");
		userinput.birthdate.focus();
		return false;
	}else if (!/^\d{8}$/.test(userinput.birthdate.value)) {
		alert("생년월일은 8자리 숫자로 입력해주세요.");
		userinput.birthdate.focus();
		return false;
	}
	
	if (!userinput.email.value) {
		alert("이메일을 입력하세요.");
		userinput.email.focus();
		return false;
	}else if (userinput.email.value.length > 30) {
		alert("이메일을 30자 이내로 입력해주세요.");
		userinput.email.focus();
		return false;
	}else if (!userinput.email.value.includes("@") || !userinput.email.value.split("@")[0] || !userinput.email.value.split("@")[1]) {
		alert("올바른 이메일 주소를 입력해주세요.");
		userinput.email.focus();
		return false;
	}
	
	if (userinput.tel.value.length >= 15) {
		alert("핸드폰번호를 다시 입력하세요.");
		userinput.tel.focus();
		return false;
	}
	
}
