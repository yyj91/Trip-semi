<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mypage</title>
<link rel="stylesheet" href="./css/mypage.css">
<link rel="stylesheet" href="./css/menu.css">
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&family=Orbit&display=swap"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>

<style>
#hiddenrv {
	display: none;
}
.left-box {
	margin-top: 50px;
	float: left;
	width: 50%;
}

.right-box {
	margin-top: 50px;
	float: right;
	width: 50%;
}
</style>

<!-- 회원정보/예약내역 창 띄우기  -->
<script>
	document.addEventListener('DOMContentLoaded', function() {
		const toggleButton = document.getElementById('toggleButton');
		const toggleButton2 = document.getElementById('toggleButton2');
		const hiddenrv = document.getElementById('hiddenrv');
		const hiddenmp = document.getElementById('hiddenmp');

		hiddenmp.style.display = 'block'; // 

		toggleButton.addEventListener('click', function() {
			if (hiddenrv.style.display === 'none') {
				hiddenrv.style.display = 'block';
				hiddenmp.style.display = 'none';
			} else {
				hiddenrv.style.display = 'none';
			}

		});

		toggleButton2.addEventListener('click', function() {
			if (hiddenmp.style.display === 'none') {
				hiddenmp.style.display = 'block';
				hiddenrv.style.display = 'none';
			} else {
				hiddenmp.style.display = 'none';
			}
		});

	});
</script>

<!-- 예약내역 취소 -->
<script>
function cancelReservation(fuuid) {
    
	const checkedCheckboxes = document.querySelectorAll('input[name="checkrv"]:checked');
    const rvlist = Array.from(checkedCheckboxes).map(checkbox => checkbox.value); 
    
    if (rvlist.length === 0) {
        alert("취소할 예약을 선택하세요");
        return;
    }

    // 확인 대화 상자 표시
    const confirmation = confirm("선택한 예약을 취소하시겠습니까?");
    if (!confirmation) {
        return; 
    }
    
    // 서버에 예약 취소 요청 전송
    const requestData = { rvlist: rvlist, fuuid: fuuid };
   
    $.ajax({
        type: "POST",
        url: "/mypage/cancel",
        contentType: "application/json", // JSON 형식으로 전송
        data: JSON.stringify(requestData),
        success: function (response) {
            if (response === "예약이 취소되었습니다.") {
                checkedCheckboxes.forEach(checkbox => {
                    const row = checkbox.closest('tr');
                    if (row) {
                    	row.remove(); // 예약취소내역 삭제
                    	
                    }
                });
            } else {
                alert("예약 취소 중 오류가 발생했습니다.");
            }
        },
   
    });
}
</script>

<!-- 회원정보 수정하기 -->
<script>
function edit() {
	
	var mlastname = $("#lname").val();
	var mfirstname = $("#fname").val();
	var mpw = $("#pw").val();
	var mphone = $("#phone").val();
	var memail = $("#email").val();
	
	var requestData = {
			mlastname : mlastname,
			mfirstname : mfirstname,
			mpw : mpw,
			mphone : mphone,
			memail : memail			
	};
	
	$.ajax({
		url:"/mypage/update",
		type:"POST",
		data:requestData,
		success:function(response){
			alert("수정이 완료되었습니다.");
		},
		error : function(xhr) {
			alert("수정에 실패하였습니다.");
		}
	
	});
	
}
</script>


