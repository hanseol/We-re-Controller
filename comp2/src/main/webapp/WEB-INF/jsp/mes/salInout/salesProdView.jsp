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

<div class="content-fluid">
	<div>
		<h2>입/출고목록조회</h2>
	</div>
</div>

<!-- 관리, 지시 탭 이동 -->
<div id="tabs">
   <ul class="nav nav-tabs" role="tablist">
     <li class=""><a onclick='location.href="salesProdForm.do"' aria-controls="tab1" role="tab" data-toggle="tab">관리</a></li>
     <li class="active"><a onclick='location.href="salesProdView.do"' aria-controls="tab2" role="tab" data-toggle="tab">조회</a></li>
   </ul>
</div>


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


<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-body">
			<div class="row">
				<div class="col-md-4">
					<form>
						일자
						<input type="date" id="salesDate" name="salesDate">
					</form>
				</div>
				<div class="col-md-4">
					<form>
						입/출고구분
						<input type="checkbox" id="inGubun" name="inGubun" value="1" checked="checked">입고
						<input type="checkbox" id="outGubun" name="outGubun" value="2">출고
					</form>
				</div>
				<div class="col-md-4">
					<form>
						제품코드
						<input type="text" id="text_productCode" name="text_productCode">
						<button type="button" id="btn_productCode" name="btn_productCode">돋</button>
						<input type="text" id="readonly_productCode" name="readonly_productCode" readonly="true">
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-heading">
			<div class="row">
				<div class="col-md-7">
					<p class="panel-subtitle">완제품 입출고 목록</p>
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
		
		//등록, 수정, 삭제할 때
		$(document).on("click", "button[id=appendRow]", function() {
			var rowData = [ {
				No : "",
				Title : "",
				Content : "",
				Date : ""
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
					url : '${pageContext.request.contextPath}/sal/inout/readSalesProduct',
					method : 'GET'
				},
				createData : {
					url : '${pageContext.request.contextPath}/ajax/insertBoard',
					method : 'POST'
				},
				deleteData : {
					url : '${pageContext.request.contextPath}/ajax/deleteBoard',
					method : 'DELETE'
				},
				updateData : {
					url : '${pageContext.request.contextPath}/ajax/updateBoard',
					method : 'PUT'
				}
			},
			contentType : "application/json"
		};

		const grid = new tui.Grid({
			el : document.getElementById('grid'),
			rowHeaders : [ 'checkbox' ],
			data : dataSource,
			columns : [ {
				header : '입/출고일자',
				name : 'salInoutDate',
				editor : {
					type : 'datePicker',
					options : {
						format : 'YYYY/MM/dd',
						language: 'ko'
					} 
				}
			},{
				header : '입/출고구분',
				name : 'salInoutGubun',
				editor : 'text'
			}, {
				header : '전표번호',
				name : 'salInoutStatement',
				editor : 'text'
			}, {
				header : '지시/거래처코드',
				name : 'salInoutCode',
				editor : 'text'
			}, {
				header : '제품코드',
				name : 'comProductCode',
				editor : 'text'
			}, {
				header : '제품명',
				name : 'comProductName',
				editor : 'text'
			}, {
				header : '수량',
				name : 'salInoutQuantity',
				editor : 'text'
			}, {
				header : '완제품 LOT_NO',
				name : 'proProcessLotNo',
				editor : 'text'
			}]
		}); 
	
	grid.on('response', ev => {
		  const {response} = ev.xhr;
		  const responseObj = JSON.parse(response);

		  console.log('result : ', responseObj.result);
		  console.log('data : ', responseObj.data);
		});
	
}); //end of document ready
</script>