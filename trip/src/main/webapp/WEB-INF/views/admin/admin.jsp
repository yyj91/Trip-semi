<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>항공 정보</title>
<script src="../js/jquery-3.7.0.min.js"></script>
<style>
body {
    background-color: #fff;
}

form {
	margin-top: 45px;
    margin-bottom: 20px;
}

label {
    display: block;
    font-weight: bold;
}

input[type="text"], select {
    width: 100%;
    padding: 5px;
    margin-bottom: 10px;
    border: 1px solid #ccc; /* 입력 필드 테두리 스타일 */
    border-radius: 4px;
}

input[type="submit"] {
    background-color: #ff6a24;
    color: white;
    border: none;
    padding: 10px 20px;
    cursor: pointer;
    border-radius: 4px;
}

.inputlist {
    display: flex;
    align-items: center;
    margin-bottom: 20px;
}

.inputlist select, .inputlist input[type="text"] {
    margin-right: 10px;
}

table {
    border-collapse: collapse;
    width: 100%;
    font-size: 14px;
}

th, td {
    border: 1px solid #ff6a24;
    padding: 8px;
    text-align: left;
}

button.send {
    background-color: #ff6a24;
    color: white;
    border: none;
    padding: 10px 20px;
    cursor: pointer;
    border-radius:4px;
    margin-bottom:10px;
}

tr.aList .seatClass, tr.aList .numberOfSeats, tr.aList .seatPrice {
    border: 1px solid ;
    border-radius: 4px;
    padding: 3px 5px;
    width: auto;
}

th input[type="checkbox"], td input[type="checkbox"] {
        display: block;
        margin: 0 auto;
}
</style>
<script>
	$(function(){
		$(".send").click(function(){
			let numberOfRows = $(".aList").length;
			
			for(let i = 0; i < numberOfRows; i++){
				let currentRow = $(".aList:eq("+ i +")");
				 // 각 변수에서 값을 가져옵니다.
		        var selectElement = currentRow.find(".seatClass").val();
		        var numberOfSeats = currentRow.find(".numberOfSeats").val();
		        var seatPrice = currentRow.find(".seatPrice").val();
		        
		        // 각 변수에 값이 있는지 확인합니다.
		        if (selectElement && numberOfSeats && seatPrice) {
		        	let flightData = {
							'airlineNm' : currentRow.find(".airline").text(),
							'vihicleId' : currentRow.find(".vihicleId").text(),
							'depAirportNm' : currentRow.find(".depAirportNm")
									.text(),
							'arrAirportNm' : currentRow.find(".arrAirportNm")
									.text(),
							'depPlandTime' : currentRow.find(".depPlandTime")
									.text(),
							'arrPlandTime' : currentRow.find(".arrPlandTime")
									.text(),
							'seatClass' : selectElement,
							'numberOfSeats' : numberOfSeats,
							'seatPrice' : seatPrice
						};
		        	
							
								$.ajax({
									type : "post",
									url : "flightdata0",
									data : JSON.stringify(flightData),
									contentType : "application/json",
									success : function(data) {
					        	$.ajax({
									type : "post",
									url : "flightdata1",
									data : JSON.stringify(flightData),
									contentType : "application/json",
									success : function(data) {
										
									},
									error : function(xhr, status, error) {
										
									}
								});
										
									},
									error : function(xhr, status, error) {
										
									}
								});
					 }
			}
		});
	});