</head>
<body>
	<%@ include file="menu.jsp"%>

	<h1 style="font-weight:bold;  margin-top: 40px; padding-left: 30px;">마이페이지</h1>
	<div>
		<button class="info-btn" id="toggleButton2">
			회원정보<i class="xi-emoticon"></i>
		</button>
		<div id="hiddenmp">
			<div class="form">
				<form action="./mypage/update" method="post">
					<h1 class="info">회원정보</h1>
					<c:forEach items="${mypage}" var="l">
						<div class="form-input">
							<label class="m-label">성</label>
							<label class="m-label">이름</label>
							<br> <input type="text" name="mlastname"
								value="${l.mlastname}" class="ml-input"> <input
								type="text" name="mfirstname" value="${l.mfirstname}"
								class="mf-input"><br>
							<label>아이디</label>
							<br> <input type="text" name="mid" readonly="readonly"
								value="${l.mid}" class="mid-input"
								style="background-color: #dbd9d9;"><br>
							<label>비밀번호</label>
							<br> <input type="password" name="mpw" value="${l.mpw}"
								class="mpw-input"><br>
							<label>핸드폰번호</label>
							<br> <input type="text" name="mphone" value="${l.mphone}"
								class="mph-input"><br> <label>이메일</label> <br>
							<input type="text" name="memail" readonly="readonly"
								value="${l.memail}" class="mem-input"
								style="background-color: #dbd9d9;"><br>
						</div>
					</c:forEach>
					<div class="form-Btn">
						<button class="rm-btn" type="button" id="removeBtn"
							onclick="remove()">회원탈퇴</button>
						<button class="ed-btn" type="submit" value="수정하기" onclick="edit()">수정하기</button>
					</div>
				</form>
			</div>
		</div>
	<br>
		<button class="rv-btn" id="toggleButton">예약내역<i class="xi-calendar-list"></i>
		</button>
		<div id="hiddenrv">
			<h1 class="rv">예약내역</h1>
			<div class="rv-table">
				<div class="c-btn">
					<button class="cel-btn" type="button" id="celBtn"
						onclick="cancelReservation('${rl.fuuid}')">예약취소</button>
				</div>
				<br>
				<c:choose>
					<c:when test="${empty rvlist}">
						<h3 class="et_text">
							<i class="xi-emoticon-sad-o xi-2x"></i>예약하신 항공권이 없습니다.
						</h3>
					</c:when>
					<c:otherwise>

						<table style="float: right; border-collapse: collapse;">
							<thead>
								<tr>
								    <th></th>
									<th>편명</th>
									<th>항공사</th>
									<th>출발지(출발시간)</th>
									<th>도착지(도착시간)</th>
									<th>좌석등급</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${rvlist}" var="rl">
									<tr>
										<td><input type="checkbox" name="checkrv"
											value="${rl.fuuid}" /></td>
										<td>${rl.fname}</td>
										<td>${rl.fairline}</td>
										<td>${rl.fdeparture}(${rl.ftod})</td>
										<td>${rl.farrival}(${rl.ftoa})</td>
										<td>${rl.sgrade}</td>
										
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		</div>
	<br>

	<!-- 탈퇴하기  -->
	<script>
	document.getElementById("removeBtn").addEventListener("click", function(){
		if(window.confirm("탈퇴하시겠습니까?")) {
			
			remove();
		}	
	});
	
	function remove() {
		
		var mid = prompt("아이디를 입력하세요 : ");
		
		if(mid) {
			
			var xhr = new XMLHttpRequest();
			
			xhr.open("POST", "/mypage/remove", true);
			xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
			
			xhr.onreadystatechange = function() {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    if (xhr.status === 200) {
                        // 서버 응답이 정상적으로 처리된 경우
                        alert("회원 탈퇴가 완료되었습니다.");
                        location.href = "/login"; //
                    } else {
                        // 서버 응답이 오류인 경우
                        alert("회원 탈퇴에 실패하였습니다.");
                    }
                }
            };
			
            var data = "mid=" + encodeURIComponent(mid);
            xhr.send(data);
		}
	}
	</script>
	
	<footer>
		<br>
		<p>서울 강남구 테헤란로 7길 7(역삼동 에스코빌딩 7층) / 대표자: 김민성 / TEL: 02-000-1111</p>
		<p>Copyright ⓒ 2023. 내가 사랑한 여름. All Rights Reserved</p>
		</footer>


</body>
</html>