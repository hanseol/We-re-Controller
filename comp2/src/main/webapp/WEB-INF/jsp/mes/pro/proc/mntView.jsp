<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 타이틀 -->
<div class="content-fluid">
	<div>
		<h2>생산관리</h2>
	</div>
</div>

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
					<th>제품명</th>
					<td><input id="comProductName" name="comProductName"></td>
				</tr>
				<tr>
					<th>라인번호</th>
					<td><input id="macLineNo" name="macLineNo"></td>
					<th>설비코드</th>
					<td><input id="macCode" name="macCode"></td>
					<th>작업자</th>
					<td><input id="erpEmployeeId" name="erpEmployeeId"></td>
				</tr>
				<tr>
					<th>작업시작시간</th>
					<td><input id="proProcessStartTime" name="proProcessStartTime">
						<button type="button" id="startBtn" class="btn btn-danger" disabled>시작</button>
					<th>작업량</th>
					<td><input id="proProcessQuantity" name="proProcessQuantity"></td>
					</td><th>작업종료시간</th>
					<td><input id="proProcessEndTime" name="proProcessEndTime">
						<button type="button" id="endBtn" class="btn btn-success" disabled>종료</button>
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
		//네비게이션 바 고정.
		$('#proNav').addClass('active');
		$('#subPages4').addClass('in');
		$('#subPages4').attr('aria-expanded','true');
		$('#subPages4').attr('style','');
		$('.proMnt').addClass('active');
		
		//1. 공정을 먼저 선택한다.
		$("#comProcessCode").on("change", function() {
			
			//시간, 작업량 초기화.
			$("#proProcessStartTime").val("");
			$("#proProcessEndTime").val("");
			$("#proProcessQuantity").val("");
			
			var comProcGubunCode = $("#comProcessCode option:selected").val();
			$.ajax({
				url:'${pageContext.request.contextPath}/ajax/pro/getProOrderDetailCode',
				type: 'GET',
				contentType: "application/json",
				dataType : "json",
				data:{"comProcessCode": comProcGubunCode},
				success: function(result){
					
					console.log(result);
					
					//기존 셀렉트박스 값 비우기
					$("select[name='proOrderDetailCode']").empty(); 
					$("select[name='proOrderDetailCode']").append('<option value="">--------선택--------</option>');
					//결과를 select box option으로 만들기.
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
			var erpProductName;
			
			var readParams = {
					'proOrderDetailCode' : proOrderDetailCode,
					'comProcessCode' : comProcessCode
			};
			//해당 지시에 필요한 자재정보를 가지고 온다.
			proOrderGrid.readData(1, readParams, true);
			
			$.ajax({
				url: '${pageContext.request.contextPath}/ajax/pro/readProdName',
				data: {'proOrderDetailCode' : proOrderDetailCode},
				dataType : 'json',
				success : function(result){
				
					console.log(result.erpProductName);
					$("#comProductName").val(result.erpProductName);
				}
			});
			
			//시작버튼 활성화
			$("#startBtn").prop("disabled",false);
			
		});
		
		
		//3. 작업을 시작한다.
		$("#startBtn").on("click",function(){
			//시작버튼 비활성화 & 종료버튼 활성화
			$(this).prop("disabled", true);
			$("#endBtn").prop("disabled",false);
			
			//시:분 형태로 현재 시간 값을 생성.
			var today = new Date();
			var h = today.getHours();
			var m = today.getMinutes();
			var proProcessStartTime = h +":"+m;
			$("#proProcessStartTime").val(proProcessStartTime);
			console.log(proProcessStartTime);
			
			//필요한 데이터 담기.
			var comProcessCode = $("#comProcessCode option:selected").val();
			var proOrderDetailCode = $("#proOrderDetailCode option:selected").val();
			var erpEmployeeId = $("#erpEmployeeId").val();
			var macLineNo = $("#macLineNo").val();
			var macCode = $("#macCode").val();
			
			$.ajax({
				url:'${pageContext.request.contextPath}/ajax/pro/startProProcess',
				type: 'POST',
				dataType : "json",
				data:{"comProcessCode": comProcessCode
						, "proOrderDetailCode": proOrderDetailCode
						, "proProcessStartTime": proProcessStartTime
						, "erpEmployeeId" : erpEmployeeId
						, "macLineNo" : macLineNo
						, "macCode" : macCode
				},
				success: function(result){
					
				}
			});
		});
		
		//4. 작업을 종료한다.
		$("#endBtn").on("click",function(){
			//종료버튼 비활성화.
			$(this).prop("disabled", true);
			//종료시간 시:분 형태로 저장.
			var today = new Date();
			var h = today.getHours();
			var m = today.getMinutes();
			var proProcessEndTime = h + ":" + m;
			$("#proProcessEndTime").val(proProcessEndTime);
			//전달 데이터			
			var comProcessCode = $("#comProcessCode option:selected").val();
			var proOrderDetailCode = $("#proOrderDetailCode option:selected").val();
			var proProcessQuantity = $("#proProcessQuantity").val();
			
			$.ajax({
				url: "${pageContext.request.contextPath}/ajax/pro/endProProcess",
				type: 'POST',
				data: {"comProcessCode" : comProcessCode,
					"proOrderDetailCode" : proOrderDetailCode,
					"proProcessEndTime" : proProcessEndTime,
					"proProcessQuantity" : proProcessQuantity},
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
			data : dataSource,
			scrollX : true,
			scrollY : true,
			bodyHeight :200, //테이블 높이
	        rowHeight: 30, //테이블 행 높이
			columns : [ {
				header : '자재코드',
				name : 'comMaterialCode',
				align : 'center'
			},{
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
