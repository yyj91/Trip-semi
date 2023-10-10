<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>결제</title>
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
    <link rel="stylesheet" href="./css/payment.css">
    <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&family=Orbit&display=swap" rel="stylesheet">
    <script type="text/javascript">
    
        var completedForms = 0; // 완료된 폼 갯수 세는거임
        $(function () { //체크 버튼 클릭해서 탑승객 정보 제대로 입력하나 확인하는 용도
            $(document).on("click", ".check", function () {
                let plastname = $(this).closest(".passengersForm").find(".plastname").val();
                let pfirstname = $(this).closest(".passengersForm").find(".pfirstname").val();
                let pbirth = $(this).closest(".passengersForm").find(".pbirth").val();
                let pnationality = $(this).closest(".passengersForm").find(".pnationality").val();

                if (plastname == "" || plastname.length < 1 ||
                    pfirstname == "" || pfirstname.length < 1 ||
                    pbirth == "" || pbirth.length != 6 ||
                    pnationality == "" || pnationality.length < 2) {
                    alert("모든 탑승객 정보 체크를 완료해주세요.");
                    
                    return false;
                } else {
                    alert("완벽하게 입력했습니다.");
                    completedForms++;
                    if (completedForms >= peopleCount) {
                        alert("결제하기 버튼을 눌러주세요.");
                        $(".pay").show(); //모든 탑승객 정보를 체크 해야 결제 창이 뜸
                    }
                    return false;
                }
            });
        });
        //회원 등급 할인
        var sno = '${depsno}';
        var ggrade = '${sessionScope.grade}';
        var fuuid = "${depfuuid}";
        var fuuid2 = '${arrfuuid}';
      	var muuid = '${sessionScope.uuid}'; // 세션에서 받아오는 muiud
      	var muuid2 = '${sessionScope.uuid}';
        var discountRate;
        if (ggrade >= 3) { //3등급 이상이면 20프로 할인되게, 2등급 10프로
            discountRate = 0.2;
        } else if (ggrade >= 2) {
            discountRate = 0.1; 
        } else {
            discountRate = 0;
        }
        //가격 계산
        var depadultsprice = "${depadultsprice}";
        /* var arradultsprice = "${arradultsprice}"; */
        var formCount = 1;        
        var peopleCount = '${adultCount}'; // 여기에 변수 넣어서 탑승객 설정한 만큼 늘어나게 할거임
        var tprice1 = 133900;//1명당 항공권 가격 //값 바꿔야함
        var nodistprice = tprice1 * peopleCount; //할인 전 항공권 가격
       
        var tfee = 1000 * peopleCount; // 발급수수료   
		var tfuel = 9900 * peopleCount; //유류 할증료
        var ttax = 4000 * peopleCount; //제세 공과금 
        var nodiscountedPrice = tprice + tfee + tfuel + ttax;  //할인 전 금액
        var tamount = parseInt(depadultsprice);//tprice + tfee + tfuel + ttax;//할인 된 최종금액 //106000
    	var tprice = tamount * (1 - discountRate);
    	var tt = 10;
    	var real = tfee + tfuel + ttax + tprice;
    	
      	var discountRate100 = discountRate * 100 // 클라이언트에게 0.2가 아닌 20% 할인임을 보여주기 위함
      	var count11 = "${choice}";//왕복이냐 아니냐 왕복이 B
      	
        $(document).ready(function () {
        	function createRows(count11) {
        	    var table1 = $(".choice"); // 테이블 선택 시 class 사용

        	    if (count11 === "B") {
        	        for (var i = 0; i < 1; i++) {
        	            table1.append(`
        	                <tr>
        	                    <td class="fname1">${arrairline}</td>
        	                    <td class="fname1">${farrival}<br>${arrdate}<br>${arrftod}</td>
        	                    <td class="fname1">${fdeparture}<br>${arrdate}<br>${arrftoa}</td>
        	                </tr>
        	            `);
        	        }
        	    }
        	}      	
        	createRows(count11); //왕복이냐 편도냐에 따라서 생성되고 사라짐
        	var formContainer = $(".formContainer");
            $(".peopleCount").text(peopleCount);
            $(".tfee").text(tfee.toLocaleString()); // 1,000 콤마가 붙게했음
            $(".tamount").text(tamount.toLocaleString());
            $(".tt").text(tt.toLocaleString());
            $(".tprice").text(tprice.toLocaleString());
            $(".tfuel").text(tfuel.toLocaleString());
            $(".ttax").text(ttax.toLocaleString());
            $(".tprice1").text(tprice1.toLocaleString());
            $(".nodistprice").text(nodistprice.toLocaleString());
            $(".nodiscountedPrice").text(nodiscountedPrice.toLocaleString());
            $(".discountRate100").text(discountRate100.toLocaleString()); 
            $(".real").text(real.toLocaleString()); 
            for (var i = 0; i < peopleCount; i++) { //사람 수에 맞춰서 폼이 동적으로 생성되게 함
            	var newForm = "<b>● 탑승객 " + (i + 1) + "</b><br><br>";
            	newForm +=  
                	` <div class="label-row"> 
                            <div class="label-name"></div>
                            <div class="label-in">
                                성&nbsp&nbsp<input type="text" name="plastname" class="plastname" placeholder="성 입력" maxlength="6">&nbsp&nbsp
                                이름&nbsp&nbsp<input type="text" name="pfirstname" class="pfirstname" placeholder="이름 입력" maxlength="6">&nbsp&nbsp
                                생년월일&nbsp&nbsp<input type="text" name="pbirth" class="pbirth" placeholder="ex) 980131" maxlength="6">&nbsp&nbsp
                				국적&nbsp&nbsp<input type="text" name="pnationality" class="pnationality" placeholder="국적 입력" maxlength="7">&nbsp&nbsp
                				성별&nbsp&nbsp<select name="pgender" class="pgender">
                            	<option value="남자">남자</option>
                            	<option value="여자">여자</option>    
                            	<input type="hidden" name="sno" value="${depsno}"/>
                       		</select>
                       		&nbsp&nbsp<button type="submit" class="check">체크</button>
                        	</div>
                        	</div><br><br>
                `;
                $(formContainer).append(newForm);
                formCount++;
            }
            document.getElementById("tprice").value = tprice;
            document.getElementById("tfee").value = tfee;
            document.getElementById("tamount").value = tamount;
            document.getElementById("tfuel").value = tfuel;
            document.getElementById("ttax").value = ttax;
            document.getElementById("peopleCount").value = peopleCount;
            document.getElementById("fuuid").value = fuuid;
            document.getElementById("muuid").value = muuid;
            document.getElementById("fuuid2").value = fuuid2;
            document.getElementById("muuid2").value = muuid2;

        });
        function submitForm() { //탑승객 정보 제출폼
            var forms = $(".passengersForm");
            forms.each(function () {
                $(this).submit(); 
            });   
        }
        var sremainder = document.querySelector(".sremainder");
       //결제창
        var IMP = window.IMP;
        IMP.init("imp");
       function requestPay() {
            IMP.request_pay({
                pg: "html5_inicis",
                pay_method: "card",
                merchant_uid: "${getruuid}", //결제할때마다 번호를 갱신해야 하므로 rno를 넣어줌
                name: "AIRSEOUL", //fairline로 변수
                amount: tt, // 가격을 변수로 받음
                buyer_email: "홍길동@naver.com", // 이메일로 결제 내역 받자 memail
                buyer_name: "홍길동",
                buyer_tel: "010-4242-4242", //mphone
                buyer_addr: "서울특별시 강남구 신사동",
                buyer_postcode: "01181"      
            }, function (rsp) {
                if (rsp.success) {
                	///성공하면 탑승객 정보, 좌석수, 총 결제 금액이 전송
                    var form = document.createElement("form"); //좌석수 빼는 폼
                    form.setAttribute("action", "/sremainder");
                    form.setAttribute("method", "post");
                    
                    var sremainderInput = document.createElement("input");
                    sremainderInput.setAttribute("type", "hidden");
                    sremainderInput.setAttribute("name", "sremainder");
                    sremainderInput.setAttribute("value", "3"); 
                    form.appendChild(sremainderInput);
                    
                    var peopleCountInput = document.createElement("input");
                    peopleCountInput.setAttribute("type", "hidden");
                    peopleCountInput.setAttribute("name", "peopleCount");
                    peopleCountInput.setAttribute("value", peopleCount); //사람 수에 맞춰서 좌석 수 빼려고 보냄
                    form.appendChild(peopleCountInput);
                    
                    document.body.appendChild(form); //좌석 빼줌
                    
					//결제내역
                    var form2 = document.createElement("form"); //결제내역 전송 폼
                    form2.setAttribute("action", "/totalamount"); 
                    form2.setAttribute("method", "post");
                    
                	//tprice
                    var tpriceInput = document.createElement("input");
                    tpriceInput.setAttribute("type", "hidden");
                    tpriceInput.setAttribute("name", "tprice");
                    tpriceInput.setAttribute("value", tprice); 
					form2.appendChild(tpriceInput);

					// tfee
					var tfeeInput = document.createElement("input");
					tfeeInput.setAttribute("type", "hidden");
					tfeeInput.setAttribute("name", "tfee");
					tfeeInput.setAttribute("value", tfee);
					form2.appendChild(tfeeInput);

					// tamount
					var tamountInput = document.createElement("input");
					tamountInput.setAttribute("type", "hidden");
					tamountInput.setAttribute("name", "tamount");
					tamountInput.setAttribute("value", tamount); 
					form2.appendChild(tamountInput);

					// tfuel
					var tfuelInput = document.createElement("input");
					tfuelInput.setAttribute("type", "hidden");
					tfuelInput.setAttribute("name", "tfuel");
					tfuelInput.setAttribute("value", tfuel); 
					form2.appendChild(tfuelInput);

					// ttax
					var ttaxInput = document.createElement("input");
					ttaxInput.setAttribute("type", "hidden");
					ttaxInput.setAttribute("name", "ttax");
					ttaxInput.setAttribute("value", ttax);
					form2.appendChild(ttaxInput);
 
                    document.body.appendChild(form2); //결제정보 넣음
                    
                    var formData = new FormData(form2);
                    
                  	var form3 = document.createElement("form"); //예약내역 넣기
                    form3.setAttribute("action", "/reservations"); 
                    form3.setAttribute("method", "post");
                    
                    var fuuidInput = document.createElement("input");
                    fuuidInput.setAttribute("type", "hidden");
                    fuuidInput.setAttribute("name", "fuuid");
                    fuuidInput.setAttribute("value", fuuid);
                    form3.appendChild(fuuidInput);

                    var muuidInput = document.createElement("input");
                    muuidInput.setAttribute("type", "hidden");
                    muuidInput.setAttribute("name", "muuid");
                    muuidInput.setAttribute("value", muuid);
                    form3.appendChild(muuidInput);
   
                    document.body.appendChild(form3); 
                    	var form4 = document.createElement("form");
                        form4.setAttribute("action", "/reservations2"); 
                        form4.setAttribute("method", "post");
                        
                        var fuuidInput2 = document.createElement("input");
                        fuuidInput2.setAttribute("type", "hidden");
                        fuuidInput2.setAttribute("name", "fuuid2");
                        fuuidInput2.setAttribute("value", fuuid2);
                        form4.appendChild(fuuidInput2);

                        var muuidInput2 = document.createElement("input");
                        muuidInput2.setAttribute("type", "hidden");
                        muuidInput2.setAttribute("name", "muuid2");
                        muuidInput2.setAttribute("value", muuid2);
                        form4.appendChild(muuidInput2);
                    	
                        document.body.appendChild(form4);
                         
                        var form5 = document.createElement("form");
                        form5.setAttribute("action", "/mypage");
                        form5.setAttribute("method", "get");
                        
                        var fuuidInput5 = document.createElement("input");
                        fuuidInput5.setAttribute("type", "hidden");
                        fuuidInput5.setAttribute("name", "fuuid5");
                        fuuidInput5.setAttribute("value", fuuid);
                        
                        form5.appendChild(fuuidInput5);
                        document.body.appendChild(form5);

                   var formData3 = new FormData(form3); //예약내역 넣는거
                   var formData4 = new FormData(form4);
                  setTimeout(function () {
                   	submitForm(); //탑승객 폼
                    }, 100);
                    form.submit(); //좌석수 폼
                    if(confirm("결제에 성공하셨습니다!")){
                    $.ajax({
                        type: "POST",
                        url: "/totalamount", //결제 내역
                        data: formData, 
                        processData: false, 
                        contentType: false, 
                        success: function (data) {
                            $.ajax({
                                type: "POST",
                                url: "/getPno", //pno 뽑아주는거
                                data: formData,
                                processData: false, 
                                contentType: false,
                                success: function (data) {  										 
                                },
                                error: function () {
                                    
                               }
                            });
                        },
                        error: function () {
                            alert("결제에 실패하셨습니다.");
                            window.location.href = "/main";
                        }
                    });
                    }
                    if(confirm("축하합니다!!!")){
                    $.ajax({
                        type: "POST",
                        url: "/getruuid",
                        data: formData3,
                        processData: false,
                        contentType: false,
                        success: function (data) {
                        	form3.submit();
                        	window.location.href = "/mypage";
                        },
                        error: function () {
                            alert("결제!");
                            window.location.href = "/mypage";
                        }
                    });
                    }

                } else {
                    alert("결제에 실패하셨습니다.");
                    return "/main";
                }
                if (count11 == "B") {
                    $.ajax({
                        type: "POST",
                        url: "/reservations2",
                        data: formData4,
                        processData: false,
                        contentType: false,
                        success: function (data) {
                        	form4.submit();
                			form5.submit();
                            alert("결제!!!");
                          	window.location.href = "/mypage";
                        },
                        error: function () {
                            alert("결제!");
                        }
                    });
                } else {
                    
                    return "/mypage";
                }

            });     
        }        
        //약관 동의 체크박스
        function checkSelectAll(checkbox)  {
      	  const selectall 
      	    = document.querySelector('input[name="selectall"]');
      	  
      	  if(checkbox.checked === false)  {
      	    selectall.checked = false;
      	  }
      	}
        function openModal(content) {
          var modal = document.getElementById("myModal");
          var modalText = document.getElementById("modalText");
          modalText.innerHTML = content;
          modal.style.display = "block";
        }

        // 모달 닫고
        function closeModal() {
          var modal = document.getElementById("myModal");
          modal.style.display = "none";
        }
        
      	function selectAll(selectAll)  {
      	  const checkboxes 
      	     = document.getElementsByName('agree');      	  
      	  checkboxes.forEach((checkbox) => {
      	    checkbox.checked = selectAll.checked
      	  })
      	} 
    </script>
