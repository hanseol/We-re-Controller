<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<div class="content-fluid">
	<div>
		<h2>자재정보관리/안전재고관리</h2>
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
//네비게이션 고정
$('#proNav').addClass('active');
$('#subPages1').addClass('in');
$('#subPages1').attr('aria-expanded','true');
$('#subPages1').attr('style','');
$('.matrDtaList').addClass('active');

	$(document)
			.ready(
					function() {
						var comMatrClick = 0;

						//마스터테이블 controller 연결
						const ComMatrdataSource = {
							api : {
								readData : {
									url : '${pageContext.request.contextPath}/matrDta/MatrDtaList',
									method : 'GET'
								},
							},
							contentType : "application/json"
						};

						//마스터테이블 그리드
						const grid = new tui.Grid({
							el : document.getElementById('grid'),
							data : ComMatrdataSource,
							scrollX : true,
							scrollY : true,
							bodyHeight : 480,
							rowHeight : 30,
							columns : [ {
								header : '자재코드',
								name : 'comCodeDetailId',
							}, {
								header : '자재명',
								name : 'comCodeDetailName',
							}, {
								header : '규격',
								name : 'comMaterialSize',
							} ]
						});

						/* 디테일코드 */

						/* 	//CRUD
							$(document).on("click", "button[id=modifyRow]", function() {
								gridDetail.finishEditing('rowKey','columnName');
								gridDetail.request('modifyData');
							});
							
							//행삭제
							$(document).on("click", "button[id=deleteRow]", function() {
								gridDetail.removeCheckedRows(false);
							});
							*/
							//디테일코드 controller 연결
							const dataSourceDetail = {
								api : {
									readData : {
										url : '${pageContext.request.contextPath}/matrDta/MatrDtaDetailList',
										method : 'GET'
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
									header : '자재코드',
									name : 'comCodeDetailId',
								},{
									header : '자재명',
									name : 'comMaterialName',
									editor : 'text'
								}, {
									header : '관리단위',
									name : 'comMaterialUnit',
									editor : 'text'
								}, {
									header : '공급자코드',
									name : 'comMaterialVendorCode',
									editor : 'text'
								}, {
									header : '코드상세명',
									name : 'comCodeDetailName',
									editor : 'text'
								}, {
									header : '안전재고',
									name : 'comMaterialSafetyStock',
									editor : 'text'
								} ]
							}); 
							
							//마스터테이블 클릭시 데이터 전달
							grid.on('click', (ev) => {
								comMatrClick = grid.getValue(ev.rowKey, "comCodeDetailId");
								console.log(comMatrClick);
						   	var readParams = {
									'comCodeDetailId' : comMatrClick
								};
						   	gridDetail.readData(1, readParams, true);
						   });
							
							/*
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
							 });   */

					});//end of ready
</script>
