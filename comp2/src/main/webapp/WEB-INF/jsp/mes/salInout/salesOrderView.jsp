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
		<h2>주문관리조회</h2>
	</div>
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
					<form id="date_gubun">
						일자구분
						<input type="radio" value="1" id="order_date" name="order_date" checked="checked">주문일자
						<input type="radio" value="2" id="deadline" name="deadline"> 납기일자
					</form>
				</div>
				<div class="col-md-4">
					<form id="date">
						일자
						<input type="date" id="orderDate" name="orderDate">
					</form>
				</div>
				<div class="col-md-4">
					<form id="productCode">
						제품코드
						<input type="text" id="text_productCode" name="text_productCode">
						<button type="button" id="btn_productCode" name="btn_productCode">M</button>
						<input type="text" id="readonly_productCode" name="readonly_productCode" readonly="true">
					</form>
				</div>
				<div class="col-md-4">
					<form id="customerCode">
						업체코드
						<input type="text" id="text_customerCode" name="text_customerCode">
						<button type="button" id="btn_customerCode" name="btn_customerCode">M</button>
						<input type="text" id="readonly_customerCode" name="readonly_customerCode" readonly="true">
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
					<p class="panel-subtitle">전체 주문 목록</p>
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
		/* $(document).on("click", "button[id=appendRow]", function() {
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
		}); */
		
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
					url : '${pageContext.request.contextPath}/sal/inout/readSalesOrder',
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
			columns : [{
				header : '주문코드',
				name : 'erpOrderCode',
				editor : 'text'
			}, {
				header : '업체코드',
				name : 'erpCustomerCode',
				editor : 'text'
			}, {
				header : '제품코드',
				name : 'erpProductCode',
				editor : 'text'
			}, {
				header : '제품명',
				name : 'erpProductName',
				editor : 'text'
			}, {
				header : '주문량',
				name : 'erpOrderQty',
				editor : 'text'
			}, {
				header : '개당단가',
				name : 'erpProductUnitPrice',
				editor : 'text'
			}, {
				header : '주문일자',
				name : 'erpProductOrderDate',
				editor : {
					type : 'datePicker',
					options : {
						format : 'YYYY/MM/dd',
						language: 'ko'
					} 
				}
			}, {
				header : '납기일자',
				name : 'erpProductDeadline',
				editor : {
					type : 'datePicker',
					options : {
						format : 'YYYY/MM/dd',
						language: 'ko'
					} 
				}
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