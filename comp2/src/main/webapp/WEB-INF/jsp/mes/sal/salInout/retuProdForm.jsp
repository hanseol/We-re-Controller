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
		<h2>반품목록관리</h2>
	</div>
</div>

<!-- 관리, 지시 탭 이동 -->
<div id="tabs">
   <ul class="nav nav-tabs" role="tablist">
     <li class="active"><a onclick='location.href="retuProdForm.do"' aria-controls="tab1" role="tab" data-toggle="tab">관리</a></li>
     <li class=""><a onclick='location.href="retuProdView.do"' aria-controls="tab2" role="tab" data-toggle="tab">조회</a></li>
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
				<div class="col-md-6">
					반품일자
					<input type="date" id="returnDate" name="returnDate">			
				</div>
				<div class="col-md-6">
					완제품 LOT_NO
					<input type="text" id="productLotNo" name="productLotNo">	
					<a id="searchProductLotNo" href="${pageContext.request.contextPath}/searchProductLotNo.do">						
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
					<p class="panel-subtitle">반품 목록</p>
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
let mgrid; //모달 그리드
	$(document).ready(function() {
		//Read
		$(document).on("click", "button[id=search]",
				function() {
					var returnDate = $("#returnDate").val();
					var productLotNo = $("#productLotNo").val();
					console.log(returnDate, productLotNo);
					var readParams = {
						'salInoutDate' : returnDate,
						'proProcessLotNo' : productLotNo
					};
					grid.readData(1, readParams, true);
				});
		
		//Insert
		$(document).on("click", "button[id=appendRow]", function() {
			var rowData =[{
					salInoutDate : "",
					salInoutCode : "",
					comProductCode : "",
					salInoutQuantity : "",
					proProcessLotNo : "",
					salWriteDate : "",
			}];
			grid.appendRow(rowData, {
				at : 0,
				focus : true
			});
			grid.enable();
		});
		
		//Delete
		$(document).on("click", "button[id=deleteRow]", function() {
			grid.removeCheckedRows(false);
		});
		
		//Modify
		$(document).on("click", "button[id=modifyRow]", function() {
			grid.finishEditing('rowKey','columnName');
			grid.request('modifyData');
		});
		
		const dataSource = {
			api : {
				readData : {
					url : '${pageContext.request.contextPath}/ajax/sal/readReturnProduct',
					method : 'GET'
				},
				modifyData : {
					url : '${pageContext.request.contextPath}/ajax/modifySalReturnList',
					method : 'PUT'
				}
			},
			initialRequest: false, 
			contentType : "application/json"
		};

		const grid = new tui.Grid({
			el : document.getElementById('grid'),
			rowHeaders : [ 'checkbox' ],
			data : dataSource,
			scrollX: true,
	        scrollY: true,
	        bodyHeight :30, 
	        rowHeight: 30,
			columns : [{
				header : '반품일자',
				name : 'salInoutDate',
				editor : {
					type : 'datePicker',
					options : {
						format : 'YYYY/MM/dd',
						language: 'ko'
					} 
				}
			}, {
				header : '완제품 LOT_NO',
				name : 'proProcessLotNo',
				editor : 'text'
			}, {
				header : '업체코드',
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
			}]
		}); 
	
		mgrid = grid;
		
		 //모달 : 제품코드
		   grid.on('dblclick', ev => {
		      if(ev.columnName == 'comProductCode'){  
		    	  productCodeSearch(ev.rowKey);
		    	  //더블클릭 이벤트 -> productCodeSearch 함수 실행
		      }
		   });

		//모달 : 완제품 LOT_NO
		   grid.on('dblclick', ev => {
		      if(ev.columnName == 'proProcessLotNo'){    
		    	  productLotNoSearch(ev.rowKey);         
		      }
		   });
		 
			$('#searchProductLotNo').click(function(event) {
			 	productLotNoSearch(-1);
			});
		
			//모달 : 거래처코드
		   	grid.on('dblclick', ev => {
		      if(ev.columnName == 'salInoutCode'){  
		    	  customerCodeSearch(ev.rowKey);
		    	  //더블클릭 이벤트 -> productCodeSearch 함수 실행
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

var rowId;

//제품코드 모달
function productCodeSearch(c) {
	  rowId = c;
	  event.preventDefault();
	  $(".modal").remove();
	  this.blur(); // Manually remove focus from clicked link.
	  console.log(this.href);
	  $.get("searchProductCode.do", function(html) {
	    $(html).appendTo('body').modal();
	  });
}

//완제품 LOT_NO 모달
function productLotNoSearch(c) {
	  rowId = c;
	  event.preventDefault();
	  $(".modal").remove();
	  this.blur(); // Manually remove focus from clicked link.
	  console.log(this.href);
	  $.get("searchProductLotNo.do", function(html) {
	    $(html).appendTo('body').modal();
	  });
}

//업체코드 모달
function customerCodeSearch(c) {
	  rowId = c;
	  event.preventDefault();
	  $(".modal").remove();
	  this.blur(); // Manually remove focus from clicked link.
	  console.log(this.href);
	  $.get("searchCustomerCode.do", function(html) {
	    $(html).appendTo('body').modal();
	  });
}

</script>