</head>
<style>
</style>
<body>
<%@ include file="menu.jsp"%>
<div class="container">
<div class='left-box'>
    <div style="text-align:center;">
        <div class="join-div">
<br><br>
            <h4 id="sujin"><i class="xi-flight-on"></i> 선택한 항공권</h4>
            <table class="choice" style="margin-left:auto; margin-right:auto;">
                <tr>
                    <th class="fname"><i class="xi-flight-on"></i>항공편</th>
                    <th class="fname"><i class="xi-flight-takeoff"></i> 출발지(Departure)</th>
                    <th class="fname"><i class="xi-flight-land"></i> 도착지(Arrival)</th>
                </tr>
                 <tr> 
                    <td class="fname1">${depairline}</td>
                    <td class="fname1">${fdeparture }<br>${depdate}<br>${depftod}</td>
                    <td class="fname1">${farrival }<br>${depdate}<br>${depftoa}</td>
                </tr>                
            </table>
        </div>
        <br>
        <h4><i class="xi-toilet"></i> 탑승객 정보</h4>
        <form action="/passengers" method="post" class="passengersForm">
        <div class="formContainer"></div>    
        </form>     
        <br>
        <div id="myModal" class="modal">
  		<div class="modal-content">
  		<div style="text-align:right;">
   			 <span class="close" onclick="closeModal()">X</span>
   			 </div>
    			<p id="modalText"></p>
    			<br><br><br>
    		<div style="text-align:center;">	
    	<span class="close" onclick="closeModal()" style="display: block; margin: 0 auto;">확인</span>
    	</div>
  </div>
