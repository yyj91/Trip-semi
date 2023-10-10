<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link href="css/menu.css" rel="stylesheet" />
<link href="https://fonts.googleapis.com/css2?family=Bagel+Fat+One&family=Noto+Sans+KR:wght@300&family=Orbit&display=swap" rel="stylesheet">

<nav>

<ul>
	<li class="lli" onclick="link('')">내가 사랑한 여름</li>
	<li class="rli" id="openLoginPopup">로그인</li>
	<li class="rli" id="logout" style="display:none;" onclick="logout()">로그아웃</li>
	<li class="rli" id="mypage" style="display:none;" onclick="link('mypage')">마이페이지</li>
	<li class="rli" id="gmpage" style="display:none;" onclick="link('admin/admin')">관리자페이지</li>
</ul>

</nav>

<div class="overlay" id="overlay" onclick="closeLoginPopup()"></div>
<div class="loginPopup" id="loginPopup">
	<div id="loginBox">
		<input type="text" name="id" placeholder="아이디" maxlength="15" required="required">
		<input type="password" name="pw" placeholder="비밀번호" maxlength="15" required="required">
		<button id="loginBtn" onclick="login()">로그인</button>
		<div id="textBox">
			<a class="findtext" target="_blank" href="./findid">아이디 찾기</a>
			<span class="divider"></span>
			<a class="findtext" target="_blank" href="./findpw">비밀번호 찾기</a>
			<span class="divider"></span>
			<a class="signintext" target="_blank" href="./signin">회원가입</a>
		</div>
	</div>
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">

	document.getElementById("openLoginPopup").addEventListener("click", function() {
		document.getElementById("overlay").style.display = "block";
		document.getElementById("loginPopup").style.display = "block";
	});


	function closeLoginPopup() {
		document.getElementById("overlay").style.display = "none";
		document.getElementById("loginPopup").style.display = "none";
	}
	
	function login(){
		
		let id = document.querySelector('#loginPopup input[name="id"]').value;
	    let pw = document.querySelector('#loginPopup input[name="pw"]').value;
	    
		$.ajax({
			url : "./login",
			type : "post",
			data : {"id" : id, "pw" : pw},
			dataType : "json",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(data){
				if(data.count == 1){
					closeLoginPopup()
					document.getElementById("openLoginPopup").style.display = "none";
	                document.getElementById("logout").style.display = "block";
	                document.getElementById("mypage").style.display = "block";
	                if(data.grade >= 4){
	                	document.getElementById("admin/admin").style.display = "block";
	                }
					localStorage.setItem("loggedIn", "true");
					localStorage.setItem("userGrade", data.grade);
				}
			},
			error : function(error){
				alert("ERROR: " + JSON.stringify(error));
			}
		});
	}
	
	function logout(){
		$.ajax({
			url : "./logout",
			type : "get",
			dataType : "json",
			success : function(data){
				document.getElementById("openLoginPopup").style.display = "block";
				document.getElementById("logout").style.display = "none";
				document.getElementById("mypage" ).style.display = "none";
				document.getElementById("admin/admin").style.display = "none";
				localStorage.removeItem("loggedIn");
				localStorage.removeItem("userGrade");
			},
			error : function(error){
				alert("ERROR: " + JSON.stringify(error));
			}
		});
	}

	function link(url) {
		location.href = "./" + url;
	}
	
	window.onload = function() {
		var loggedIn = localStorage.getItem("loggedIn");
		var userGrade = localStorage.getItem("userGrade");

		if (loggedIn == "true") {
			document.getElementById("openLoginPopup").style.display = "none";
			document.getElementById("logout").style.display = "block";
			document.getElementById("mypage").style.display = "block";
			if (userGrade >= 4) {
				document.getElementById("admin/admin").style.display = "block";
			}
		} else{
			document.getElementById("openLoginPopup").style.display = "block";
			document.getElementById("logout").style.display = "none";
			document.getElementById("mypage").style.display = "none";
			document.getElementById("admin/admin").style.display = "none";
		}
	};
	
</script>