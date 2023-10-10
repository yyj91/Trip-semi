<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form id="changepwForm" action="./changepw" method="post">
	<input id="userId" type="hidden" name="userId" value="${id }">
	<input id="email" type="hidden" name="email" value="${email }">
	<div id="changepwDiv">
		<input id="pw" type="password" name="pw" placeholder="비밀번호" maxlength="15" required="required">
		<div class="valDiv" id="pwv"><span style="visibility: hidden;">:</span></div>
			
		<input id="pwcheck" type="password" name="pwcheck" placeholder="비밀번호 확인" maxlength="15" required="required">
		<div class="valDiv" id="pwcheckv"><span style="visibility: hidden;">:</span></div>
		
		<button type="submit" disabled="disabled">확인</button>
	</div>
	</form>
	
<script type="text/javascript">

let pwInputChecked = false;
let pwChecked = false;

document.getElementById("pw").addEventListener("keyup", validateOnKeyUp);
document.getElementById("pwcheck").addEventListener("keyup", validateOnKeyUp);

function validateOnKeyUp(event) {
	let inputField = event.target;
	let inputValue = inputField.value;
	let fieldName = inputField.name;
	let valDivId = fieldName + "v";

	switch (fieldName) {
        case "pw":
			if (!validatePassword(inputValue)) {
				pwInputChecked = false;
				let valMessage = "비밀번호는 영문 대문자, 숫자, 특수문자를 모두 포함해야 합니다.";
				displayValMessage(valDivId, valMessage, false);
			}else{
				if(inputValue.length < 8){
					pwInputChecked = false;
					let valMessage = "비밀번호는 8글자 이상이어야 합니다."
					displayValMessage(valDivId, valMessage, false);
				}else{
					pwInputChecked = true;
					let valMessage = "사용 가능한 비밀번호입니다."
					displayValMessage(valDivId, valMessage, true);
				}
			}
			break;
        case "pwcheck":
        	let password = document.getElementById("pw").value;
    		if (inputValue != password) {
    			pwChecked = false;
    			let valMessage = "비밀번호가 일치하지 않습니다.";
    			displayValMessage(valDivId, valMessage, false);
    		} else {
    			pwChecked = true;
    			clearValMessage(valDivId);
    		}
        	break;
    }
	controllBtn();
}

function validatePassword(inputValue) {
	let uppercaseRegex = /[A-Z]/g;
	let numberRegex = /[0-9]/g;
	let specialCharRegex = /[!@#$%^&*()_+{}\[\]:;<>,.?~\\/-]/g;

	let hasUppercase = uppercaseRegex.test(inputValue);
	let hasNumber = numberRegex.test(inputValue);
	let hasSpecialChar = specialCharRegex.test(inputValue);

	return hasUppercase && hasNumber && hasSpecialChar;
}

document.getElementById("pw").addEventListener("focusout", validateOnFocusOut);
document.getElementById("pwcheck").addEventListener("focusout", validateOnFocusOut);

function validateOnFocusOut(event) {
	
	console.log("Focus out event occurred");
	
	let inputField = event.target;
	let inputValue = inputField.value;
	let fieldName = inputField.name;
	let valDivId = fieldName + "v";
	
	console.log("FieldName : " + fieldName);
	
	if(fieldName == "pw"){
		let password = document.getElementById("pwcheck").value;
		if(password.length > 0){
			if (inputValue != password) {
				pwChecked = false;
				let valMessage = "비밀번호가 일치하지 않습니다.";
				displayValMessage("pwcheckv", valMessage, false);
			} else {
				pwChecked = true;
				clearValMessage("pwcheckv");
			}
		}
	}
	if(fieldName == "pwcheck"){
		let password = document.getElementById("pw").value;
		if (inputValue != password) {
			pwChecked = false;
			let valMessage = "비밀번호가 일치하지 않습니다.";
			displayValMessage(valDivId, valMessage, false);
		} else {
			pwChecked = true;
			clearValMessage(valDivId);
		}
	}
	controllBtn();
}

function displayValMessage(valDivId, valmessage, isSuccess) {
	let valContainer = document.getElementById(valDivId);
	valContainer.textContent = valmessage;
    
	if(valContainer){
		if (isSuccess) {
			valContainer.style.color = 'green';
		}else{
			valContainer.style.color = 'red';
		}
	}
}

function clearValMessage(valDivId) {
    let valContainer = document.getElementById(valDivId);
    valContainer.textContent = "　";
}

function controllBtn(){
	if(pwChecked && pwInputChecked){
		document.querySelector('button[type="submit"]').removeAttribute("disabled");
	}else{
		document.querySelector('button[type="submit"]').setAttribute("disabled", "disabled");
	}
}

</script>
	
</body>
</html>