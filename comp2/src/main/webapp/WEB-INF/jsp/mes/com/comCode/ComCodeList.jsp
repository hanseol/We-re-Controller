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
		<h2>공통자료 관리</h2>
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
					<div>
						<label for="selCodeIdNm">코드ID명</label>
						<!-- 체크박스 값 input에 받기 -->
						<input type="text" id="comCodeId"> <a
							href="${pageContext.request.contextPath}/comCodeModal.do"
							rel="modal:open" id="getData"> <i class="fa fa-search"></i>
						</a>
						<button id="findRowCodeId">검색</button>
						<div class="col-md-7"></div>
						<div class="col-md-5" align="right">
							<button type="button" id=appendRow>추가</button>
							<button type="button" id="deleteRow">삭제</button>
						</div>
					</div>
					<div class="panel-body">
						<div class="row">
							<div>
								<label>공통코드명</label>
								<!-- 체크박스 값 input에 받기 -->

								<input id="comCodeName" />
								<!-- 모달창 사용x -->
								<%-- 					<a href="${pageContext.request.contextPath}/comCodeModal.do" rel="modal:open" id="getData">
						<i class="fa fa-search"></i>
						</a> 
--%>
								<button id="findRowCodeId" type="button">검색</button>

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
</form>

<!-- 마스터데이터 -->
<script>

	$(document)
			.ready(
					function() {
						var comCodeIdclick = 0;
						
						//코드명 검색
						$(document).on("click", "button[id=findRowCodeId]", function() {
							var comName = $("#comCodeName").val();
							console.log(comName);
							var readParams = {
									'comCodeName' : comName
								};
							//보낼 grid 이름 지정
							grid.readData(1, readParams, true);
						});
						
						//마스터테이블 controller 연결
						const dataSource = {
							api : {
								readData : {
									url : '${pageContext.request.contextPath}/comCode/ComCodeList',
									method : 'GET'
								},
							},
							contentType : "application/json"
						};
						
						//마스터테이블 그리드
						const grid = new tui.Grid({
							el : document.getElementById('grid'),
							data : dataSource,
						    scrollX: true,
						    scrollY: true,
						     bodyHeight :480,
						     rowHeight: 30,
							columns : [ {
								header : '공통코드',
								name : 'comCodeId',
							}, {
								header : '공통코드명',
								name : 'comCodeName',
							} ]
						});
						
						/* 디테일코드 */
						
						
						//CRUD
						$(document).on("click", "button[id=modifyRow]", function() {
							gridDetail.finishEditing('rowKey','columnName');
							gridDetail.request('modifyData');
						});
						
						//행삭제
						$(document).on("click", "button[id=deleteRow]", function() {
							gridDetail.removeCheckedRows(false);
						});
						
						//디테일코드 controller 연결
						const dataSourceDetail = {
							api : {
								readData : {
									url : '${pageContext.request.contextPath}/comCode/ComCodeDetailList',
									method : 'GET'
								}, 
								modifyData: { 
									url: '${pageContext.request.contextPath}/ajax/modifyComCodeDetail',
									method: 'PUT'
								},
							},
							// 바로 값 나오지않게함
							initialRequest : false,
							contentType : "application/json"
						};
						
						//디테일코드 그리드 설정
						const gridDetail = new tui.Grid({
							el : document.getElementById('gridDetail'),
							rowHeaders : [ 'checkbox' ],
							data : dataSourceDetail,
						    scrollX: true,
						    scrollY: true,
						     bodyHeight : 480,
						     rowHeight: 30,
							columns : [ {
								header : '공통코드',
								name : 'comCodeId',
								hidden : true
							},{
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
							comCodeIdclick = grid.getValue(ev.rowKey, "comCodeId");
							console.log(comCodeIdclick);
					   	var readParams = {
								'comCodeId' : comCodeIdclick
							};
						gridDetail.readData(1, readParams, true);
					   });
					
						//행추가
						$(document).on("click", "button[id=appendRow]", function() {
							console.log(comCodeIdclick);
							var rowData =  {
									comCodeId : comCodeIdclick,
									comCodeDetailId : "",
									comCodeDetailName : "",
									comCodeDetailDesc : "",
									comCodeDetailSeq : "",
									comCodeDetailUsedchk : "",
								} ;
								gridDetail.appendRow(rowData, {
									at : gridDetail.getRowCount(),
									focus : true
								});
								gridDetail.enable();
						});
						
						// option form reset  
						 $(document).ready(function() {  
						    $("#reset").click(function() {  
						         $("form").each(function() {  
						                if(this.id == "option") this.reset();  
						             });  
						    });  
						 });  
						

					});//end of ready

</script>
