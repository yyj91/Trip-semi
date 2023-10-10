<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="css/findpw.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<p>회원 정보에 등록한 이메일 주소를 입력하세요</p>
	<form id="findPwForm" action="./findpwFinal" method="post">
	<div id="findPwDiv">
		<input id="userId" type="hidden" name="userId" value="${id }">
		<input id="email" type="text" name="email" placeholder="이메일 주소" maxlength="30" required="required">
		<button type="button" class="sEmailBtn" onclick="sendVerificationCode()">인증 번호 받기</button>
		
		<div id="vCodeDiv">
			<input id="vcode" type="text" name="vcode" placeholder="인증 번호" maxlength="20" required="required">
			<button type="button" class="vEmailBtn" onclick="validateEmailCode()">확인</button>
		</div>
		
		<div id="findpwResultDiv"><span style="visibility: hidden;">:</span></div>
		<button type="submit" id="nextButton" disabled="disabled">다음</button>
	</div>
	</form>
</body>

<script type="text/javascript">

function sendVerificationCode(){
	
	let id = document.getElementById("userId").value;
	let email = document.getElementById("email").value;
	let resultDiv = document.getElementById("findpwResultDiv");
	
	$.ajax({
		url : "/findPwCrossCheck",
		type : "post",
		data : {id : id, email : email},
		success: function(data){
			
			if(data){
				$.ajax({
					url : "/sendVerificationCode",
					type : "post",
					data : {email : email},
					success: function(data){
						// true false
						
						resultDiv.style.visibility = "visible";
	                    resultDiv.style.color = "black";
	                    resultDiv.textContent = "인증 코드를 확인하세요^^";
					},
					error: function(error){
						alert("ERROR: " + JSON.stringify(error));
					}
				});
			}else{
				resultDiv.style.visibility = "visible";
                resultDiv.style.color = "red";
                resultDiv.textContent = "회원 정보에 등록된 이메일과 일치하지 않습니다.";
			}
		},
		error:function(error){
			alert("ERROR: " + JSON.stringify(error));
		}
	});
}
	
function validateEmailCode(){
		
	let code = document.getElementById("vcode").value;
	let resultDiv = document.getElementById("findpwResultDiv");
		
	$.ajax({
		url: "/checkVerificationCode",
		type: "post",
		data: {code : code},
		success: function(data){
			if(data){
				resultDiv.style.visibility = "hidden";
				document.getElementById("nextButton").disabled = false;
			}else{
				resultDiv.style.visibility = "visible";
                resultDiv.style.color = "red";
                resultDiv.textContent = "인증 코드가 일치하지 않습니다.";
			}
		},
		error: function(error){
			alert("ERROR: " + JSON.stringify(error));
		}
	});
}


</script>

</html>