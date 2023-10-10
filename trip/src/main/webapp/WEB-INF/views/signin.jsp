<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="css/signin.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<div id="signinBox">
		<form action="./signin" method="post">
			<h1>회원가입</h1>
			<input id="id" type="text" name="id" placeholder="아이디" maxlength="15" required="required">
			<div class="valDiv" id="idv"><span style="visibility: hidden;">:</span></div>
			
			<input id="pw" type="password" name="pw" placeholder="비밀번호" maxlength="15" required="required">
			<div class="valDiv" id="pwv"><span style="visibility: hidden;">:</span></div>
			
			<input id="pwcheck" type="password" name="pwcheck" placeholder="비밀번호 확인" maxlength="15" required="required">
			<div class="valDiv" id="pwcheckv"><span style="visibility: hidden;">:</span></div>
			
			<div id="signinName">
				<input type="text" name="lastname" placeholder="성" maxlength="20" required="required">
				<input type="text" name="firstname" placeholder="이름" maxlength="20" required="required">
			</div>
			
			<input id="phone" type="text" name="phone" placeholder="휴대전화 번호" maxlength="11" required="required">
			<div class="valDiv" id="phonev"><span style="visibility: hidden;">:</span></div>
			
			<input id="email" type="text" name="email" placeholder="이메일 주소" maxlength="30" required="required">
			<div class="valDiv" id="emailv"><span style="visibility: hidden;">:</span></div>
			
			<div id="valEmail"></div>
			<div class="valDiv" id="emailcodev"><span style="visibility: hidden;">:</span></div>
			
			<br>
			<div class="label-row lrbtn">
				<button type="button" class="signinBtn" onclick="window.close()">취소</button>
				<button type="submit" class="signinBtn" disabled="disabled">가입하기</button>
			</div>
		</form>
	</div>

<script type="text/javascript">

let idInputChecked = false;
let pwInputChecked = false;
let emailInputChecked = false;

let idChecked = false;
let pwChecked = false;
let phoneChecked = false;
let emailChecked = false;

document.getElementById("id").addEventListener("keyup", validateOnKeyUp);
document.getElementById("pw").addEventListener("keyup", validateOnKeyUp);
document.getElementById("pwcheck").addEventListener("keyup", validateOnKeyUp);
document.getElementById("phone").addEventListener("keyup", validateOnKeyUp);
document.getElementById("email").addEventListener("keyup", validateOnKeyUp);


