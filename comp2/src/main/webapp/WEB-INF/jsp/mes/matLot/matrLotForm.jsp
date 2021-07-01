<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

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
		<h2>자재입출고관리</h2>
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
				<div class="col-md-6">
					<form>
						* 계획일자 <input type="date" id="proPlanDate" name="proPlanDate">
					</form>
				</div>
				<div class="col-md-6">* 미생산계획</div>
			</div>
		</div>
	</div>
</div>

<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-heading">
			<div class="row">
				<div class="col-md-7">
					<p class="panel-subtitle">Grid 테스트</p>
					<input type="text" id="no" name="no">
				</div>
				<div class="col-md-5" align="right">
					<button type="button" id="findRow">조회</button>
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
				//여기 수정 해야함.
				자재코드 : "",
				자재명 : "",
				규격 : "",
				입고량 : "",
				출고량 : "",
				현재고 : ""
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
			grid.removeCheckedRows(false);
			grid.request('deleteData');
		});
		
		$(document).on("click", "button[id=updateRow]", function() {
			grid.finishEditing('rowKey','columnName');
			grid.request('updateData');
		});
		
		//검색데이터 전송
		$(document).on("click", "button[id=findRow]", function() {
			//데이터를 변수에 담아서 parameter로 만들기.
			var no = $("#no").val();
			console.log(no);
			var readParams = {
					'searchKeyword' : no
				};
			grid.readData(1, readParams, true);
		});
		
		const dataSource = {
			api : {
				readData : {
					url : '${pageContext.request.contextPath}/mat/inout/readMatInout',
					method : 'GET'
				},
				createData : {
					url : '${pageContext.request.contextPath}/mat/inout/insertMatInout',
					method : 'POST'
				},
				deleteData : {
					url : '${pageContext.request.contextPath}/mat/inout/deleteMatInout',
					method : 'POST'
				},
				updateData : {
					url : '${pageContext.request.contextPath}/mat/inout/updateMatInout',
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
				header : '발주일자',
				name : 'erpMaterialOrderDate',
				editor : {
					type : 'datePicker',
					options : {
						format : 'YYYY/MM/dd',
						language: 'ko'
					} 
				}
			},{
				header : '발주번호',
				name : 'erpMaterialOrderCode',
				editor : 'text'
			}, {
				header : '자재코드',
				name : 'comMaterialCode',
				editor : 'text'
			}, {
				header : '자재명',
				name : 'comMaterialName',
				editor : 'text'
			}, {
				header : '입고일자',
				name : 'matInoutDate',
				editor : {
					type : 'datePicker',
					options : {
						format : 'YYYY/MM/dd',
						language: 'ko'
					} 
				}
			}, {
				header : '발주량',
				name : 'erpMaterialOrderQty',
				editor : 'text'
			}, {
				header : '거래처명',
				name : 'erpVendorCode',
				editor : 'text'
			}, {
				header : '자재LOT_NO',
				name : 'matLotNo',
				editor : 'text'
			}, {
				header : '입고량',
				name : 'matInoutQuantity',
				editor : 'text'
			}
			]
		});
	
/* 	grid.on('response', ev => {
		  const {response} = ev.xhr;
		  const responseObj = JSON.parse(response);

		  console.log('result : ', responseObj.result);
		  console.log('data : ', responseObj.data);
		});
	
	grid.on('check', (ev) => {
		  alert(`check: ${ev.rowKey}`);
	}); */
	
}); //end of document ready
</script>