<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="css/findid.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<h1>아이디 찾기</h1>
	<form id="findIdForm" action="./findUnfilteredid" method="post">
	<div id="findidDiv">
		<p>회원 정보에 등록한 이메일 주소를 입력하세요</p>
		<div id="findidBaseDiv">
			<input id="email" type="text" name="email" placeholder="이메일 주소" maxlength="30" required="required">
			<button type="button" id="findidBtn" onclick="findId(true)">확인</button>
		</div>
		<div id="findidBaseResultDiv"><span style="visibility: hidden;">:</span></div>
		
		<div id="findMoreDiv" style="visibility: hidden;">
			<a class="findtext" href="#" id="submitText">아이디 전체 보기</a>
			<span class="divider"></span>
			<a class="findtext" href="./findpw">비밀번호 찾기</a>
		</div>
	</div>
	</form>
	
<script type="text/javascript">

document.getElementById("submitText").addEventListener("click", function() {
	  document.getElementById("findIdForm").submit();
});

function findId(toggle){
	
	let email = document.getElementById("email").value;
	let resultDiv = document.getElementById("findidBaseResultDiv");
	let findMoreDiv = document.getElementById("findMoreDiv");
	
	if (email === "") {
        resultDiv.style.visibility = "visible";
        resultDiv.style.color = "red";
        resultDiv.textContent = "이메일 주소를 입력하세요.";
    }else{
    	$.ajax({
    		url : "./findid",
    		type : "post",
    		data : {email : email, toggle : toggle},
    		success : function(data){
    			if(data === ""){
    				resultDiv.style.visibility = "visible";
                    resultDiv.style.color = "red";
                    resultDiv.textContent = "가입된 아이디가 없습니다.";
                } else {
                    resultDiv.style.visibility = "visible";
                    resultDiv.style.color = "black";
                    resultDiv.textContent = data;
                    
                    findMoreDiv.style.visibility = "visible";
                }
    		},
    		error : function(error){
    			alert("ERROR: " + JSON.stringify(error));
    		}
    	});
    }
}
	
</script>

</body>
</html>