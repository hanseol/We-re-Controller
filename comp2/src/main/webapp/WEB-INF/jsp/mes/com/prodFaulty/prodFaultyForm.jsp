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
		<h2>불량제품코드관리</h2>
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
					<div class="col-md-5">
						<form>
							불량코드 
							<input type="text" id="prodFault" name="prodFault">
							<a id="ProdFaultModal" href="${pageContext.request.contextPath}/comModal/ProdFaultModal.do"
								rel="modal:open"> <i class="fa fa-search"></i></a> 

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
					<p class="panel-subtitle">제품불량코드 관리</p>
				</div>
				<div class="col-md-5" align="right">
					<button type="button" id=appendRow>추가</button>
					<button type="button" id="deleteRow">삭제</button>
				</div>
			</div>
			<div class="panel-body">
				<div id="prodFaultyGrid"></div>
			</div>
		</div>
	</div>
</div>

<script>
//그리드모달창을 위한 그리드 선언-------------------------------------
let prodGrid;
let procGrid;
//-----------------------------------------------------------

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
					url : '${pageContext.request.contextPath}/prodFaulty/prodFaultyList',
					method : 'GET'
				}, 
/* 				modifyData: { 
					url: '${pageContext.request.contextPath}/ajax/modifyProdUseMatr',
					method: 'PUT'
				}, */
			},
			initialRequest: false, 
			contentType : "application/json"
		};
		
		//디테일 그리드
		const grid = new tui.Grid({
			el : document.getElementById('prodFaultyGrid'),
			rowHeaders : [ 'checkbox' ],
			data : dataSource,
			columns : [{
				header : '제품불량코드',
				name : 'comProductFCode',
				editor : 'text',
					validation: {
			               required:true
			            } 
			}, {
				header : '불량명',
				name : 'comProductFName',
				editor : 'text'
			}, {
				header : '불량내역',
				name : 'comProductFDetail',
				editor : 'text'
			}, {
				header : '발생공정코드',
				name : 'comProductFProcessCode',
				editor : 'text'
			}, {
				header : '발생공정명',
				name : 'comProductFProcessName',
			}, {
				header : '비고',
				name : 'comProductFEtc',
				editor : 'text',
			}]
		}); 
		
		//Insert
		$(document).on("click", "button[id=appendRow]", function() {
			
			var rowData = {
					comProductFCode : "",
					comProductFName : "",
					comProductFDetail : "",
					comProductFProcessCode : "",
					comProductFProcessName : "",
					comProductFEtc : "",
			};
		    
			grid.appendRow(rowData, {
				at: 0,
				focus : true
			});
			grid.enable();
		});
		
		//Delete
		$(document).on("click", "button[id=deleteRow]", function() {
			grid.finishEditing('rowKey','columnName');
			grid.removeCheckedRows(false);
			console.log(finishEditing);
		});
		
		//CRUD
		$(document).on("click", "button[id=modifyRow]", function() {
			grid.finishEditing('rowKey','columnName');
			grid.request('modifyData');
			console.log(finishEditing);
		});
		

		
//모달 그리드 초기화 ----------------------------------
		prodGrid = grid;
		procGrid = grid;
//--------------------------------------------------

//그리드 모달 더블클릭--------------------------------------------------
		//불량코드
		grid.on('dblclick', ev =>{
			if(ev.columnName == 'comProductFCode'){
				prodFaultSerch(ev.rowKey);
			}
		})
		//공정코드
		grid.on('dblclick', ev =>{
			if(ev.columnName == 'comProductFProcessCode'){
				procCodeSearch(ev.rowKey);
			}
		})
//-----------------------------------------------------------------

		//그리드 응답(제이슨)
		grid.on('response', ev => {
			const { response } = ev.xhr;
			const responseObj = JSON.parse(response);

			console.log('result : ', responseObj.result);
			console.log('data : ', responseObj.data);
		});
		
		
		//분석필요
		//불량
		$('#prodFaultSerchModal').click(function(event) {
			prodFaultSerch(-1);
		});
		//공정
		$('#proCodeSearchModal').click(function(event) {
			procCodeSearch(-1);
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
	//그리드모달 :모달페이지로 값 넘기기----------------------------------------
	//불량코드
	var FaultCode;
	function prodFaultSerch(c) {
		FaultCode = c;
		  console.log(FaultCode);
		  event.preventDefault();
		  $(".modal").remove();
		  this.blur(); // Manually remove focus from clicked link.
		  console.log(this.href);
		  $.get("${pageContext.request.contextPath}/comModal/ProdFaultModal.do", function(html) {
		    $(html).appendTo('body').modal();
		  });
	}
	
	//공정
	var comProcId;
	function procCodeSearch(c) {
		comProcId = c;
		  console.log(comProcId);
		  event.preventDefault();
		  $(".modal").remove();
		  this.blur(); // Manually remove focus from clicked link.
		  console.log(this.href);
		  $.get("${pageContext.request.contextPath}/prodUseMatr/ProCodeSearchModal.do", function(html) {
		    $(html).appendTo('body').modal();
		  });
	}
	//---------------------------------------------------------------
</script>
