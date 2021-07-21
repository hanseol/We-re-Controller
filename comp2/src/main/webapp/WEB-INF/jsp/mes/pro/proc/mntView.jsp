<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
 #proProcessStartTime, #proProcessEndTime {
 	display: inline;
 	width: 35%;
 	
 }
</style>


<!-- 타이틀 -->
<div class="content-fluid">
	<div>
		<h2>생산관리</h2>
	</div>
</div>

	<!-- 정보 (테이블 출력) -->
<div class="panel">
	<div class="panel-body">
		<form name="frm" id="frm" action="${pageContext.request.contextPath}/pro/proc/printProcessMove.do" method="POST">
		<table class="table table-bordered" id="process">
			<thead>
			</thead>
			<tbody id="tbody">
				<tr>
					<th>공정명</th>
					<td><select class="form-control" name="comProcessCode" id="comProcessCode">
							<option value="">--------선택--------</option>
							<c:forEach var="procg" items="${procgs }">
							<option value="${procg.comProcessCode}">${procg.comProcessName}</option>
							</c:forEach>
						</select></td>
					<th>지시번호 </th> 
				
					<td>
						<select class="form-control" name="proOrderDetailCode" id="proOrderDetailCode">
							<option value="">--------선택--------</option>
						</select> 
					</td>
					<th>제품명</th>
					<td><input class="form-control" id="comProductName" name="comProductName"></td>
				</tr>
				<tr>
					<th>라인번호</th>
					<td><input class="form-control" id="macLineNo" name="macLineNo"></td>
					<th>설비코드</th>
					<td>
						<select class="form-control" name="macCode" id="macCode">
							<option value="">--------선택--------</option>
						</select>
					<th>작업자</th>
					<td><input class="form-control" id="erpEmployeeId" name="erpEmployeeId"></td>
				</tr>
				<tr>
					<th>작업량</th>
	               <td><input class="form-control" id="proProcessQuantity" name="proProcessQuantity"></td>
	               <th>작업시간</th>
	               <td colspan="3">
	                  <input class="form-control" type="text" id="proProcessStartTime" name="proProcessStartTime">
	                  <button style="margin-right: 70px" type="button" id="startBtn" class="btn btn-danger" disabled>시작</button> 
	                  <input class="form-control" type="text" id="proProcessEndTime" name="proProcessEndTime">
	                  <button type="button" id="endBtn" class="btn btn-success" disabled>종료</button>
	               </td>
	               
           		 </tr>
			</tbody>
		</table>
		<button type="submit">공정이동표발행</button>
	</form>
	</div>
</div>
<!-- END 정보 -->

<div class="panel">
	<div class="panel-body">
	* 자재 LOT
		<div id="proOrderGrid"></div>
	</div>
</div>

<script>
	$(document).ready(function(){
		//네비게이션 바 고정.
		$('#n7000000').addClass('active');
		$('#subPages7000000').addClass('in');
		$('#subPages7000000').attr('aria-expanded','true');
		$('#subPages7000000').attr('style','');
		$('.7030000').addClass('active');
		
		//1. 공정을 먼저 선택한다.
		$("#comProcessCode").on("change", function() {
			
			//시간, 작업량 초기화.
			$("#proProcessStartTime").val("");
			$("#proProcessEndTime").val("");
			$("#proProcessQuantity").val("");
			
			var comProcGubunCode = $("#comProcessCode option:selected").val();
			// 생산지시코드 리스트 가져오는 아작스
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
			
			// 공정별 설비 리스트 가져오는 아작스
			$.ajax({
				url:'${pageContext.request.contextPath}/ajax/pro/getMacCode',
				type: 'GET',
				contentType: "application/json",
				dataType : "json",
				data:{"comProcessCode": comProcGubunCode},
				success: function(result){
					
					console.log(result);
					
					//기존 셀렉트박스 값 비우기
					$("select[name='macCode']").empty(); 
					$("select[name='macCode']").append('<option value="">--------선택--------</option>');
					//결과를 select box option으로 만들기.
					var data = result.list;
					$.each(data,function(index,item){
						var rdata = "<option value='"+item+"'>"+ item + "</option>";
						$("select[name='macCode']").append(rdata);
					});
				}
			});
			
			
		});
		
		//2-1) 해당공정에서 작업해야 할 지시 코드를 선택한다.
		$("#proOrderDetailCode").on("change", function() {
			var proOrderDetailCode = $("#proOrderDetailCode option:selected").val();
			var comProcessCode = $("#comProcessCode option:selected").val();
			var proOrderQty = $("#proOrderQty option:selected").val();
			var erpProductName;

			var readParams = {
					'proOrderDetailCode' : proOrderDetailCode,
					'comProcessCode' : comProcessCode,
					'proOrderQty' : proOrderQty
			};
			//해당 지시에 필요한 자재정보를 가지고 온다.
			proOrderGrid.readData(1, readParams, true);
			
			$.ajax({
				url: '${pageContext.request.contextPath}/ajax/pro/readProdName',
				data: {'proOrderDetailCode' : proOrderDetailCode},
				dataType : 'json',
				success : function(result){
				
					$("#comProductName").val(result.list[0].erpProductName);
					$('#proProcessQuantity').attr('placeholder', '주문량: ' + result.list[0].proOrderQty );
				}
			});
			//시작버튼 활성화
			$("#startBtn").prop("disabled",false);
			
		});
	
		 //2-2) 해당 공정에서 사용하는 설비코드를 선택하여 라인번호 가져오기
		 $("#macCode").on("change", function() {
			 var macCode = $("#macCode option:selected").val();
			 
			 $.ajax({
				 url : '${pageContext.request.contextPath}/ajax/pro/readLineNo',
				 data : { 'macCode' : macCode },
				 dataType : 'json',
				 success : function(result){
					 $("#macLineNo").val(result.macLineNo);
				 }
			 })
		 });
		 
		 // 2-3) 작업자 가져오기
		 $("#erpEmployeeId").val("${loginVO.id}");
		
		
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
			var comProductName = $("#comProductName").val();
			
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
						, "comProductName" : comProductName
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
