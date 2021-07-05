<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css">

<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>

<style>
.my-panel {
	text-align: right;
	border-top: 1px solid gray;
	padding: 10px;
	margin-bottom: 10px;
	background-color: white;
}

.modal{
	-webkit-border-radius :0px;
	border-radius:0px;
	overflow: visible;
	text-align: center;
	max-width: 900px;
	width: 900px;
	/* height: 600px;
	max-height: 600px; */
}

.blocker{
	z-index: 1200;
}
</style>

<div class="content-fluid">
	<div>
		<h2>입/출고목록관리</h2>
	</div>
</div>

<!-- 관리, 지시 탭 이동 -->
<div id="tabs">
   <ul class="nav nav-tabs" role="tablist">
     <li class="active"><a onclick='location.href="salesProdForm.do"' aria-controls="tab1" role="tab" data-toggle="tab">관리</a></li>
     <li class=""><a onclick='location.href="salesProdView.do"' aria-controls="tab2" role="tab" data-toggle="tab">조회</a></li>
   </ul>
</div>

<div class="content-fluid">
	<div>
		<div class="my-panel">
			<button type="button" class="btn btn-success" id="search">조회</button>
			<button type="button" class="btn btn-danger" id="reset">새자료</button>
			<button type="button" class="btn btn-warning" id="modifyRow">저장</button>
		</div>
	</div>
</div>


<form id="option">
<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-body">
			<div class="row">
				<div class="col-md-3">
						일자
						<input type="date" id="dateGubun" name="dateGubun">
				</div>
				<div class="col-md-3">
						입/출고구분 &nbsp;
						<input type="checkbox" id="inGubun" name="gubun" value="1" checked>입고
						<input type="checkbox" id="outGubun" name="gubun" value="2">출고
				</div>
				<div class="col-md-3">
						제품코드
						<input type="text" id="productCode" name="productCode">	
						<a id="searchProductCode" href="searchProductCode.do" rel="modal:open">						
                     	<i class="fa fa-search"></i></a>
				</div>
				<div class="col-md-3">
						완제품 LOT_NO
						<input type="text" id="productLotNo" name="productLotNo">	
						<a id="searchProductLotNo" href="searchProductLotNo.do" rel="modal:open">						
                     	<i class="fa fa-search"></i></a>
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
					<p class="panel-subtitle">완제품 입/출고 목록</p>
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

<!-- 추가 모달 -->
<a id="searchOrderCode" href="searchOrderCode.do" rel="modal:open"></a>
<a id="searchCustomerCode" href="searchCustomerCode.do" rel="modal:open"></a>

