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
		<h2>생산 계획 조회</h2>
	</div>
</div>

<!-- 관리, 조회 탭 이동 -->
<div id="tabs">
   <ul class="nav nav-tabs" role="tablist">
     <li class=""><a onclick='location.href="prodPlanForm.do"' aria-controls="tab1" role="tab" data-toggle="tab">관리</a></li>
     <li class="active"><a onclick='location.href="ProdPlanView.do"' aria-controls="tab2" role="tab" data-toggle="tab">조회</a></li>
   </ul>
</div>


<!-- 마스터테이블의 CRUD 버튼 -->
<div class="content-fluid">
	<div>
		<div class="my-panel">
			<button type="button" class="btn btn-success">조회</button>
			<button type="button" class="btn btn-danger">새자료</button>
		</div>
	</div>
</div>

<!-- 마스터 테이블 -->
<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-body">
			<div class="row">
				<div class="col-md-6">
					<form action="">
						* 계획 일자   &nbsp;&nbsp;&nbsp;<input type="date" id="startProPlanDate" name="startProPlanDate"> 
							~ <input type="date" id="endProPlanDate" name="endProPlanDate"> <br/><br/>
						* 제품 코드   &nbsp;&nbsp;&nbsp;<input type="text" id="erpProductCode" name="erpProductCode"> <br/><br/>
						* 고객사코드 <input type="text" id="erpCustomerCode" name="erpCustomerCode">
						
					</form>
				</div>
				<div class="col-md-6">
					<form action="">
					* 미생산계획 검색 <br/><br/>
					납기일자 &nbsp;&nbsp;&nbsp; <input type="date" id="startNotWorkDate" name="startNotWorkDate">
						~ <input type="date" id="endNotWorkDate" name="endNotWorkDate">
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
					<p class="panel-subtitle">생산계획조회</p>
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

			
		const dataSource = {
			api : {
				readData : {
					url : '${pageContext.request.contextPath}/proPlan/ProdPlanView',
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
				header : '계획일자',
				name : 'proPlanDate',
			}, {
				header : '고객사코드',
				name : 'erpCustomerCode',
			}, {
				header : '계획코드',
				name : 'proPlanCode',
			}, {
				header : '제품코드',
				name : 'erpProductCode',
			}, {
				header : '제품명',
				name : 'erpProductName',
			}, {
				header : '주문코드',
				name : 'erpOrderCode',
			}, {
				header : '납기일자',
				name : 'erpProductDeadline',
			}, {
				header : '주문량',
				name : 'erpOrderQty',
			}, {
				header : '작업계획량',
				name : 'proPlanQty',
			}, {
				header : '작업착수일',
				name : 'proWorkDate',
			} , {
				header : '작업순서',
				name : 'proPlanSeq',
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