</div>  
	<div class="bigagree"> 
       <h4><i class="xi-library-books"></i> 약관동의</h4>
       <hr>
		<input class="agree" type='checkbox' id='selectall' name='selectall' value='selectall' onclick='selectAll(this)'/> 모두 동의<br/>
		<label class="agree" for='agree' onclick='openModal("<b>[필수] 서비스 이용약관 동의</b><br><br><br>①서비스는 관계 법령이 정하는 바에 따라 회원의 개인정보를 보호하고 존중하기 위해 노력합니다. 회원의 개인정보보호에 관해서는 관련법령 및 서비스에서 정하는 “개인정보보호정책”에 정한 바에 의합니다.<br><br> ② 서비스는 이용 신청 시 또는 커뮤니티 활동, 이벤트 참가를 위하여 회원이 제공한 정보 및 기타 서비스 이용 과정에서 수집되는 정보 등을 수집할 수 있고, 이렇게 수집되어진 회원의 개인정보는 회원과의 이용계약 이행과 본 서비스상의 서비스 제공을 위한 목적으로 사용됩니다.<br><br>③ 서비스는 수집한 회원의 신상정보를 본인의 승낙 없이 제3자에게 누설 또는 배포할 수 없으며 상업적 목적으로 사용할 수 없습니다. 다만, 다음의 각 호에 해당하는 경우에는 그러하지 아니합니다.")'>
    		<input type='checkbox' class='agree' name='agree' value='agree' />
    		[필수] 서비스 이용약관 동의
		</label> <br />

		<label class="agree" for='agree' onclick='openModal("<b>[필수] 개인정보의 수집 및 이용에 대한 동의</b><br><br><br>① 서비스는 제 8조 제 3 항을 위반하지 않는 한도 내에서 업무와 관련하여 회원 전체 또는 일부의 개인정보에 관한 집합적인 통계 자료를 작성하여 이를 사용할 수 있고, 서비스를 통하여 회원의 컴퓨터에 쿠키를 전송할 수 있습니다. 이 경우 회원은 쿠키의 수신을 거부하거나 쿠키의 수신에 대하여 경고하도록 사용하는 컴퓨터의 브라우저의 설정을 변경할 수 있습니다. <br><br>② 서비스가 수집하는 개인정보는 서비스의 제공에 필요한 최소한으로 하되, 필요한 경우 보다 더 자세한 정보가 요구될 수 있습니다. <br><br>③ 회원은 언제든지 원하는 경우에 서비스에 제공한 개인정보의 수집과 이용에 대한 동의를 철회할 수 있으며, 동의의 철회는 해지 신청을 함으로써 이루어지게 됩니다.")'>
    		<input type='checkbox' class='agree' name='agree' value='agree' />
    		[필수] 개인정보의 수집 및 이용에 대한 동의
		</label> <br />
		<label class="agree" for='agree' onclick='openModal("<b>[필수] 항공사의 이용약관에 대한 동의</b><br><br><br>① 서비스는 제 8조 제 3 항을 위반하지 않는 한도 내에서 업무와 관련하여 회원 전체 또는 일부의 개인정보에 관한 집합적인 통계 자료를 작성하여 이를 사용할 수 있고, 서비스를 통하여 회원의 컴퓨터에 쿠키를 전송할 수 있습니다. 이 경우 회원은 쿠키의 수신을 거부하거나 쿠키의 수신에 대하여 경고하도록 사용하는 컴퓨터의 브라우저의 설정을 변경할 수 있습니다. <br><br>② 서비스가 수집하는 개인정보는 서비스의 제공에 필요한 최소한으로 하되, 필요한 경우 보다 더 자세한 정보가 요구될 수 있습니다. <br><br>③ 회원은 언제든지 원하는 경우에 서비스에 제공한 개인정보의 수집과 이용에 대한 동의를 철회할 수 있으며, 동의의 철회는 해지 신청을 함으로써 이루어지게 됩니다.")'>
    		<input type='checkbox' class='agree' name='agree' value='agree' />
    		[필수] 항공사 이용약관 동의<br>
		</label> <br />
		
	</div>
		<br><br><br>       
    </div>

