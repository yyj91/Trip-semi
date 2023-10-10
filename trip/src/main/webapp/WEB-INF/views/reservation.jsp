<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet">
<link href="css/reservation.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<%@ include file="menu.jsp" %>

<div id="setConditionDiv">
</div>

<div id="searchDiv">
</div>
<div id="ListDiv">
<div id="depListDiv">
<!-- 출발편 목록 -->
<div>출발
<div id="depSelect" class="sortSelect">
   <div class="select-style" onclick="toggleDropdown('dep')">정렬기준</div>
   <div class="dropdown" id="depDropdown">
      <div class="dropdown-item" onclick="selectOption('가격 낮은순', 'dep')">가격 낮은순</div>
      <div class="dropdown-item" onclick="selectOption('가격 높은순', 'dep')">가격 높은순</div>
      <div class="dropdown-item" onclick="selectOption('출발 빠른순', 'dep')">출발 빠른순</div>
      <div class="dropdown-item" onclick="selectOption('출발 늦은순', 'dep')">출발 늦은순</div>
   </div>
   <select id="depRealSelect" style="display: none;">
      <option value="가격 낮은순">가격 낮은순</option>
      <option value="가격 높은순">가격 높은순</option>
      <option value="출발 빠른순">출발 빠른순</option>
      <option value="출발 늦은순">출발 늦은순</option>
   </select>
</div>
</div>

<div id="departureTimeFilterDiv">
   <label><input type="checkbox" class="departure-time-filter" value="all" checked>전체</label>
   <label><input type="checkbox" class="departure-time-filter" value="morning" checked>06:00~11:59</label>
   <label><input type="checkbox" class="departure-time-filter" value="afternoon" checked>12:00~17:59</label>
   <label><input type="checkbox" class="departure-time-filter" value="evening" checked>18:00~24:00</label>
</div>
<div class="table-container">
<table>
   <thead>
   <tr>
      <th>항공사</th>
      <th>출발</th>
      <th>도착</th>
      <th>가격</th>
   </tr>
   </thead>
   <tbody class="reservationTbody">
   <c:forEach var="dep" items="${depList }">
   <c:set var="stm" value="06:00:00"/>
   <c:set var="mtm" value="12:00:00"/>
   <c:set var="etm" value="18:00:00"/>
   <c:set var="ctm" value="24:00:00"/>
   <c:set var="deptm" value="${fn:substring(dep.ftod, 11, 19)}"/>
   <c:set var="classdef">
   <c:choose>
      <c:when test="${deptm >= stm && deptm < mtm}">
         dmorning
      </c:when>
      <c:when test="${deptm >= mtm && deptm < etm}">
         dafternoon
      </c:when>
      <c:when test="${deptm >= etm && deptm < ctm}">
         devening
      </c:when>
      <c:otherwise>
         other
      </c:otherwise>
      </c:choose>
   </c:set>
    
   <tr class="${classdef } detailTr">
      <td>${dep.fairline }<br>${dep.fname }</td>
      <td>${fn:substring(dep.ftod, 11, 16)}</td>
      <td>${fn:substring(dep.ftoa, 11, 16)}</td>
      <td>${dep.minSprice }~</td>
      <td class="hidden-value">${dep.fuuid }</td>
   </tr>
   </c:forEach>
   </tbody>
</table>
</div>
</div>

<div id="arrListDiv">
<!-- 도착편 목록 -->
<div>도착
<div id="arrSelect" class="sortSelect">
   <div class="select-style" onclick="toggleDropdown('arr')">정렬기준</div>
   <div class="dropdown" id="arrDropdown">
      <div class="dropdown-item" onclick="selectOption('가격 낮은순', 'arr')">가격 낮은순</div>
      <div class="dropdown-item" onclick="selectOption('가격 높은순', 'arr')">가격 높은순</div>
      <div class="dropdown-item" onclick="selectOption('출발 빠른순', 'arr')">출발 빠른순</div>
      <div class="dropdown-item" onclick="selectOption('출발 늦은순', 'arr')">출발 늦은순</div>
   </div>
   <select id="arrRealSelect" style="display: none;">
      <option value="가격 낮은순">가격 낮은순</option>
      <option value="가격 높은순">가격 높은순</option>
      <option value="출발 빠른순">출발 빠른순</option>
      <option value="출발 늦은순">출발 늦은순</option>
   </select>
