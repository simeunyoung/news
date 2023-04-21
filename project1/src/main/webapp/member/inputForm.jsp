<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link href="/project1/resource/css/style.css" rel="stylesheet"/>
<script>
	function start(){
		document.userinput.id.focus();
	}
	function inputCheck1(){
		userinput = eval("document.userinput");
		if(!userinput.id.value){
			alert("아이디를 입력하세요.");
			userinput.id.focus();
			return false;
		}
		if(!userinput.pw.value){
			alert("비밀번호를 입력하세요.");
			userinput.pw.focus();
			return false;
		}
		if(!userinput.pwCheck.value){
			alert("비밀번호 확인을 입력하세요.");
			userinput.pwCheck.focus();
			return false;
		}
		if(!userinput.name.value){
			alert("이름을 입력하세요.");
			userinput.name.focus();
			return false;
		}
		if(!userinput.nick.value){
			alert("닉네임을 입력하세요.");
			userinput.nick.focus();
			return false;
		}
		if(!userinput.birthdate.value){
			alert("생년월일을 입력하세요.");
			userinput.birthdate.focus();
			return false;
		}
		if(!userinput.email.value){
			alert("이메일을 입력하세요.");
			userinput.email.focus();
			return false;
		}
		if(!userinput.tel.value){
			alert("핸드폰번호를 입력하세요.");
			userinput.tel.focus();
			return false;
		}
	}
	
	// 아이디 중복 여부 판단
	function openConfirmId(userinput){
		// 아이디 입력했는지 검사
		if(userinput.id.value == ""){
			alert("아이디를 입력하세요.")
			return;
		}
		
		// url과 사용자 입력 id를 조합
		url = "confirmId.jsp?id="+userinput.id.value;
		
		// 새로운 윈도우를 열기
		open(url, "confirm" , "toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizeble=no,width=300,height=200");
	}
	
</script>
</head>

<body onload="start()">
	<form action="inputPro.jsp" method="post" name="userinput" onsubmit="return inputCheck();">
		<h2>회원가입</h2>
		<div>
			<table>
				<tr>
					<td>아이디</td>
					<td>
						<input type="text" name="id">
						<input type="button" name="confirmId" value="중복확인" onclick="openConfirmId(this.form)">
					</td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="pw" /></td>
				</tr>
				<tr>
					<td>비밀번호 확인</td>
					<td><input type="password" name="pwCheck" /></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="text" name="name" /></td>
				</tr>
				<tr>
					<td>닉네임</td>
					<td><input type="text" name="nick" /></td>
				</tr>
				<tr>
					<td>생년월일</td>
					<td><input type="text" name="birthdate" /></td>
				</tr>
				<tr>
					<td>이메일</td>
					<td><input type="text" name="email" /></td>
				</tr>
				<tr>
					<td>핸드폰번호</td>
					<td><input type="text" name="tel" /></td>
				</tr>
			</table>
		</div>
		<div>
			<input type="submit" value="회원가입" />
			<input type="button" value="취소" onclick="location=''"/>
		</div>
	</form>
</body>
</html>