<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>


th {
	background-color: #f1f7fe;
	width: 100px;
}

td{
	text-align: center;
}

.form-control{
		display: inline;
		font-size:17px; 
		width: 100%;
}

#proProcessStartTime, #proProcessEndTime {
 	display: inline;
 	width: 50%;
}

#chart {
	display : none;
}
</style>

<!-- 키오스크 화면  -->
<div class="panel">
	<div>
		<h2>&nbsp;&nbsp;&nbsp;생산 관리</h2>
	</div>
	<div class="panel-body">
		<div class="row">
			<div class="col-md-5">
				<table class="table table-bordered" id="process">
				<thead>
				</thead>
				<tbody id="tbody">
					<tr>
						<th>공정명</th>
						<td colspan="3"><select class="form-control" name="comProcessCode" id="comProcessCode">
								<option value="">선택</option>
								<c:forEach var="procg" items="${procgs }">
								<option value="${procg.comProcessCode}">${procg.comProcessName}</option>
								</c:forEach>
							</select></td>
					</tr>
					<tr>
						<th>지시번호 </th> 
						<td colspan="3">
							<select class="form-control" name="proOrderDetailCode" id="proOrderDetailCode">
								<option value="">선택</option>
							</select> 
						</td>
					</tr>
					<tr>
						<th>제품명</th>
						<td colspan="3"><input class="form-control" id="erpProductName" name="erpProductName"></td>
					</tr>
					<tr>
						<th>설비코드</th>
						<td>
							<select class="form-control" name="macCode" id="macCode">
								<option value="">선택</option>
							</select>
						</td>
						<th>라인번호</th>
						<td><input class="form-control" id="macLineNo" name="macLineNo"></td>
					</tr>
					<tr>
						<th>작업자</th>
						<td><input class="form-control" id="erpEmployeeId" name="erpEmployeeId"></td>
						<td colspan="2"><input class="form-control" type="text" id="proProcessStartTime" name="proProcessStartTime">
		                	 <button type="button" id="startBtn" class="btn btn-info" disabled>시작</button> 
		               	</td>
					</tr>
					<tr>
						<th>작업량</th>
		               <td><input class="form-control" id="proProcessQuantity" name="proProcessQuantity"></td>
		               <td colspan="2">
		                  <input class="form-control" type="text" id="proProcessEndTime" name="proProcessEndTime">
		                  <button type="button" id="endBtn" class="btn btn-info" disabled>종료</button>
		               </td>
		            </tr>
		             <tr>
		               <td colspan="4">
		                  <button type="button" id="processMoving" class="btn btn-danger">공정 이동표 발행</button>
		               </td>
	           		 </tr>
				</tbody>
				</table>
				<div class="panel-body" id="chart">
					<div id="system-load" class="easy-pie-chart" data-percent="0">
						<span class="percent">0</span>
					</div>
					<ul class="list-unstyled list-justify">
						<li>지시량: <span id="qty"></span></li>
						<li>달성률: <span id="goal"></span></li>
					</ul>
				</div>
			</div>
			<div class="col-md-7">
				<div class="panel">
					<div class="panel-body">
					* 자재 LOT
					<div id="proOrderGrid"></div>
				</div>
			</div>
			</div>
		</div>
	</div>
</div>
<!-- END 정보 -->



<script>
let realPct = 0;

	$(document).ready(function(){
		let erpOrderCode; //주문코드
		let erpCustomerName; //고객사명
		let proProcessLotNo; //완제품lot
		let erpProductName; //제품명
		let proProcessQuantity; //주문량
		let proProcessEndTime; //종료시간
		let comProcessCode; //공정코드
		let qty; //지시량
		
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
			
			//실시간 차트 숨김.
			$("#chart").css("display","none");
			
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
					$("select[name='proOrderDetailCode']").append('<option value="">선택</option>');
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
					$("select[name='macCode']").append('<option value="">선택</option>');
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
				
					$("#erpProductName").val(result.list[0].erpProductName);
					$('#proProcessQuantity').attr('placeholder', '주문량: ' + result.list[0].proOrderQty );
					qty = result.list[0].proOrderQty;
					//공정이동표 발행 시 필요한 데이터.
					erpOrderCode=result.list[0].erpOrderCode;
					erpCustomerName =result.list[0].erpCustomerName;
					proProcessLotNo =result.list[0].proProcessLotNo;
					erpProductName =result.list[0].erpProductName;
					
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
			var erpProductName = $("#erpProductName").val();
			
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
						, "erpProductName" : erpProductName
				},
				success: function(result){
					
				}
			});
			
			$("#qty").html(qty+"개")//지시량
			realPct = 0; // 초기화.
			$("#chart").css("display","block"); //실시간 차트 보이기.
			// real-time pie chart
			var sysLoad = $('#system-load').easyPieChart({
				size: 130,
				barColor: function(percent) {
					return "rgb(" + Math.round(200 * percent / 100) + ", " + Math.round(200 * (1.1 - percent / 100)) + ", 0)";
				},
				trackColor: 'rgba(245, 245, 245, 0.8)',
				scaleColor: false,
				lineWidth: 5,
				lineCap: "square",
				animate: 800
			});

			var updateInterval = 500; // in milliseconds
			
			setInterval(function() {
				
				var currentVal;
				if(realPct<100){
					currentVal = getCurrent(realPct, 100);
					$("#goal").html(currentVal+"%");
					sysLoad.data('easyPieChart').update(currentVal);
					sysLoad.find('.percent').text(currentVal);
				}else{
					return;
				}
				
			}, updateInterval);

			function getCurrent(pct, goal) {
				if(pct<goal){
					realPct = pct+10;
				}
				
				return realPct;
			}

		});//end 3.
	
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
		
		//공정이동표를 발행한다.
		//공정이동표 발행 버튼 클릭 시.
		$("#processMoving").on("click", function(){
			
			proProcessQuantity = $("#proProcessQuantity").val(); //주문량
			proProcessEndTime = $("#proProcessEndTime").val(); //종료시간
			comProcessCode = $("#comProcessCode option:selected").val();
			var proOrderDetailCode = $("#proOrderDetailCode").val();
			var macCode = $("#macCode").val();
			
			var str = '?erpCustomerName='+erpCustomerName
					+"&proProcessLotNo="+proProcessLotNo
					+"&erpOrderCode="+erpOrderCode
					+"&proProcessQuantity="+proProcessQuantity
					+"&proProcessEndTime="+proProcessEndTime
					+"&erpProductName="+erpProductName
					+"&comProcessCode="+comProcessCode
					+"&proOrderDetailCode="+proOrderDetailCode
					+"&macCode="+macCode;
			
			window.open('${pageContext.request.contextPath}/pro/proc/printProcessMove.do'+str,'공정이동표 발행','height=600,width=900,scrollbars=yes,titlebar=yes,location=no');
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
			bodyHeight :400, //테이블 높이
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
