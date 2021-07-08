<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /**
  * @Class Name : MacList.jsp
  * @Description : Mac List 화면
  * @Modification Information
  * 
  * @author hanseol
  * @since 20210708
  * @version 1.0
  * @see
  *  
  * Copyright (C) All right reserved.
  */
%>
<style>
	th {
		width:120px;
	}
	
</style>
<div>

	<div class="panel">
		<div class="panel-title">
			<h3>설비 조회</h3>
		</div>
		<div class="panel-body">
			<a id="searchProductCode" href="openMacListModal.do" rel="modal:open">
			<input type="text" id="mac"></a>
			<button type="button" id="showMachine">조회</button>
		</div>
	</div>
	
	<div class="panel">
		<div class="panel-heading">
			<h3 class="panel-title" id="macModel"></h3>
		</div>
		<div class="panel-body">
			<table class="table table-bordered">
				<thead>
				</thead>
				<tbody>
					<tr>
						<th>사용여부</th>
						<td colspan="3"></td>
						<th>설비구분</th>
						<td colspan="3"></td>
					</tr>
					<tr>
						<th>설비코드</th>
						<td colspan="3"></td>
						<th>설비명</th>
						<td colspan="3"></td>
					</tr>
					<tr>
						<th>용도</th>
						<td colspan="3"></td>
						<th>공정코드</th>
						<td colspan="3"></td>
					</tr>
					<tr>
						<th>점검일</th>
						<td colspan="3"></td>
						<th>차기점검일</th>
						<td></td>
						<th>점검주기</th>
						<td></td>
					</tr>
					<tr>
						<th>설비규격</th>
						<td colspan="3"></td>
						<th>용량/규격</th>
						<td colspan="3"></td>
					</tr>
					<tr>
						<th>1H생산량</th>
						<td colspan="3"></td>
						<th>라인번호</th>
						<td colspan="3"></td>
					</tr>
					<tr>
						<th>모델</th>
						<td colspan="3"></td>
						<th>기준부하율</th>
						<td colspan="3">-</td>
					</tr>
					<tr>
						<th>구매일자</th>
						<td colspan="3"></td>
						<th>제작업체</th>
						<td></td>
						<th>연락처</th>
						<td></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	
	
</div>

<script>

	$(document).ready(function(){
		
		$("#showMachine").on("click",function(){
			var macCode = $("#mac").val();
			$.ajax({
				url: '${pageContext.request.contextPath}/ajax/mac/macInfo',
				type: 'GET',
				dataType: 'JSON',
				contentType : "application/json",
				data: {macCode: macCode },
				success: function(response){
					var item = response.data;
					
					$('body').find("h3[id=macModel]").html(item.macModel);
					
					$("tbody").empty();
					$('<tr>')
					.append($('<th>').html("사용여부"))
					.append($('<td colspan="3">').html(item.macUnused))
					.append($('<th>').html("설비구분"))
					.append($('<td colspan="3">').html(item.macGubun)).appendTo('tbody');
					
					$('<tr>')
					.append($('<th>').html("설비코드"))
					.append($('<td colspan="3">').html(item.macCode))
					.append($('<th>').html("설비명"))
					.append($('<td colspan="3">').html(item.macName)).appendTo('tbody');
					
					$('<tr>')
					.append($('<th>').html("용도"))
					.append($('<td colspan="3">').html(item.macUsePurPose))
					.append($('<th>').html("공정코드"))
					.append($('<td colspan="3">').html(item.comProcessCode)).appendTo('tbody');
					
					$('<tr>')
					.append($('<th>').html("1H생산량"))
					.append($('<td colspan="3">').html(item.macHourQty))
					.append($('<th>').html("라인번호"))
					.append($('<td colspan="3">').html(item.macLineNo)).appendTo('tbody');
					
					$('<tr>')
					.append($('<th>').html("점검일"))
					.append($('<td colspan="3">').html(item.macChkDate))
					.append($('<th>').html("차기점검일"))
					.append($('<td>').html(item.macNextChkDate))
					.append($('<th>').html("점검주기"))
					.append($('<td>').html(item.macChkCycle+"개월")).appendTo('tbody');
					
					$('<tr>')
					.append($('<th>').html("설비규격"))
					.append($('<td colspan="3">').html(item.macSize))
					.append($('<th>').html("용량/규격"))
					.append($('<td colspan="3">').html(item.macPossibleSize)).appendTo('tbody');
					
					$('<tr>')
					.append($('<th>').html("모델"))
					.append($('<td colspan="3">').html(item.macModel))
					.append($('<th>').html("기준부하율"))
					.append($('<td colspan="3">').html(item.macBuha)).appendTo('tbody');
					
					$('<tr>')
					.append($('<th>').html("구매일자"))
					.append($('<td colspan="3">').html(item.macMachineDate))
					.append($('<th>').html("제작업체"))
					.append($('<td>').html(item.macMachineConstructor))
					.append($('<th>').html("비상연락망"))
					.append($('<td>').html("010-1234-5678")).appendTo('tbody');
					
				}
			});
		});
		
	});
</script>

