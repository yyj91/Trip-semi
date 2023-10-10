<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&family=Orbit&display=swap"
	rel="stylesheet">
<link href="css/main.css" rel="stylesheet" />

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
	integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
	integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
	integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
	crossorigin="anonymous"></script>

<style>
.left-box {
	margin-top: 50px;
	float: left;
	width: 55%;
}

.right-box {
	margin-top: 50px;
	float: right;
	width: 45%;
}
</style>


</head>
<body>

	<%@ include file="menu.jsp"%>
	<br>
	<br>
	<div style="text-align: center;">
		<div class="left-box">
			<form action="./reservation" method="get">
				<h3 style="font-weight: bold;">
					<i class="xi-airplane"></i>항공권 검색
				</h3>
				<div id="radioDiv">
					<input type="radio" name="choice" id="oneWay" value="A"> <label
						for="oneWay">편도</label> <input type="radio" name="choice"
						id="roundTrip" value="B" checked="checked"> <label
						for="roundTrip">왕복</label>
				</div>

				<div id="selectDepartureDiv"
					style="display: inline-block; margin-right: 20px;">
					<label for="selectDeparture">출발</label> <select
						id="selectDeparture" name="departure">
						<option value="광주">광주</option>
						<option value="군산">군산</option>
						<option value="김포">김포</option>
						<option value="김해">김해</option>
						<option value="대구">대구</option>
						<option value="무안">무안</option>
						<option value="사천">사천</option>
						<option value="양양">양양</option>
						<option value="여수">여수</option>
						<option value="울산">울산</option>
						<option value="원주">원주</option>
						<option value="인천">인천</option>
						<option value="제주">제주</option>
						<option value="청주">청주</option>
						<option value="포항">포항</option>
					</select>
				</div>

				<div id="selectArrivalDiv"
					style="display: inline-block; margin-right: 20px;">
					<label for="selectArrival">도착</label> <select id="selectArrival"
						name="arrival">
						<option value="광주">광주</option>
						<option value="군산">군산</option>
						<option value="김포">김포</option>
						<option value="김해">김해</option>
						<option value="대구">대구</option>
						<option value="무안">무안</option>
						<option value="사천">사천</option>
						<option value="양양">양양</option>
						<option value="여수">여수</option>
						<option value="울산">울산</option>
						<option value="원주">원주</option>
						<option value="인천">인천</option>
						<option value="제주">제주</option>
						<option value="청주">청주</option>
						<option value="포항">포항</option>
					</select>
				</div>

				<div id="selectTODDiv"
					style="display: inline-block; margin-right: 20px;">
					<input id="selectTOD" name="tod">
				</div>
				<div id="selectTOADiv"
					style="display: inline-block; margin-right: 20px;">
					<input id="selectTOA" name="toa"><input
						style="visibility: hidden; margin-right: -300px;" />
				</div>

				<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
				<script>
					$(function() {
						$('#selectTOD').datepicker(
								{
									dateFormat : 'yy-mm-dd',
									showOtherMonths : true,
									showMonthAfterYear : true,
									changeYear : true,
									changeMonth : true,
									buttonText : "선택",
									yearSuffix : "년",
									monthNamesShort : [ '1', '2', '3', '4',
											'5', '6', '7', '8', '9', '10',
											'11', '12' ],
									dayNamesMin : [ '일', '월', '화', '수', '목',
											'금', '토' ],
									minDate : new Date(),
									maxDate : "+6M",
									onSelect : function(dateText, inst) {
										$('#selectTOA').datepicker("option",
												"minDate", dateText);
									}
								});
						$('#selectTOA').datepicker(
								{
									dateFormat : 'yy-mm-dd',
									showOtherMonths : true,
									showMonthAfterYear : true,
									changeYear : true,
									changeMonth : true,
									buttonText : "선택",
									yearSuffix : "년",
									monthNamesShort : [ '1', '2', '3', '4',
											'5', '6', '7', '8', '9', '10',
											'11', '12' ],
									dayNamesMin : [ '일', '월', '화', '수', '목',
											'금', '토' ],
									minDate : new Date(),
									maxDate : "+6M"
								});
					});
				</script>
				<br>
				<br>
				<br>
				<br>
				<div id="headcountDiv">
					<div>
						<label for="adultCount">성인</label> <input type="number"
							id="adultCount" name="adultCount" value="0">
						<button id="decrementAdult">-</button>
						<button id="incrementAdult">+</button>
					</div>
					<div>
						<label for="childCount">유아</label> <input type="number"
							id="childCount" name="childCount" value="0">
						<button id="decrementChild">-</button>
						<button id="incrementChild">+</button>
					</div>
					<div>
						<label for="infantCount">소아</label> <input type="number"
							id="infantCount" name="infantCount" value="0">
						<button id="decrementInfant">-</button>
						<button id="incrementInfant">+</button>
					</div>
				</div>

				<script>
					let adultCount = 0;
					let childCount = 0;
					let infantCount = 0;

					const adultCountElement = document
							.getElementById('adultCount');
					const childCountElement = document
							.getElementById('childCount');
					const infantCountElement = document
							.getElementById('infantCount');

					document.getElementById('decrementAdult').addEventListener(
							'click', function(e) {
								e.preventDefault();
								if (adultCount > 0) {
									adultCount--;
									adultCountElement.value = adultCount;
								}
							});
					document
							.getElementById('incrementAdult')
							.addEventListener(
									'click',
									function(e) {
										e.preventDefault();
										if (adultCount + childCount
												+ infantCount + 1 > 4) {

										} else {
											adultCount++;
											adultCountElement.value = adultCount;
										}
									});
					document.getElementById('decrementChild').addEventListener(
							'click', function(e) {
								e.preventDefault();
								if (childCount > 0) {
									childCount--;
									childCountElement.value = childCount;
								}
							});
					document
							.getElementById('incrementChild')
							.addEventListener(
									'click',
									function(e) {
										e.preventDefault();
										if (adultCount + childCount
												+ infantCount + 1 > 4) {

										} else {
											childCount++;
											childCountElement.value = childCount;
										}
									});
					document.getElementById('decrementInfant')
							.addEventListener('click', function(e) {
								e.preventDefault();
								if (infantCount > 0) {
									infantCount--;
									infantCountElement.value = infantCount;
								}
							});
					document
							.getElementById('incrementInfant')
							.addEventListener(
									'click',
									function(e) {
										e.preventDefault();
										if (adultCount + childCount
												+ infantCount + 1 > 4) {

										} else {
											infantCount++;
											infantCountElement.value = infantCount;
										}
									});
				</script>

				<div id="formBtnDiv">
					<button type="submit">검색</button>
				</div>

			</form>
		</div>

		<div class='right-box'>
			<div class="container">
				<h2>
					<i class="xi-maker"></i>국내 관광 여행지
				</h2>
			</div>
			<div id="demo" class="carousel slide" data-ride="carousel">
				<div class="carousel-inner">
					<!-- 슬라이드 쇼 -->
					<div class="carousel-item active">
						<!--가로-->
						<img class="d-block slider-image mx-auto"
							src="https://www.gimpo.go.kr/DATA/tour/8/thumb/p_f3f9f04b-fa08-4539-b5a0-874cb4b6f099.jpg"
							alt="First slide">
						<div class="carousel-caption d-none d-md-block">
							<h5>김포</h5>
							<a href="https://www.gimpo.go.kr/culture/index.do"
								style="text-decoration: none">사이트 바로가기</a>
						</div>
					</div>
					<div class="carousel-item">
						<img class="d-block slider-image mx-auto"
							src="https://itour.incheon.go.kr/common/viewImg.do?imgId=DBI22012516500344688"
							alt="Second slide">
						<div class="carousel-caption d-none d-md-block">
							<h5>인천</h5>
							<a href="https://itour.incheon.go.kr/main/main.do"
								style="text-decoration: none">사이트 바로가기</a>
						</div>
					</div>
					<div class="carousel-item">
						<img class="d-block slider-image mx-auto"
							src="https://api.cdn.visitjeju.net/photomng/imgpath/202110/20/cecaa16d-a3a7-4060-8634-e2ef138784d2.jpg"
							alt="Third slide">
						<div class="carousel-caption d-none d-md-block">
							<h5>제주</h5>
							<a href="https://visitjeju.net/kr/" style="text-decoration: none">사이트
								바로가기</a>
						</div>
					</div>

					<div class="carousel-item">
						<img class="d-block slider-image mx-auto"
							src="https://www.yeosu.go.kr/tour/contents/9/geum_1.jpg"
							alt="Third slide">
						<div class="carousel-caption d-none d-md-block">
							<h5>여수</h5>
							<a href="https://www.yeosu.go.kr/tour"
								style="text-decoration: none">사이트 바로가기</a>
						</div>
					</div>

					<div class="carousel-item">
						<img class="d-block slider-image mx-auto"
							src="https://ak-d.tripcdn.com/images/350q16000001074utE976_C_900_600_Q70.webp?proc=source%2ftrip&proc=source%2ftrip"
							alt="Four slide">
						<div class="carousel-caption d-none d-md-block">
							<h5>대구</h5>
							<a href="https://tour.daegu.go.kr/" style="text-decoration: none">사이트
								바로가기</a>
						</div>
					</div>

					<!-- / 슬라이드 쇼 끝 -->

					<!-- 왼쪽 오른쪽 화살표 버튼 -->
					<a class="carousel-control-prev" href="#demo" data-slide="prev">
						<span class="carousel-control-prev-icon" aria-hidden="true"></span>
						<!-- <span>Previous</span> -->
					</a> <a class="carousel-control-next" href="#demo" data-slide="next">
						<span class="carousel-control-next-icon" aria-hidden="true"></span>
						<!-- <span>Next</span> -->
					</a>
					<!-- / 화살표 버튼 끝 -->

					<!-- 인디케이터 -->
					<ul class="carousel-indicators">
						<li data-target="#demo" data-slide-to="0" class="active"></li>
						<!--0번부터시작-->
						<li data-target="#demo" data-slide-to="1"></li>
						<li data-target="#demo" data-slide-to="2"></li>
						<li data-target="#demo" data-slide-to="3"></li>
						<li data-target="#demo" data-slide-to="4"></li>
					</ul>
					<!-- 인디케이터 끝 -->
				</div>
			</div>
		</div>
	</div>

	<footer>
		<br>
		<p>서울 강남구 테헤란로 7길 7(역삼동 에스코빌딩 7층) / 대표자: 김민성 / TEL: 02-000-1111</p>
		<p>Copyright ⓒ 2023. 내가 사랑한 여름. All Rights Reserved</p>
	</footer>
	<script type="text/javascript">
		$(document)
				.ready(
						function() {

							$('#oneWay').click(function() {
								$('#selectTOA').hide();
							});

							$('#roundTrip').click(function() {
								$('#selectTOA').show();
							});

							$('#selectDeparture')
									.change(
											function() {
												let selectedDeparture = $(this)
														.val();

												$
														.ajax({
															url : "./getArrivalList",
															type : "post",
															data : {
																departure : selectedDeparture
															},
															dataType : "json",
															success : function(
																	data) {

																$(
																		'#selectArrival')
																		.empty();

																for (let i = 0; i < data.arrivalList.length; i++) {
																	$(
																			'#selectArrival')
																			.append(
																					$(
																							'<option>',
																							{
																								value : data.arrivalList[i],
																								text : data.arrivalList[i]
																							}));
																}

															},
															error : function(
																	error) {
																alert("ERROR: "
																		+ JSON
																				.stringify(error));
															}
														})
											});

							$('form')
									.submit(
											function(e) {

												if ($('#selectDeparture').val() === '') {
													alert('출발지를 선택하세요.');
													$('#selectDeparture')
															.focus();
													return false;
												}

												if ($('#selectArrival').val() === '') {
													alert('도착지를 선택하세요.');
													$('#selectArrival').focus();
													return false;
												}

												if ($('#selectTOD').val() === '') {
													alert('출발일을 선택하세요.');
													$('#selectTOD').focus();
													return false;
												}

												if ($('#selectTOA').val() === ''
														&& $(
																'input[name="choice"]:checked')
																.val() !== "A") {
													alert('도착일을 선택하세요.');
													$('#selectTOA').focus();
													return false;
												}

												const adultCount = parseInt($(
														'#adultCount').val());
												const childCount = parseInt($(
														'#childCount').val());
												const infantCount = parseInt($(
														'#infantCount').val());
												const totalPassengers = adultCount
														+ childCount
														+ infantCount;

												if (totalPassengers <= 0) {
													alert('적어도 한 명 이상의 승객을 선택하세요.');
													return false;
												}
											});
						});
	</script>


</body>
</html>