</div>
</div>

<div id="arrivalTimeFilterDiv">
   <label><input type="checkbox" class="arrival-time-filter" value="all" checked>전체</label>
   <label><input type="checkbox" class="arrival-time-filter" value="morning" checked>06:00~11:59</label>
   <label><input type="checkbox" class="arrival-time-filter" value="afternoon" checked>12:00~17:59</label>
   <label><input type="checkbox" class="arrival-time-filter" value="evening" checked>18:00~24:00</label>
</div>
<div class="table-container">
<table>
   <thead>
   <tr>
      <th>항공사</th>
      <th>출발</th>
      <th>도착</th>
      <th>가격</th>
   </tr>
   </thead>
   <tbody class="reservationTbody">
   <c:forEach var="arr" items="${arrList }">
   <c:set var="stm" value="06:00:00"/>
   <c:set var="mtm" value="12:00:00"/>
   <c:set var="etm" value="18:00:00"/>
   <c:set var="ctm" value="24:00:00"/>
   <c:set var="arrtm" value="${fn:substring(arr.ftod, 11, 19)}"/>
   <c:set var="classdef">
   <c:choose>
      <c:when test="${arrtm >= stm && arrtm < mtm}">
         amorning
      </c:when>
      <c:when test="${arrtm >= mtm && arrtm < etm}">
         aafternoon
      </c:when>
      <c:when test="${arrtm >= etm && arrtm < ctm}">
         aevening
      </c:when>
      <c:otherwise>
         other
      </c:otherwise>
   </c:choose>
   </c:set>
    
   <tr class="${classdef } detailTr">
      <td>${arr.fairline }<br>${arr.fname }</td>
      <td>${fn:substring(arr.ftod, 11, 16)}</td>
      <td>${fn:substring(arr.ftoa, 11, 16)}</td>
      <td>${arr.minSprice }~</td>
      <td class="hidden-value">${arr.fuuid }</td>
   </tr>
   </c:forEach>
   </tbody>
</table>
</div>
</div>
</div>

<form id="pamentForm" action="./payment" method="get">

<input type="hidden" name="choice" value="${choice }">
<input type="hidden" name="adultCount" value="${adultCount }">
<input type="hidden" name="childCount" value="${childCount }">
<input type="hidden" name="infantCount" value="${infantCount }">

<button id="goPayment" type="submit" disabled="disabled" >결제하기</button>
</form>
<script type="text/javascript">
  
let depSelected = false;
let arrSelected = false;
  
