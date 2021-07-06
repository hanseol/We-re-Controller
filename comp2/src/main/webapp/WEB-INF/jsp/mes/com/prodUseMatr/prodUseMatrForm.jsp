<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet"
	href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<link rel="stylesheet"
	href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css">

<script
	src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
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
	/* height: 600px;
	max-height: 600px; */
}

.blocker {
	z-index: 1200;
}
</style>

<div class="content-fluid">
	<div>
		<h2>제품BOM관리</h2>
	</div>
</div>

<div class="content-fluid">
	<div>
		<div class="my-panel">
			<button type="button" class="btn btn-success" id="search">조회</button>
			<button type="button" class="btn btn-danger" id="reset">새자료</button>
			<button type="button" class="btn btn-info" id="modifyRow">저장</button>
		</div>
	</div>
</div>

<form id="option">
	<div class="content-fluid">
		<div class="panel panel-headline">
			<div class="panel-body">
				<div class="row">
					<div class="col-md-4">
						<form>
							제품코드 <input type="text" id="productCode" name="productCode">
							<a id="ProdUseMatrModal" href="ProdUseMatrModal.do"
								rel="modal:open"> <i class="fa fa-search"></i></a>
							<!-- 모달창 -->
							<a id="showModal"
								href="${pageContext.request.contextPath}/prodUseMatr/proCodeSearchModal.do"
								rel="modal:open"></a>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</form>

<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-heading">
			<div class="row">
				<div class="col-md-7">
					<p class="panel-subtitle">제품 소요량 관리</p>
				</div>
				<div class="col-md-5" align="right">
					<button type="button" id=appendRow>추가</button>
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
	var grid;
	$(document).ready(function() {
		//변수생성
		var productCode = 0;
		//코드명 검색
		$(document).on("click", "button[id=search]",
				function() {
					productCode = $("#productCode").val();
					var readParams = {
						'comProductCode' : productCode,
					};
					grid.readData(1, readParams, true);
				});
		
		
		const dataSource = {
			api : {
				readData : {
					url : '${pageContext.request.contextPath}/prodUseMatr/ProdUseMatrList',
					method : 'GET'
				}, 
				modifyData: { 
					url: '${pageContext.request.contextPath}/ajax/modifyProdUseMatr',
					method: 'PUT'
				},
			},
			initialRequest: false, 
			contentType : "application/json"
		};
		
		//디테일 그리드
		grid = new tui.Grid({
			el : document.getElementById('grid'),
			rowHeaders : [ 'checkbox' ],
			data : dataSource,
			columns : [{
				header : '제품코드',
				name : 'comProductCode',
				//hidden : true
			},{
				header : '자재코드',
				name : 'comMaterialCode',
				validation: {
		               required:true
		            }
			}, {
				header : '자재명',
				name : 'comProductName',
			}, {
				header : '사용량',
				name : 'comBomUnit',
				editor : 'text'
			}, {
				header : '발주',
				name : 'comBomOrder',
			}, {
				header : '생산',
				name : 'comBomProduce',
			},{
				header : '공정코드',
				name : 'comProcessCode',
				//hidden : true
			}, {
				header : '사용공정명',
				name : 'comProcessName',
				validation: {
		               required:true
		            }
			}, {
				header : '비고',
				name : 'comBomEtc',
				editor : 'text'
			}]
		}); 
		
		//Insert
		$(document).on("click", "button[id=appendRow]", function() {
			
			var rowData = {
					comProductCode : productCode,
					comMaterialCode : "",
					comBomUnit : "",
					comBomOrder : "",
					comBomProduce : "",
					comProcessCode : "",
					comBomEtc : "",
			};
			grid.appendRow(rowData, {
				at : grid.getRowCount(),
				focus : true
			});
			grid.enable();
		});
		
		//Delete
		$(document).on("click", "button[id=deleteRow]", function() {
			grid.finishEditing('rowKey','columnName');
			grid.removeCheckedRows(false);
		});
		
		//CRUD
		$(document).on("click", "button[id=modifyRow]", function() {
			grid.finishEditing('rowKey','columnName');
			grid.request('modifyData');
		});
		
		// 분석필요
		grid.on('response', ev => {
			  const {response} = ev.xhr;
			  const responseObj = JSON.parse(response);
	
			  console.log('result : ', responseObj.result);
			  console.log('data : ', responseObj.data);
			});
		
		//더블클릭 모달창 on(공정코드)
		grid.on('dblclick', ev => {
		    if(ev.columnName == 'comProcessName'){
		       
		       $('#showModal').click();
		       
		    }
		 });
	
		// option form reset  
		 $(document).ready(function() {  
		    $("#reset").click(function() {  
		         $("form").each(function() {  
		                if(this.id == "option") this.reset();  
		             });  
		    });  
		 });  
	
	}); //end of document ready
</script>