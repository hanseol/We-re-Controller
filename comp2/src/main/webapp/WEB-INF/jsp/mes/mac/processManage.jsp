<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
.modal {
		-webkit-border-radius: 0px;
		border-radius: 0px;
		overflow: visible;
		text-align: center;
		max-width: 1300px;
		width: 1200px;
		height: 100%;
	}

</style>	
<div class="content-fluid">
	<div class="panel panel-headline">
		<h3>공정관리 화면구상</h3>
	</div>
</div>

작업일자 공정명 작업자
지시번호 
작업시작시간
작업종료시간
현재실적량
달성률
불량량

	<!-- 정보 (테이블 출력) -->
<div class="panel">
	<div class="panel-body">
	<form name="frm" id="frm" method="post">
		<table class="table table-bordered" id="process">
			<thead>
			</thead>
			<tbody id="tbody">
				<tr>
					<th>공정명</th>
					<td><select name="comProcessCode" id="comProcessCode">
							<option value="">--------선택--------</option>
							<c:forEach var="procg" items="${procgs }">
							<option value="${procg.comProcessCode}">${procg.comProcessName}</option>
							</c:forEach>
						</select></td>
					<th>지시번호</th>
					<td>
						<select name="proOrderDetailCode" id="proOrderDetailCode">
							<option value="">--------선택--------</option>
						</select>
					</td>
					
				</tr>
				<tr>
					<th>라인번호</th>
					<td><input id="macLineNo" name="macLineNo"></td>
					<th>작업자</th>
					<td><input id="erpEmployeeId" name="erpEmployeeId"></td>
				</tr>
				<tr>
					<th>작업시작시간</th>
					<td><input id="proProcessStartTime" name="proProcessStartTime">
						<button type="button" id="startBtn" class="btn btn-danger">시작</button>
					</td>
					<th>작업종료시간</th>
					<td><input id="proProcessEndTime" name="proProcessEndTime">
						<button type="button" id="endBtn" class="btn btn-success">종료</button>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
	</div>
</div>
<!-- END 정보 -->

<div class="panel">
	<div class="panel-body">
		<div id="proOrderGrid"></div>
	</div>
</div>

<script>
	$(document).ready(function(){
		
		//1. 공정을 먼저 선택한다.
		$("#comProcessCode").on("change", function() {
			var comProcGubunCode = $("#comProcessCode option:selected").val();
			
			$.ajax({
				url:'${pageContext.request.contextPath}/ajax/pro/getProOrderDetailCode',
				type: 'GET',
				contentType: "application/json",
				dataType : "json",
				data:{"comProcessCode": comProcGubunCode},
				success: function(result){
					
					//result 갯수만큼 select 태그에 option태그 붙여 줘야함..
					$("select[name='proOrderDetailCode']").empty(); //셀렉트박스 비우기
					$("select[name='proOrderDetailCode']").append('<option value="">--------선택--------</option>');
					
					//결과값을 select box option으로 넘겨주기.
					var data = result.list;
					$.each(data,function(index,item){
						var rdata = "<option value='"+item+"'>"+ item + "</option>";
						$("select[name='proOrderDetailCode']").append(rdata);
					});
					
				}
			});
			
		});
		
		//2. 해당공정에서 작업해야 할 지시 코드를 선택한다.
		$("#proOrderDetailCode").on("change", function() {
			var proOrderDetailCode = $("#proOrderDetailCode option:selected").val();
			var comProcessCode = $("#comProcessCode option:selected").val();
			
			var readParams = {
					'proOrderDetailCode' : proOrderDetailCode,
					'comProcessCode' : comProcessCode
			};
			proOrderGrid.readData(1, readParams, true);
		});
		
		//3. 작업을 시작한다.
		$("#startBtn").on("click",function(){
			var today = new Date();
			var h = today.getHours();
			var m = today.getMinutes();
			var proProcessStartTime = h +":"+m;
			$("#proProcessStartTime").val(proProcessStartTime);
			
			var comProcessCode = $("#comProcessCode option:selected").val();
			var proOrderDetailCode = $("#proOrderDetailCode option:selected").val();
			console.log(comProcessCode);
			console.log(proOrderDetailCode);
			
			$.ajax({
				url:'${pageContext.request.contextPath}/ajax/pro/startProProcess',
				type: 'POST',
				dataType : "json",
				data:{"comProcessCode": comProcessCode,
						"proOrderDetailCode": proOrderDetailCode,
						"proProcessStartTime": proProcessStartTime},
				success: function(result){
					
				}
			});
		});
		
		//4. 작업을 종료한다.
		$("#endBtn").on("click",function(){
			var today = new Date();
			var h = today.getHours();
			var m = today.getMinutes();
			var proProcessEndTime = h + ":" + m;
			$("#proProcessEndTime").val(proProcessEndTime);
			
			var comProcessCode = $("#comProcessCode option:selected").val();
			var proOrderDetailCode = $("#proOrderDetailCode option:selected").val();
			console.log(comProcessCode);
			console.log(proOrderDetailCode);
			
			$.ajax({
				url: "${pageContext.request.contextPath}/ajax/pro/endProProcess",
				type: 'POST',
				data: {"comProcessCode" : comProcessCode,
					"proOrderDetailCode" : proOrderDetailCode,
					"proProcessEndTime" : proProcessEndTime},
				dataType : "JSON",
				success : function(result){
						
				}
			});
		});
		
		const dataSource = {
				api : {
					readData : {
						url : '${pageContext.request.contextPath}/ajax/pro/readMaterial',
						method : 'GET'
					}
				},
				initialRequest : false,
				contentType : "application/json"
			};
		
		const proOrderGrid = new tui.Grid({
			el : document.getElementById('proOrderGrid'),
			rowHeaders : [ 'checkbox' ],
			data : dataSource,
			scrollX : true,
			scrollY : true,
			bodyHeight :300, //테이블 높이
	        rowHeight: 30, //테이블 행 높이
			columns : [ {
				header : '자재명',
				name : 'comMaterialName',
				align : 'center'
			}, {
				header : '자재LOT번호',
				name : 'matLotNo',
				align : 'center'
			} ]
		});
	});
</script>
