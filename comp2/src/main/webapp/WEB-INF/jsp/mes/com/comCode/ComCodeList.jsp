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
		<h2>페이지 명</h2>
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

						$(document).on("click", "button[id=appendRow]",
								function() {
									var rowData = [ {
										//여기 수정 해야함.
										공통코드 : "",
										공통코드명 : "",
										공통코드순서 : "",
										공통코드사용여부 : ""
									} ];
									grid.appendRow(rowData, {
										at : grid.getRowCount(),
										focus : true
									});
									grid.enable();
								});

						$(document).on("click", "button[id=insertRow]",
								function() {
									grid.finishEditing('rowKey', 'columnName');
									grid.request('createData');
								});

						$(document).on("click", "button[id=deleteRow]",
								function() {
									grid.removeCheckedRows(false);
									grid.request('deleteData');
								});

						$(document).on("click", "button[id=updateRow]",
								function() {
									grid.finishEditing('rowKey', 'columnName');
									grid.request('updateData');
								});

						$(document).on("click", "button[id=findRow]",
								function() {
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
									url : '${pageContext.request.contextPath}/comCode/ComCodeList',
									method : 'GET'
								},
								createData : {
									url : '${pageContext.request.contextPath}/ajax/insertComeCode',
									method : 'POST'
								},
								deleteData : {
									url : '${pageContext.request.contextPath}/ajax/deleteComeCode',
									method : 'POST'
								},
								updateData : {
									url : '${pageContext.request.contextPath}/ajax/updateComeCode',
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
								header : '공통코드',
								name : 'comCodeId',
								editor : 'text'
							}, {
								header : '공통코드명',
								name : 'comCodeName',
								editor : 'text'
							}, {
								header : '공통코드순서',
								name : 'comCodeDesc',
								editor : 'text'
							}, {
								header : '공통코드사용여부',
								name : 'comCodeDesc',
								editor : 'text'
							} ]
						});
					});
</script>

