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
		<h2>공통자료 관리</h2>
	</div>
</div>

<div class="search-area search-area-border grid-option-area">
	<!--  -->
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
					<button type="button" id="findRow">조회</button>
					<button type="button" id="appendRow">추가</button>
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
						$(document).on("click", "button[id=appendRow]",
								function() {
									var rowData = [ {
										//여기 수정 해야함.
										공통코드 : "",
										공통코드명 : "",
									} ];
									grid.appendRow(rowData, {
										at : grid.getRowCount(),
										focus : true
									});
									grid.enable();
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
						
						
						/*  */
						
						$(document).on("click", "button[id=appendRow]", function() {
								var rowData = [ {
									//여기 수정 해야함.
									코드 : "",
									코드명 : "",
									코드설명 : "",
									표시순번 : "",
									사용여부 : "",
								} ];
								grid.appendRow(rowData, {
									at : grid.getRowCount(),
									focus : true
								});
								grid.enable();
						});

						const dataSourceDetail = {
							api : {
								readData : {
									url : '${pageContext.request.contextPath}/comCode/ComCodeDetailList',
									method : 'GET'
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
