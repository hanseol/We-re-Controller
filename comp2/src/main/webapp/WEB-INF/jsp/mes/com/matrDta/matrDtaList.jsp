<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="content-fluid">
	<div>
		<h2>자재정보관리/안전재고관리</h2>
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
						<button type="button" id="modifyRow">저장</button>
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


<script>

	$(document)
			.ready(
					function() {
						
						//네비게이션 고정 - 2021.07.23 김한설 수정
						$('#n4000000').addClass('active');
						$('#subPages4000000').addClass('in');
						$('#subPages4000000').attr('aria-expanded','true');
						$('#subPages4000000').attr('style','');
						$('.4020000').addClass('active');
						
						var comMatrClick = 0;

						//마스터테이블 controller 연결
						const ComMatrdataSource = {
							api : {
								readData : { url : '${pageContext.request.contextPath}/matrDta/MatrDtaList', method : 'GET'}
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
								align : 'center'
							}, {
								header : '자재명',
								name : 'comCodeDetailName',
								align : 'center'
							}, {
								header : '규격',
								name : 'comMaterialSize',
								align : 'center'
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

						/* 디테일코드 */
	
						//디테일코드 controller 연결
						const dataSourceDetail = {
							api : {
								readData : {url : '${pageContext.request.contextPath}/matrDta/MatrDtaDetailList', method : 'GET'}, 
								modifyData : { url: '${pageContext.request.contextPath}/ajax/matrDat/UpdateMaterialInfo', method: 'PUT' }
							},
							// 바로 값 나오지않게함
							initialRequest : false,
							contentType : "application/json"
						};
							
						//디테일코드 그리드 설정
						const gridDetail = new tui.Grid({
							el : document.getElementById('gridDetail'),
							data : dataSourceDetail,
						    scrollX: true,
						    scrollY: true,
						    bodyHeight : 480,
						    rowHeight: 30,
							columns : [ {
								header : '자재코드',
								name : 'comCodeDetailId',
								align: 'center'
							},{
								header : '자재명',
								name : 'comMaterialName',
								editor : 'text',
								align : 'center'
							}, {
								header : '관리단위',
								name : 'comMaterialUnit',
								editor : 'text',
								align : 'center'
							}, {
								header : '공급자코드',
								name : 'comMaterialVendorCode',
								editor : 'text',
								align : 'center'
							}, {
								header : '코드상세명',
								name : 'comCodeDetailName',
								editor : 'text',
								align : 'center'
							}, {
								header : '안전재고',
								name : 'comMaterialSafetyStock',
								editor : 'text',
								align : 'center'
							} ]
						}); 
						
						//변경사항 저장
						$(document).on("click", "button[id=modifyRow]", function() {
							gridDetail.finishEditing('rowKey','columnName');
							gridDetail.request('modifyData');
						});
						
					});//end of ready
</script>
