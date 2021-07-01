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

.modal{
	-webkit-border-radius :0px;
	border-radius:0px;
	overflow: visible;
	text-align: center;
	max-width: 900px;
	width: 900px;
	height: 600px;
	max-height: 600px;
}

.blocker{
	z-index: 1200;
}
</style>

<!-- 타이틀 -->
<div class="content-fluid">
	<div>
		<h2>생산 계획 관리</h2>
	</div>
</div>


<!--  모달창띄우기
<p>
<a href="testModal.do" rel="modal:open" id="getData">
<button type="button" class="btn btn-success" id="showModal">조회</button>
</a>
</p>
 -->

<!-- 관리, 조회 탭 이동 -->
<div id="tabs">
   <ul class="nav nav-tabs" role="tablist">
     <li class="active"><a onclick='location.href="prodPlanForm.do"' aria-controls="tab1" role="tab" data-toggle="tab">관리</a></li>
     <li class=""><a onclick='location.href="ProdPlanView.do"' aria-controls="tab2" role="tab" data-toggle="tab">조회</a></li>
   </ul>
</div>




<!-- 마스터테이블의 CRUD 버튼 -->
<div class="content-fluid">
	<div>
		<div class="my-panel">
			<button type="button" class="btn btn-success">조회</button>
			<button type="button" class="btn btn-danger">새자료</button>
			<button type="button" class="btn btn-warning" id="insertRow">추가저장</button>
			<button type="button" class="btn btn-info" id="updateRow">수정저장</button>
		</div>
	</div>
</div>

<!-- 마스터 테이블 -->
<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-body">
			<div class="row">
				<div class="col-md-6">
					<form>
						* 계획일자 &nbsp;&nbsp;<input type="date" id="proPlanDate" name="proPlanDate"><br/><br/>
						* 계획이름 &nbsp;&nbsp;<input type="text" id="proPlanName" name="proPlanName">
					</form>
				</div>
				<div class="col-md-6">
					* 미생산계획 검색 <br/><br/>
						납기일자 &nbsp;&nbsp;&nbsp; <input type="date" id="startNotWorkDate" name="startNotWorkDate">
						~ <input type="date" id="endNotWorkDate" name="endNotWorkDate">
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
					<p class="panel-subtitle">Grid 테스트</p>
				</div>
				<div class="col-md-5" align="right">
					<button type="button">조회</button>
					<button type="button" id="appendRow">추가</button>
					<button type="button" id="deleteRow">삭제</button>
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

		$(document).on("click", "button[id=appendRow]", function() {
			var rowData = [ {
				erpCustomerCode : "",
				erpProductCode : "",
				erpProductName : "",
				erpOrderCode : "",
				erpProductDeadline : "",
				erpOrderQty : "" ,
				proPlanQty : "" ,
				proWorkDate : "" ,
				proPlanSeq : "" 
			} ];
			grid.appendRow(rowData, {
				at : grid.getRowCount(),
				focus : true
			});
			grid.enable();
		});
		
		$(document).on("click", "button[id=insertRow]", function() {
			grid.finishEditing('rowKey','columnName');
			grid.request('createData');
		});
		
		$(document).on("click", "button[id=deleteRow]", function() {
			grid.removeCheckedRows(true);
			grid.request('deleteData');
		});
		
		$(document).on("click", "button[id=updateRow]", function() {
			grid.finishEditing('rowKey','columnName');
			grid.request('updateData');
		});
		
		const dataSource = {
			api : {
				readData : {
					url : '${pageContext.request.contextPath}/proPlan/ProdPlanView',
					method : 'GET'
				},  
				modifyData: { url: '${pageContext.request.contextPath}/ajax/modifyBoard', method: 'PUT' }
			},
			contentType : "application/json"
		};

		const grid = new tui.Grid({
			el : document.getElementById('grid'),
			rowHeaders : [ 'checkbox' ],
			data : dataSource,
			columns : [ {
				header : '제품코드',
				name : 'erpProductCode',
				editor : 'text'
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
				editor : {
					type : 'datePicker',
					options : {
						format : 'YYYY/MM/dd',
						language: 'ko'
					} 
				}
			} , {
				header : '작업순서',
				name : 'proPlanSeq',
				editor : 'text'
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






