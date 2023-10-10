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
	<h1>비밀번호 찾기</h1>
	<form id="findPwForm" action="./findpw" method="post">
	<div id="findPwDiv">
		<p>비밀번호를 찾고자하는 아이디를 입력하세요</p>
		<input id="userId" type="text" name="id" placeholder="아이디" maxlength="15" required="required">
		<button type="submit">다음</button>
	</div>
	</form>
</body>
</html>