$(document).ready(function() {
   
   if ("${choice}" === 'A') {
      arrSelected = true;
        $("#arrListDiv").hide();
    }
  
   $("#departureTimeFilterDiv .departure-time-filter[value='all']").change(function(){
      let isChecked = $(this).prop("checked");
      $("#departureTimeFilterDiv .departure-time-filter").prop("checked", isChecked);
  
      filterDivs("depListDiv", "departure-time-filter");
   });
  
   $("#departureTimeFilterDiv .departure-time-filter").change(function(){
      let allChecked = $("#departureTimeFilterDiv .departure-time-filter:checked").length === $("#departureTimeFilterDiv .departure-time-filter").length;
      $("#departureTimeFilterDiv .departure-time-filter[value='all']").prop("checked", allChecked);
   
      filterDivs("depListDiv", "departure-time-filter");
   });

   $("#arrivalTimeFilterDiv .arrival-time-filter[value='all']").change(function(){
      let isChecked = $(this).prop("checked");
      $("#arrivalTimeFilterDiv .arrival-time-filter").prop("checked", isChecked);
  
      filterDivs("arrListDiv", "arrival-time-filter");
   });
  
   $("#arrivalTimeFilterDiv .arrival-time-filter").change(function() {
      let allChecked = $("#arrivalTimeFilterDiv .arrival-time-filter:checked").length === $("#arrivalTimeFilterDiv .arrival-time-filter").length;
      $("#arrivalTimeFilterDiv .arrival-time-filter[value='all']").prop("checked", allChecked);
  
      filterDivs("arrListDiv", "arrival-time-filter");
   });
        
   $("#depListDiv").on("click", ".detailTr", function() {
       const fuuid = $(this).find(".hidden-value").text();
       if ($(this).next(".detailRow.dep").length > 0) {
          while ($(this).next(".detailRow.dep").length > 0) {
               $(this).next(".detailRow.dep").remove();
           }
       } else {
           addDetailInfoRow($(this), fuuid, "dep");
       }
   });

   $("#arrListDiv").on("click", ".detailTr", function() {
       const fuuid = $(this).find(".hidden-value").text();
       if ($(this).next(".detailRow.arr").length > 0) {
          while ($(this).next(".detailRow.arr").length > 0) {
               $(this).next(".detailRow.dep").remove();
           }
       } else {
           addDetailInfoRow($(this), fuuid, "arr");
       }
   });
   
   function addDetailInfoRow(clickedRow, fuuid, listType) {
      
       $.ajax({
           type: "get",
           url: "/getDetailInfo",
           data: { fuuid : fuuid },
           dataType: "json",
           contentType: "application/x-www-form-urlencoded; charset=UTF-8",
           success: function(data) {
               $.each(data.list, function(index, listItem) {
                   const detailRow = $("<tr>").addClass("detailRow " + listType);
                   detailRow.append("<td>" + listItem.sgrade + "</td>");
                   detailRow.append("<td>" + listItem.sremainder + " / " + listItem.sseat + "</td>");
                   detailRow.append("<td>" + listItem.sprice + "</td>");
                   detailRow.append($("<button>").text("선택").click(function() {
                      selectSeat(listType, fuuid, listItem.sno);
                   }));
               clickedRow.after(detailRow);
               });
           },
           error: function(error) {
               alert("ERROR: " + JSON.stringify(error));
           }
       });
   }
});

function filterDivs(containerId, filterClassName) {
  
  
   $("#" + containerId + " ." + filterClassName + ":checked").each(function(){
      if(containerId === "depListDiv"){
         $(".d" + $(this).val()).show();
      }
      if(containerId === "arrListDiv"){
         $(".a" + $(this).val()).show();
      }
   });
  
   $("#" + containerId + " ." + filterClassName + ":not(:checked)").each(function(){
      if(containerId === "depListDiv"){
         $(".d" + $(this).val()).hide();
      }
      if(containerId === "arrListDiv"){
         $(".a" + $(this).val()).hide();
      }
   });
}

function toggleDropdown(selectId) {
   const dropdown = document.getElementById(selectId + "Dropdown");
   if (dropdown.style.display === "block") {
      dropdown.style.display = "none";
   } else {
      dropdown.style.display = "block";
   }
}

function selectOption(option, selectId) {
   const realSelect = document.getElementById(selectId + "RealSelect");
   realSelect.value = option;
   
   const selectStyle = realSelect.parentNode.querySelector(".select-style");
   selectStyle.textContent = option;
   
   toggleDropdown(selectId);
   
   onSortOptionChange(selectId);
}

function collectSearchCriteria() {
   const choice = "${choice}";
   const departure = "${departure}";
   const arrival = "${arrival}";
   const tod = "${tod}";
   const toa = "${toa}";
   const adultCount = "${adultCount}";
   const childCount = "${childCount}";
   const infantCount = "${infantCount}";

   return {
      choice: choice,
      departure: departure,
      arrival: arrival,
      tod: tod,
      toa: toa,
      adultCount: adultCount,
      childCount: childCount,
      infantCount: infantCount
   };
}

function onSortOptionChange(selectId) {

    const selectedOption = document.getElementById(selectId + "RealSelect").value;
    const searchCriteria = collectSearchCriteria();
    
   const requestData = {
      option: selectedOption,
      section: selectId,
      searchCriteria: searchCriteria
        };

    $.ajax({
        type: "get",
        url: "./getSortedList",
        data: requestData,
        dataType: "json", 
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        success: function(data) {
         if (selectId === "dep") {
            $("#depListDiv tbody").empty();
            data.list.forEach(function (item) {
               const deptm = item.ftod.substring(11, 19); 
               const classdef = getClassByTime(deptm);
               appendRow("depListDiv", item, classdef, "d");
            });
         } else if (selectId === "arr") {
            $("#arrListDiv tbody").empty();
            data.list.forEach(function (item) {
               const arrtm = item.ftoa.substring(11, 19); 
               const classdef = getClassByTime(arrtm); 
               appendRow("arrListDiv", item, classdef, "a");
            });
         }
      },
        error: function(error) {
           alert("ERROR: " + JSON.stringify(error));
        }
    });
}