</div>
<div class='right-box'>
	<br><br><br><br><br>
    <div class="my-box">
        <h4><i class="xi-money"></i> 결제 정보</h4>
        <hr>
        <b><i class="xi-flight-on"></i> 항공권 가격</b> <br><span class="tamount"></span>원
        <br><br>
    	<b><i class="xi-flight-on"></i> 제세공과금(23.09.26 기준)</b> <br>4,000 X <span class ="peopleCount"></span>명 = <span class="ttax"></span>원
    	<br>
    	<b><i class="xi-flight-on"></i> 유류할증료</b><br>9,900 X <span class="peopleCount"></span>명 = <span class="tfuel"></span>원
    	<br>
        <b><i class="xi-flight-on"></i> 발권수수료</b><br>1,000 X <span class="peopleCount"></span>명 = <span class="tfee"></span>원
        <br><br>
        <b><i class="xi-flight-on"></i> 회원할인(vip 10%, vvip 20%)</b><br> 항공권 가격 <b><span class="discountRate100"></span>%</b> 할인 적용      
        <br><br>
         <b>항공권 금액</b> <span class="tprice"></span>원 + <b>발권 수수료 </b><span class="tfee"></span>원
         <br><b>제세공과금</b> <span class="ttax"></span>원 + <b>유류할증료 </b><span class="tfuel"></span>원
        <br> <b>◎ 총 금액 : <span class="real"></span>원</b>
       
     	<hr>
        <div style="text-align: center;"><b>총 결제 금액  :  <span class="real"></span>원</b>
      
        <br><br>
        <div style="text-align:center;">
        <button onclick="requestPay()" class="pay" style="display:none;"><b><span class="real"></span></b>원결제하기</button>
		</div>
        </div>
    </div>
</div>
</div>
<footer class="footer">
<br>
<p>서울 강남구 테헤란로 7길 7(역삼동 에스코빌딩 7층) / 대표자: 김민성 / TEL:02-000-1111</p>
<p>Copyright ⓒ 2023. 내가 사랑한 여름. All Rights Reserved</p>
</footer>


</body>
</html>