<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css">

<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
<style>
.my-panel {
	text-align: right;
	border-top: 1px solid gray;
	padding: 10px;
	margin-bottom: 10px;
	background-color: white;
}
</style>

<!-- 타이틀 -->
<div class="content-fluid">
	<div>
		<h2>생산 지시 조회</h2>
	</div>
</div>

<!-- 관리, 조회 탭 이동 -->
<div id="tabs">
   <ul class="nav nav-tabs" role="tablist">
     <li class=""><a onclick='location.href="prodForm.do"' aria-controls="tab1" role="tab" data-toggle="tab">관리</a></li>
     <li class="active"><a onclick='location.href="prodView.do"' aria-controls="tab2" role="tab" data-toggle="tab">조회</a></li>
   </ul>
</div>



<!-- 마스터테이블의 CRUD 버튼 -->
<div class="content-fluid">
	<div>
		<div class="my-panel">
			<button type="button" class="btn btn-success" id="findRow">조회</button>
			<button type="button" class="btn btn-danger">새자료</button>
		</div>
	</div>
</div>

<!-- 마스터 테이블 -->
<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-body">
			<div class="row">
				<div class="col-md-12">
					<form action="">
						* 일자   &nbsp;&nbsp;&nbsp;<input type="date" id="startDate" name="startDate"> 
							~ <input type="date" id="endDate" name="endDate"> 
							<input type="radio" id="gubun1" name="gubun" value="1" checked> 작업일자
							<input type="radio" id="gubun2" name="gubun" value="2" > 납기일자
							<br/><br/>
						* 제품 코드   &nbsp;&nbsp;&nbsp;<input type="text" id="erpProductCode" name="erpProductCode"> <br/><br/>
						* 고객사 코드 <input type="text" id="erpCustomerCode" name="erpCustomerCode">
						
					</form>
				</div>
			</div>
		</div>
	</div>
</div>


<!-- 디테일 테이블 -->
<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-heading">
			<div class="row">
				<div class="col-md-7">
					<p class="panel-subtitle">생산지시조회</p>
				</div>
			</div>
			<div class="panel-body">
				<div id="grid"></div>
			</div>
		</div>
	</div>
</div>
<script>
	$(document).ready(function() {
		
		//M 조회 버튼	
		$(document).on("click", "button[id=findRow]",
		      function() {
		 	   var gubun = $("input[name=gubun]:checked").val();
		 	   console.log(gubun);
		         var startDate = $("#startDate").val();
		         var endDate = $("#endDate").val();
		         var erpProductCode = $("#erpProductCode").val();
		         var erpCustomerCode = $("#erpCustomerCode").val();
		         var readParams = {
		      	  'searchCondition' : gubun,
		            'startDate' : startDate,
		            'endDate' : endDate,
		            'erpProductCode' : erpProductCode,
		            'erpCustomerCode' : erpCustomerCode
		         };
		         grid.readData(1, readParams, true);
		      });

		
		//dataSource	
		const dataSource = {
			api : {
				readData : {
					url : '${pageContext.request.contextPath}/proOrder/prodView',
					method : 'GET'
				}
			},
			contentType : "application/json"
		};

		const grid = new tui.Grid({
			el : document.getElementById('grid'),
			rowHeaders : [ 'checkbox' ],
			data : dataSource,
			columns : [ {
				header : '작업일자',
				name : 'proWorkDate'
			}, {
				header : '생산지시코드',
				name : 'erpOrderCode'
			}, {
				header : '고객사코드',
				name : 'erpCustomerCode'
			},{
				header : '제품코드',
				name : 'erpProductCode'
			}, {
				header : '제품명',
				name : 'erpProductName'
			}, {
				header : '주문번호',
				name : 'erpOrderCode'
			}, {
				header : '납기일자',
				name : 'erpProductDeadline'
			}, {
				header : '주문량',
				name : 'erpOrderQty'
			},{
				header : '지시량',
				name : 'proOrderQty'
			},{
				header : '작업순서',
				name : 'proOrderSeq'
			} ]
		});
	
	grid.on('response', ev => {
		  const {response} = ev.xhr;
		  const responseObj = JSON.parse(response);

		  console.log('result : ', responseObj.result);
		  console.log('data : ', responseObj.data);
		});
	
	grid.on('check', (ev) => {
		  alert(`check: ${ev.rowKey}`);
	});
	
}); //end of document ready
</script>



