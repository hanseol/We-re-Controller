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
	height: 600px;
	max-height: 600px;
}

.blocker {
	z-index: 1200;
}
</style>

<div class="content-fluid">
	<div>
		<h2>공통자료 관리</h2>
	</div>
</div>

<div class="search-area search-area-border grid-option-area">
	<!--  -->
	<div class="content-fluid">
		<div>
			<div class="my-panel">
				<a href="comCodeModal.do" rel="modal:open" id="getData">
					<button type="button" class="btn btn-success" id="showModal">조회</button>
				</a>
				<button type="button" class="btn btn-danger">새자료</button>
				<button type="button" class="btn btn-info" id="modifyRow">저장</button>
			</div>
		</div>
	</div>
</div>

<!--  -->

<div>
	<div>
		<h2>코드</h2>
	</div>

</div>


<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-heading">
			<div class="row">
				<div class="col-md-7"></div>
				<div class="col-md-5" align="right">
					<button type="button" id=appendRow>추가</button>
					<button type="button" id="deleteRow">삭제</button>
				</div>
			</div>
			<div class="panel-body">
				<div class="row">
					<div>
						<label for="selCodeIdNm">코드ID명</label> <input type="text"
							id="getComCodeID"> <input type="button"
							onClick="comCodeId.value" value="Click" />
						<button>검색</button>
					</div>
					<!-- 마스터데이터 호출 -->
					<div class="col-md-4" id="grid"></div>
					<!-- Detail 표현 -->
					<div class="col-md-8" id="gridDetail"></div>
				</div>
			</div>
		</div>
	</div>
</div>


<!-- 마스터데이터 -->
<script>
	$(document)
			.ready(
					function() {
						
						const dataSource = {
							api : {
								readData : {
									url : '${pageContext.request.contextPath}/comCode/ComCodeList',
									method : 'GET'
								},
							},
							contentType : "application/json"
						};
						
						const grid = new tui.Grid({
							el : document.getElementById('grid'),
							data : dataSource,
							columns : [ {
								header : '공통코드',
								name : 'comCodeId',
							}, {
								header : '공통코드명',
								name : 'comCodeName',
							} ]
						});
						/* 디테일코드 */
						//행추가
						$(document).on("click", "button[id=appendRow]", function() {
								var rowData = [ {
									//여기 수정 해야함.
									코드 : "",
									코드명 : "",
									코드설명 : "",
									표시순번 : "",
									사용여부 : "",
								} ];
								gridDetail.appendRow(rowData, {
									at : gridDetail.getRowCount(),
									focus : true
								});
								gridDetail.enable();
						});
						
						//CRUD
						$(document).on("click", "button[id=modifyRow]", function() {
							gridDetail.finishEditing('rowKey','columnName');
							gridDetail.request('modifyData');
						});
						
						//행삭제
						$(document).on("click", "button[id=deleteRow]", function() {
							gridDetail.removeCheckedRows(false);
						});
						
						//체크박스에 데이터 전달
						$(document).on("click", "button[id=findRow]", function() {
							var comCodeDetailId = $("#comCodeDetailId").val();
							var readParams = {
									'comCodeDetailId' : comCodeDetailId
								};
							gridDetail.readData(1, readParams, true);
						});
						
						

						const dataSourceDetail = {
							api : {
								readData : {
									url : '${pageContext.request.contextPath}/comCode/ComCodeDetailList',
									method : 'GET'
								}, modifyData: { 
									url: '${pageContext.request.contextPath}/ajax/modifyComCodeDetail',
									method: 'PUT'
								},
							},
							initialRequest : false,
							contentType : "application/json"
						};
						
						const gridDetail = new tui.Grid({
							el : document.getElementById('gridDetail'),
							rowHeaders : [ 'checkbox' ],
							data : dataSourceDetail,
							columns : [ {
								header : '코드',
								name : 'comCodeDetailId',
								editor : 'text'
							}, {
								header : '코드명',
								name : 'comCodeDetailName',
								editor : 'text'
							}, {
								header : '코드설명',
								name : 'comCodeDetailDesc',
								editor : 'text'
							}, {
								header : '표시순번',
								name : 'comCodeDetailSeq',
								editor : 'text'
							}, {
								header : '사용여부',
								name : 'comCodeDetailUsedchk',
								editor : 'text'
							} ]
						});
						
						//마스터테이블 클릭시 데이터 전달
						grid.on('click', (ev) => {
							var comCodeId = grid.getValue(ev.rowKey, "comCodeId");
							console.log(comCodeId);
					   	var readParams = {
								'comCodeId' : comCodeId
							};
						gridDetail.readData(1, readParams, true);
					   });
						

					});//end of ready

</script>
