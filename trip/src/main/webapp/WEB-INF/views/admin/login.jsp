<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 로그인 페이지</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&family=Orbit&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Bagel+Fat+One&family=Noto+Sans+KR:wght@300&family=Orbit&display=swap" rel="stylesheet">
<link rel="stylesheet" href="../css/admin/adminLogin.css">
</head>
<body>
<h1 class="title">내가 사랑한 여름</h1>
    <h1>관리자 로그인</h1>
    <div class="container">
        <!-- 로그인 폼 -->
        <form action="login" method="post" class="login-box">
            <label for="username">ID:</label>
            <input type="text" id="username" name="username" required> <br>

            <label for="password">PW:</label>
            <input type="password" id="password" name="password" required> <br>

            <input type="submit" value="로그인">
        </form>
    </div>
</body>
</html>