function validateOnKeyUp(event) {
	let inputField = event.target;
	let inputValue = inputField.value;
	let fieldName = inputField.name;
	let valDivId = fieldName + "v";

	switch (fieldName) {
		case "id":
			let filteredId = inputValue.replace(/[^a-z0-9]/g, '');
			if(inputValue != filteredId){
				inputValue = inputField.value = filteredId;
				let valMessage = "아이디에는 영문 소문자와 숫자만 사용할 수 있습니다.";
				displayValMessage(valDivId, valMessage, false);
			} else{
				if(inputValue.length < 4){
					idInputChecked = false;
					let valMessage = "아이디는 4글자 이상이어야 합니다.";
					displayValMessage(valDivId, valMessage, false);
				}else{
					idInputChecked = true;
					clearValMessage(valDivId);
				}
			}
			break;
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
        case "phone":
        	let filteredPhone = inputValue.replace(/[^0-9]/g, '');
        	if(inputValue != filteredPhone){
				inputValue = inputField.value = filteredPhone;
				let valMessage = "휴대전화 번호는 숫자만 입력할 수 있습니다.";
				displayValMessage(valDivId, valMessage, false);
			}
			break;
        case "email":
			if (!validateEmail(inputValue)) {
				emailInputChecked = false;
				let valMessage = "올바른 이메일 주소 형식이 아닙니다.";
				displayValMessage(valDivId, valMessage, false);
            } else {
            	emailInputChecked = true;
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

function validateEmail(inputValue) {
	let emailRegex = /^[a-z0-9_+.-]+@([a-z0-9-]+\.)+[a-z0-9]{2,4}$/;
	
	if (emailRegex.test(inputValue)) {
		return true;
	}else{
	    return false;
	}
}



document.getElementById("id").addEventListener("focusout", validateOnFocusOut);
document.getElementById("pw").addEventListener("focusout", validateOnFocusOut);
document.getElementById("pwcheck").addEventListener("focusout", validateOnFocusOut);
document.getElementById("phone").addEventListener("focusout", validateOnFocusOut);
document.getElementById("email").addEventListener("focusout", validateOnFocusOut);

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
		controllBtn();
	}else if (fieldName == "pwcheck") {
		let password = document.getElementById("pw").value;
		if (inputValue != password) {
			pwChecked = false;
			let valMessage = "비밀번호가 일치하지 않습니다.";
			displayValMessage(valDivId, valMessage, false);
		} else {
			pwChecked = true;
			clearValMessage(valDivId);
		}
		controllBtn();
	}else{
		$.ajax({
			url: "/validate",
			method: "post",
			data: { fieldName: fieldName, value: inputValue },
			success: function (data) {
				switch(fieldName){
					case "id":
						if(idInputChecked){
							if(data > 0){
								idChecked = false;
								let valMessage = "이미 사용중인 아이디입니다.";
								displayValMessage(valDivId, valMessage, false);
							}else{
								idChecked = true;
								let valMessage = "사용 가능한 아이디입니다.";
								displayValMessage(valDivId, valMessage, true);
							}
						}
						break;
					case "phone":
						if(data > 0){
							phoneChecked = false;
							let valMessage = "이미 가입된 번호입니다.";
							displayValMessage(valDivId, valMessage, false);
						}else{
							phoneChecked = true;
							clearValMessage(valDivId);
						}
						break;
					case "email":
						if(emailInputChecked){
							if(data > 0){
								emailChecked = false;
								let valMessage = "이미 가입된 이메일입니다.";
								displayValMessage(valDivId, valMessage, false);
							}else{
								document.getElementById("email").disabled = true;
								sendVerificationCode();
								
								let html= "";
								html += '<input id="vcode" type="text" name="vcode" placeholder="인증 번호" maxlength="20" required="required">';
								html += '<div>';
								html += '<button type="button" class="sEmailBtn" onclick="sendVerificationCode()">인증 번호 재발송</button>';
								html += '<button type="button" class="vEmailBtn" onclick="validateEmailCode()">확인</button>';
								html += '</div>';
								$("#valEmail").append(html);
								
								clearValMessage(valDivId);
							}
						} else{
							emailChecked = false;
						}
						break;
				}
				controllBtn();
			},
			error: function () {
				alert("ERROR: " + JSON.stringify(error));
			}
		});
	}
}

function sendVerificationCode(){
	
	let emailAddr = document.getElementById("email").value;
	
	$.ajax({
		url: "/sendVerificationCode",
		type: "post",
		data: {email : emailAddr},
		success: function(data){
			// true false
		},
		error: function(error){
			alert("ERROR: " + JSON.stringify(error));
		}
	});
}

function validateEmailCode(){
	
	let code = document.getElementById("vcode").value;
	
	$.ajax({
		url: "/checkVerificationCode",
		type: "post",
		data: {code : code},
		success: function(data){
			if(data){
				emailChecked = true;
				
				document.getElementById("valEmail").remove();
				
				let valMessage = "사용 가능한 이메일입니다.";
				displayValMessage("emailcodev", valMessage, true);
				
				controllBtn();
			}else{
				let valMessage = "인증 번호가 일치하지 않습니다.";
				displayValMessage("emailcodev", valMessage, false);
			}
		},
		error: function(error){
			alert("ERROR: " + JSON.stringify(error));
		}
	});
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
	if(idChecked && pwChecked && phoneChecked && emailChecked
			&& idInputChecked && pwInputChecked && emailInputChecked){
		document.querySelector('button[type="submit"]').removeAttribute("disabled");
	}else{
		document.querySelector('button[type="submit"]').setAttribute("disabled", "disabled");
	}
}

</script>

</body>
</html>