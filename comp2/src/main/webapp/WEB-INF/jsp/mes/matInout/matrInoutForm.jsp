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

.modal {
	-webkit-border-radius: 0px;
	border-radius: 0px;
	overflow: visible;
	text-align: center;
	max-width: 900px;
	width: 900px;
}

.blocker {
	z-index: 1200;
}
</style>

<div class="content-fluid">
	<div>
		<h2>자재입출고관리</h2>
	</div>
</div>

<div class="content-fluid">
	<div>
		<div>
			<form>
				일자 <input type="date" id="matInoutDate" name="matInoutDate"><br />
				입고 <input type="checkbox" id="materialIn" name="materialIn"
					value="1"> 출고 <input type="checkbox" id="materialOut"
					name="materialOut" value="2">
				<div class="my-panel">
					<button type="button" class="btn btn-success" id="findRow">조회</button>
					<button type="button" class="btn btn-danger" id="reset">새자료</button>
					<button type="button" class="btn btn-info" id="modifyRow">저장</button>
				</div>
			</form>
		</div>
	</div>
</div>

<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-heading">
			<div class="row">
				<div class="col-md-7">
					업체코드
					<input type="text" id="erpVendorCode" name="erpVendorCode">
					<a href="${pageContext.request.contextPath}/mes/matInout/searchVendorCode.do" rel="modal:open" id="getData"><i class="fa fa-search"></i></a>
				</div>
				<div class="col-md-5" align="right">
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
	$(document)
			.ready(
					function() {
						$(document).on("click", "button[id=appendRow]",
								function() {
									var rowData = [ {
										//여기 수정 해야함.
										일자 : "",
										거래처코드 : "",
										자재코드 : "",
										자재LOT_NO : "",
										자재명 : "",
										규격 : "",
										관리단위 : "",
										입출고 : "",
										수량 : "",
										단가 : "",
										금액 : "",
										재고량 : ""
									} ];
									grid.appendRow(rowData, {
										at : grid.getRowCount(),
										focus : true
									});
									grid.enable();
								});

						$(document).on("click", "button[id=modifyRow]",
								function() {
									grid.finishEditing('rowKey', 'columnName');
									grid.request('modifyData');
								});
						$(document).on("click", "button[id=deleteRow]",
								function() {
									grid.removeCheckedRows(false);
								});

						//검색데이터 전송
						$(document)
								.on(
										"click",
										"button[id=findRow]",
										function() {
											//데이터를 변수에 담아서 parameter로 만들기.

											var matInoutDate = $(
													"#matInoutDate").val();
											var erpVendorCode = $(
													"#erpVendorCode").val();
											var matInoutGubun = $(
													"#matInoutGubun").val();

											var readParams = {
												'matInoutDate' : matInoutDate,
												'erpVendorCode' : erpVendorCode,
												'matInoutGubun' : matInoutGubun
											};
											grid.readData(1, readParams, true);
										});

						const dataSource = {
							api : {
								readData : {
									url : '${pageContext.request.contextPath}/mat/inout/readMatInout',
									method : 'GET'
								},
								modifyData : {
									url : '${pageContext.request.contextPath}/ajax/modifyMatInout',
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
								header : '일자',
								name : 'matInoutDate',
								editor : {
									type : 'datePicker',
									options : {
										format : 'YYYY/MM/dd',
										language : 'ko'
									}
								}
							}, {
								header : '거래처코드',
								name : 'erpVendorCode',
								editor : 'text'
							}, {
								header : '자재코드',
								name : 'comMaterialCode',
								editor : 'text'
							}, {
								header : '자재LOT_NO',
								name : 'matLotNo',
								editor : 'text'
							}, {
								header : '자재명',
								name : 'comMaterialName',
								editor : 'text'
							}, {
								header : '규격',
								name : 'comMaterialSize',
								editor : 'text'
							}, {
								header : '관리단위',
								name : 'comMaterialUnit',
								editor : 'text'
							}, {
								header : '입출고',
								name : 'matInoutGubun',
								editor : 'text'
							}, {
								header : '수량',
								name : 'matInoutQuantity',
								editor : 'text'
							}, {
								header : '단가',
								name : 'matInoutUnitPrice',
								editor : 'text'
							}, {
								header : '금액',
								name : 'matInoutPrice',
								editor : 'text'
							}, {
								header : '재고량',
								name : 'materialStock',
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