<script>
	$(document).ready(function() {
		//Read
		$(document).on("click", "button[id=search]",
				function() {
					var date = $("#dateGubun").val();
					var inGubun = $("#inGubun").val();
					var outGubun = $("#outGubun").val();
					var gubun;
					var productCode = $("#productCode").val();
					var productLotNo = $("#productLotNo").val();
					/* var inoutCode;
					var quantity;
					var writeDate; */
					
					//체크박스 옵션
					if ($('input:checkbox[id="inGubun"]').is(":checked") && $('input:checkbox[id="outGubun"]').is(":checked") == true) {
						gubun = null;
					} else if ($('input:checkbox[id="inGubun"]').is(":checked") == true) {
						gubun = 'SALES003';
					} else if ($('input:checkbox[id="outGubun"]').is(":checked") == true) {
						gubun = 'SALES002';
					} else {
						gubun = null;
					}
										
					var readParams = {
						'salInoutDate' : date,
						'salInoutGubun' : gubun,
						'comProductCode' : productCode,
						'proProcessLotNo' : productLotNo
					};
					grid.readData(1, readParams, true);
				});
		
		//Insert
		$(document).on("click", "button[id=appendRow]", function() {
			var rowData = {
					date : "",
					gubun : "",
					statement : "",
					inoutCode : "",
					productCode : "",
					quantity : "",
					productLotNo : "",
					writeDate : ""
			};
			grid.appendRow(rowData, {
				at : 0,
				/*at : grid.getRowCount(),*/
				focus : true
			});
			grid.enable();
		});
		
		//Delete
		$(document).on("click", "button[id=deleteRow]", function() {
			grid.finishEditing('rowKey','columnName');
			grid.removeCheckedRows(false);
		});
		
		//Modify
		$(document).on("click", "button[id=modifyRow]", function() {
			var date = $("#dateGubun").val();
			var gubun = $("#gubun").val();
			var productCode = $("#productCode").val();
			var productLotNo = $("#productLotNo").val();		
			
			grid.finishEditing('rowKey','columnName');
			var requestParams = { 
					'salInoutDate' : date,
					'salInoutGubun' : gubun,
					'salInoutCode' : inoutCode,
					'comProductCode' : productCode,
					'salInoutQuantity' : quantity,
					'proProcessLotNo' : productLotNo,
					'salWriteDate' : writeDate
			};
			grid.setRequestParams(requestParams);
			grid.request('modifyData');
		});
		
		
		const dataSource = {
			api : {
				readData : {
					url : '${pageContext.request.contextPath}/ajax/sal/readSalesProduct',
					method : 'GET'
				},
				modifyData : {
					url : '${pageContext.request.contextPath}/ajax/modifySalInoutList',
					method : 'PUT'
				}
			},
			initialRequest: false, 
			contentType : "application/json"
		};
		
/* 		const selectBox = new SelectBox(container, {
			 data: [ { label: '입고', value: 'SALES002', selected: true },
				 	{ label: '출고', value: 'SALES003' } ]
		}); */

		const grid = new tui.Grid({
			el : document.getElementById('grid'),
			rowHeaders : [ 'checkbox' ],
			data : dataSource,
			scrollX: true,
	        scrollY: true,
	        bodyHeight :30, 
	        rowHeight: 30,
			columns : [ {
				header : '입/출고일자',
				name : 'salInoutDate',
				editor : {
					type : 'datePicker',
					options : {
						format : 'YYYY/MM/dd',
						language: 'ko'
					} 
				}
			}, {
				header : '입/출고구분',
				name : 'salInoutGubun',
				editor : {
					type: 'select',
					options : {
					listItems: [
						{text : '입고', value : 'SALES002'},
						{text : '출고', value : 'SALES003'}
						]
					}
				}
			}, {
				header : '전표번호',
				name : 'salInoutStatement',
				editor : 'text'
			}, {
				header : '지시/거래처코드',
				name : 'salInoutCode',
				editor : 'text'
			}, {
				header : '제품코드',
				name : 'comProductCode',
				editor : 'text'
			}, {
				header : '수량',
				name : 'salInoutQuantity',
				editor : 'text'
			}, {
				header : '완제품 LOT_NO',
				name : 'proProcessLotNo',
				editor : 'text'
			}, {
				header : '작성일자',
				name : 'salWriteDate',
				editor : 'text'
			}]
		}); 
	
	
	grid.on('response', ev => {
		  const {response} = ev.xhr;
		  const responseObj = JSON.parse(response);

		  console.log('result : ', responseObj.result);
		  console.log('data : ', responseObj.data);
		});
	
	 //모달 : 제품코드
	   grid.on('dblclick', ev => {
	      if(ev.columnName == 'comProductCode'){    
	         $('#searchProductCode').click();	         
	      }
	   });
	
	 //모달 : 완제품 LOT_NO
	   grid.on('dblclick', ev => {
	      if(ev.columnName == 'proProcessLotNo'){    
	         $('#searchProductLotNo').click();	         
	      }
	   });

	 //모달 : 지시/거래처코드 구분
	 grid.on('dblclick', ev => {
	      if(ev.columnName == 'salInoutCode') {    
	         if(grid.getColumnsValues('salInoutGubun') == 'SALES002') { //입고 -> 지시 모달 오픈
	        	 $('#searchOrderCode').click();	  
	         } else if (grid.getColumnsValues('salInoutGubun') == 'SALES003') { //출고 -> 거래처 모달 오픈
	        	 $('#searchCustomerCode').click();
	      	 } else {
		    	  alert('입고/출고를 먼저 구분해주세요.');
		    	  return;
		     }
	    } 
	   });


}); //end of document ready
</script>