function getClassByTime(time) {
   const stm = "06:00:00";
   const mtm = "12:00:00";
   const etm = "18:00:00";
   const ctm = "24:00:00";

   if (time >= stm && time < mtm) {
      return "morning";
   } else if (time >= mtm && time < etm) {
      return "afternoon";
   } else if (time >= etm && time < ctm) {
      return "evening";
   } else {
      return "other";
   }
}

function appendRow(containerId, item, classdef, prefix) {
   const row = $("<tr>").append(
      $("<td>").text(item.fairline + "\n" + item.fname),
      $("<td>").text(item.ftod.substring(11, 16)),
      $("<td>").text(item.ftoa.substring(11, 16)),
      $("<td>").text(item.minSprice + "~"),
      $("<td>").text(item.fuuid).addClass("hidden-value")
   ).addClass(prefix + classdef);
   row.addClass("detailTr");
   
   $("#" + containerId + " tbody").append(row);
}

function selectSeat(type, fuuid, sno) {
    
    if (type === "dep") {
        $("#depListDiv").empty();
        depSelected = true;
    } else if (type === "arr") {
        $("#arrListDiv").empty();
        arrSelected = true;
    }
    
    //alert("fuuid: " + fuuid + ", sno: " + sno);
    $.ajax({
        type: "get",
        url: "/selectedInfo",
        data: { fuuid : fuuid, sno : sno },
        dataType: "json",
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        success: function(data) {
            
           let fInfo = data.fInfo;
            let sInfo = data.sInfo;
            let aInfo = data.aInfo;

            let html = '';
            html += '<div id="selectedInfoDiv">';
            html +=    '<div id="infoDivHead">';
            html +=       '<span class="lHeadSpan">';
            html +=          fInfo.ftod.substring(0, 10);
            $("#pamentForm")
            .append('<input type="hidden" name="'+type+'date" value="'+fInfo.ftod.substring(0, 10)+'">');
            html +=       '</span>';
            html +=       '<span class="rHeadSpan">';
            html +=          fInfo.fairline;
            $("#pamentForm")
            .append('<input type="hidden" name="'+type+'airline" value="'+fInfo.fairline+'">');
            html +=         '</sapn>';
            html +=         '<span class="rHeadSpan softSpan">';
            html +=            fInfo.fname;
            $("#pamentForm")
            .append('<input type="hidden" name="'+type+'fname" value="'+fInfo.fname+'">');
            html +=         '</span>';
            html +=         '<span class="rHeadSpan">';
            html +=            sInfo.sgrade;
            $("#pamentForm")
            .append('<input type="hidden" name="'+type+'sgrade" value="'+sInfo.sgrade+'">');
            html +=       '</span>';
            html +=    '</div>';
            html +=    '<div id="infoDivBody">';
            html +=       '<span>';
            html +=          fInfo.ftod.substring(11, 16);
            $("#pamentForm")
            .append('<input type="hidden" name="'+type+'ftod" value="'+fInfo.ftod.substring(11, 16)+'">');
            html +=       '</span>';
            html +=       '<span>';
            html +=          fInfo.ftoa.substring(11, 16);
            $("#pamentForm")
            .append('<input type="hidden" name="'+type+'ftoa" value="'+fInfo.ftoa.substring(11, 16)+'">');
            html +=       '</span>';
            html +=       '<span id="totalPrice">';
            html +=       '</span>';
            html +=    '</div>';
            html +=    '<div id="infoDivCostDetail">';
            html +=    '<table>';
            html +=    '<thead>';
            html +=    '<tr>';
            html +=       '<th>인원</th>';
            html +=       '<th>항공요금</th>';
            html +=       '<th>'+aInfo[1].aname+'</th>';
            html +=       '<th>'+aInfo[2].aname+'</th>';
            html +=       '<th>'+aInfo[0].aname+'</th>';
            html +=       '<th>합계</th>';
            html +=    '</tr>';
            html +=    '</thead>';
            html +=    '<tbody>';
            html +=    '<tr>';
            html +=       '<td>';
            html +=         '성인 : ';
            html +=       ${adultCount};
            let adultPrice = 0;
            html +=       '</td>';
            html +=       '<td>';
            html +=       sInfo.sprice * ${adultCount};
            adultPrice +=   sInfo.sprice * ${adultCount};
            $("#pamentForm")
            .append('<input type="hidden" name="'+type+'adultsprice" value="'+sInfo.sprice * ${adultCount}+'">');
            html +=       '</td>';
            html +=       '<td>';
            html +=       aInfo[1].aprice * ${adultCount};
            adultPrice +=   aInfo[1].aprice * ${adultCount};
            html +=       '</td>';
            html +=       '<td>';
            html +=       aInfo[2].aprice * ${adultCount};
            adultPrice +=   aInfo[2].aprice * ${adultCount};
            html +=       '</td>';
            html +=       '<td>';
            html +=       aInfo[0].aprice * ${adultCount};
            adultPrice +=   aInfo[0].aprice * ${adultCount};
            html +=       '</td>';
            html +=       '<td>';
            html +=       adultPrice;
            html +=       '</td>';
            html +=    '</tr>';
            html +=    '<tr>';
            html +=       '<td>';
            html +=         '소아 : ';
            html +=       ${childCount};
            let childPrice = 0;
            html +=       '</td>';
            html +=       '<td>';
            html +=       sInfo.sprice * ${childCount};
            childPrice +=   sInfo.sprice * ${childCount};
            $("#pamentForm")
            .append('<input type="hidden" name="'+type+'childsprice" value="'+sInfo.sprice * ${childCount}+'">');
            html +=       '</td>';
            html +=       '<td>';
            html +=       aInfo[1].aprice * ${childCount};
            childPrice +=   aInfo[1].aprice * ${childCount};
            html +=       '</td>';
            html +=       '<td>';
            html +=       aInfo[2].aprice * ${childCount};
            childPrice +=   aInfo[2].aprice * ${childCount};
            html +=       '</td>';
            html +=       '<td>';
            html +=       aInfo[0].aprice * ${childCount};
            childPrice +=   aInfo[0].aprice * ${childCount};
            html +=       '</td>';
            html +=       '<td>';
            html +=       childPrice;
            html +=       '</td>';
            html +=    '</tr>';
            html +=    '<tr>';
            html +=       '<td>';
            html +=         '유아 : ';
            html +=       ${infantCount};
            let infantPrice = 0;
            html +=       '</td>';
            html +=       '<td>';
            html +=       0 * ${infantCount};
            infantPrice +=   0 * ${infantCount};
            html +=       '</td>';
            html +=       '<td>';
            html +=       0 * ${infantCount};
            infantPrice +=   0 * ${infantCount};
            html +=       '</td>';
            html +=       '<td>';
            html +=       0 * ${infantCount};
            infantPrice +=   0 * ${infantCount};
            html +=       '</td>';
            html +=       '<td>';
            html +=       0 * ${infantCount};
            infantPrice +=   0 * ${infantCount};
            html +=       '</td>';
            html +=       '<td>';
            html +=       infantPrice;
            html +=       '</td>';
            html +=    '</tr>';
            html +=    '</tbody>';
            html +=    '</table>';
            html +=    '</div>';
            html += '</div>';
            
            $("#" + type + "ListDiv").append(html);
            $("#totalPrice").text(adultPrice+childPrice+infantPrice);
            
            $("#pamentForm")
            .append('<input type="hidden" name="'+type+'fuuid" value="'+fuuid+'">');
            $("#pamentForm")
            .append('<input type="hidden" name="'+type+'sno" value="'+sno+'">');
            
            if (depSelected && arrSelected) {
                $("#goPayment").prop("disabled", false);
            } else {
                $("#goPayment").prop("disabled", true);
            }
        },
        error: function(error) {
            alert("ERROR: " + JSON.stringify(error));
        }
    });
}

</script>

</body>
</html>