</script>
</head>
<body>
	<div class="menu">
	<%@ include file="adminmenu.jsp"%>
	</div>
	<div class="container">
		<div class="main">
			<div class="article">
				<form action="admin" method="post">
					<label for="airline">Airline:</label> <select id="airline"
						name="airlineId">
						<c:forEach var="airline" items="${airline}">
							<option value="${airline.airlineId}">${airline.airlineNm}</option>
						</c:forEach>
					</select> <br> <label for="departureAirport">Departure Airport:</label>
					<select id="departureAirport" name="depAirportId">
						<c:forEach var="airport" items="${departureAirport}">
							<option value="${airport.airportId}">${airport.airportNm}</option>
						</c:forEach>
					</select> <br> <label for="arrivalAirport">Arrival Airport:</label> <select
						id="arrivalAirport" name="arrAirportId">
						<c:forEach var="airport" items="${arrivalAirport}">
							<option value="${airport.airportId}">${airport.airportNm}</option>
						</c:forEach>
					</select> <br> <label for="departureDate">Departure Date:</label> <input
						type="text" id="departureDate" name="depPlandTime"> <br>
					<input type="submit" value="받아오기">
				</form>
			</div>
		</div>
	</div>
	<div class="inputlist">
	<select class="inputClass" name="allSeatClass">
		<option value="이코노미">이코노미</option>
		<option value="비즈니스">비즈니스</option>
		<option value="퍼스트">퍼스트</option>
	</select>
	<input type="text" class = "inputSeat" placeholder="좌석수를 입력해주요"/>
	<input type="text" class = "inputPrice" placeholder="좌석당 가격을 입력해주세요"/>
	</div>
	<button class="send">보내기</button>
	<table>
		<tr>
			<th><input type="checkbox" class="selectAllFlight" name="selectAllFlight"></th>
			<th>항공사</th>
			<th>항공편이름</th>
			<th>출발공항</th>
			<th>도착공항</th>
			<th>출발시간</th>
			<th>도착시간</th>
			<th>좌석등급</th>
			<th>좌석수</th>
			<th>좌석당가격</th>
		</tr>
		<c:choose>
			<c:when test="${empty list}">
				<tr>
					<td colspan="10">운항 스케줄이 없습니다.</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${list}" var="flight">
					<tr class="aList">
						<td><input type="checkbox" class="selectFlight" name="selectFlight"></td>
						<td class="airline" name="airline">${flight.airlineNm}</td>
						<td class="vihicleId" name="vihicleId">${flight.vihicleId }</td>
						<td class="depAirportNm" name="depAirportNm">${flight.depAirportNm}</td>
						<td class="arrAirportNm" name="arrAirportNm">${flight.arrAirportNm}</td>
						<td class="depPlandTime" name="depPlandTime">${flight.depPlandTime}</td>
						<td class="arrPlandTime" name="arrPlandTime">${flight.arrPlandTime}</td>
						<td><select class="seatClass" name="seatClass">
								<option value="이코노미">이코노미</option>
								<option value="비즈니스">비즈니스</option>
								<option value="퍼스트">퍼스트</option>
						</select></td>
						<!-- 좌석등급 입력란 -->
						<td><input type="text" class="numberOfSeats"
							name="numberOfSeats"></td>
						<!-- 좌석수 입력란 -->
						<td><input type="text" class="seatPrice" name="seatPrice"></td>
						<!-- 좌석당가격 입력란 -->
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</table>
	<script>
		$(function(){
			$(".selectAllFlight").change(function(){
				let isChecked = this.checked;
				
				let selectFlightCheckboxes = document.querySelectorAll(".selectFlight");
				for (let i = 0; i < selectFlightCheckboxes.length; i++) {
		            selectFlightCheckboxes[i].checked = isChecked;
		        }
			});
		});
		$(function(){
		    $(".selectAllFlight").change(function(){
		        let isChecked = this.checked;
		        
		                let inputClass = $(".inputlist").find(".inputClass").val();
		                let inputSeat = $(".inputlist").find(".inputSeat").val();
		                let inputPrice = $(".inputlist").find(".inputPrice").val();
		        // 모든 행(aList)을 반복하며 값을 설정합니다.
		        $(".aList").each(function(){
		            if (isChecked) {
		                // 전체 선택 체크박스가 선택된 경우, 입력 값을 설정합니다.
		                
		                $(this).find(".seatClass").val(inputClass);
		                $(this).find(".numberOfSeats").val(inputSeat);
		                $(this).find(".seatPrice").val(inputPrice);
		            } else {
		                // 전체 선택 체크박스가 선택되지 않은 경우, 값을 비웁니다.
		                $(this).find(".seatClass").val("");
		                $(this).find(".numberOfSeats").val("");
		                $(this).find(".seatPrice").val("");
		            }
		        });
		    });
		});
		$(function(){
			$(".selectFlight").change(function(){
					let inputClass = $(".inputlist").find(".inputClass").val();
	                let inputSeat = $(".inputlist").find(".inputSeat").val();
	                let inputPrice = $(".inputlist").find(".inputPrice").val();
	                
				if(this.checked){
					let row = $(this).closest("tr");
					row.find(".seatClass").val(inputClass);
	                row.find(".numberOfSeats").val(inputSeat);
	                row.find(".seatPrice").val(inputPrice);
				} else {
					 $(this).find(".seatClass").val("");
		                $(this).find(".numberOfSeats").val("");
		                $(this).find(".seatPrice").val("");
				}
			});
		});
	</script>
</body>
</html>