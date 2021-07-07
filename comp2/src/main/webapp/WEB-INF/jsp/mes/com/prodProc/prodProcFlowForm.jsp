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
		<h2>제품공정흐름관리</h2>
	</div>
</div>

<!--  -->
<div class="content-fluid">
	<div>
		<div class="my-panel">
			<button type="button" class="btn btn-danger" id="reset">새자료</button>
			<button type="button" class="btn btn-info" id="modifyRow">저장</button>
		</div>
	</div>
</div>

<!--  -->
<form id="option">
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
						<!-- 마스터데이터 호출 -->
						<div class="col-md-4" id="masterGrid"></div>
						<div class="col-md-8" id="gridDetail"></div>
						<!-- Detail 표현 -->
					<div class="col-md-8" id="gridFlow"></div> 
					</div>
				</div>
			</div>
		</div>
	</div>
</form>

<!-- 마스터데이터 -->
<script>
	$(document)
			.ready(
					function() {
						var masterClick = 0;

						//마스터테이블 controller 연결
						const masterDataSource = {
							api : {
								readData : {
									url : '${pageContext.request.contextPath}/prodProc/ComProdList',
									method : 'GET'
								},
							},
							contentType : "application/json"
						};

						//마스터테이블 그리드
						const grid = new tui.Grid({
							el : document.getElementById('masterGrid'),
							data : masterDataSource,
							scrollX : true,
							scrollY : true,
							bodyHeight : 480,
							rowHeight : 30,
							columns : [ {
								header : '제품코드',
								name : 'comProductCode',
							}, {
								header : '제품명',
								name : 'comProductName',
							} ]
						});

						
						//디테일코드 controller 연결
						const detailDataSource = {
							api : {
								readData : {
									url : '${pageContext.request.contextPath}/prodProc/ProdProcList',
									method : 'GET'
								}, 
							},
							// 바로 값 나오지않게함
							//initialRequest : false,
							contentType : "application/json"
						};
						
						//디테일코드 그리드 설정
						const detailGrid = new tui.Grid({
							el : document.getElementById('gridDetail'),
							rowHeaders : [ 'checkbox' ],
							data : detailDataSource,
						    scrollX: true,
						    scrollY: true,
						     bodyHeight : 480,
						     rowHeight: 30,
							columns : [ {
								header : '제품코드',
								name : 'comProductCode',
							},{
								header : '제품명',
								name : 'comProductName',
								editor : 'text'
							}, {
								header : '규격',
								name : 'comProductSize',
								editor : 'text'
							}, {
								header : '관리단위',
								name : 'comProductUnit',
								editor : 'text'
							}, {
								header : '사용여부',
								name : 'comProductUse',
								editor : 'text'
							} ]
						}); 
						
						//공정전개 controller 연결
						const flowDataSource = {
							api : {
								readData : {
									url : '${pageContext.request.contextPath}/prodProc/ProcFlowList',
									method : 'GET'
								}, 
							},
							// 바로 값 나오지않게함
							//initialRequest : false,
							contentType : "application/json"
						};
						
						//디테일코드 그리드 설정
						const flowGrid = new tui.Grid({
							el : document.getElementById('gridFlow'),
							rowHeaders : [ 'checkbox' ],
							data : flowDataSource,
						    scrollX: true,
						    scrollY: true,
						     bodyHeight : 480,
						     rowHeight: 30,
							columns : [ {
								header : '순서',
								name : 'comProcessSeq',
							},{
								header : '공정명',
								name : 'comProcessName',
								editor : 'text'
							}, {
								header : '공정설명',
								name : 'comProcessDesc',
								editor : 'text'
							}, {
								header : '관리단위',
								name : 'comProcessUnit',
								editor : 'text'
							}, {
								header : '부하',
								name : 'comProcessBuha',
								editor : 'text'
							}, {
								header : 'LEAD타임',
								name : 'comProductUse',
								editor : 'text'
							} ]
						}); 
						
						//마스터테이블 클릭시 데이터 전달
						grid.on('click', (ev) => {
							masterClick = grid.getValue(ev.rowKey, "comProductCode");
							console.log(masterClick);
					   	var readParams = {
								'comProductCode' : masterClick
							};
					   	detailGrid.readData(1, readParams, true);
					   	flowGrid.readData(1, readParams, true);
				   		});
				});//end of ready
</script>
