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
		<h2>입/출고목록조회</h2>
	</div>
</div>

<!-- 관리, 지시 탭 이동 -->
<div id="tabs">
   <ul class="nav nav-tabs" role="tablist">
     <li class=""><a onclick='location.href="salesProdForm.do"' aria-controls="tab1" role="tab" data-toggle="tab">관리</a></li>
     <li class="active"><a onclick='location.href="salesProdView.do"' aria-controls="tab2" role="tab" data-toggle="tab">조회</a></li>
   </ul>
</div>


<div class="content-fluid">
	<div>
		<div class="my-panel">
			<button type="button" class="btn btn-success" id="search">조회</button>
			<button type="button" class="btn btn-danger" id="reset">새자료</button>
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
						<a href="searchProductCode.do" rel="modal:open">						
                     	<i class="fa fa-search"></i></a>
				</div>
				<div class="col-md-3">
						완제품 LOT_NO
						<input type="text" id="productLotNo" name="productLotNo">	
						<a href="searchProductLotNo.do" rel="modal:open">						
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
			</div>
			<div class="panel-body">
				<div id="grid"></div>
			</div>
		</div>
	</div>
</div>

<script>
	$(document).ready(function() {	
		$(document).on("click", "button[id=search]",
				function() {
					var date = $("#dateGubun").val();
					var inGubun = $("#inGubun").val();
					var outGubun = $("#outGubun").val();
					var gubun;
					var productCode = $("#productCode").val();
					var productLotNo = $("#productLotNo").val();
					
					//체크박스 옵션
					if ($('input:checkbox[id="inGubun"]').is(":checked") && $('input:checkbox[id="outGubun"]').is(":checked") == true) {
						gubun = null;
					} else if ($('input:checkbox[id="inGubun"]').is(":checked") == true) {
						gubun = 'INOUT003';
					} else if ($('input:checkbox[id="outGubun"]').is(":checked") == true) {
						gubun = 'INOUT002';
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
		
		const dataSource = {
			api : {
				readData : {
					url : '${pageContext.request.contextPath}/ajax/sal/readSalesProduct',
					method : 'GET'
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
			},{
				header : '입/출고구분',
				name : 'salInoutGubun'
			}, {
				header : '전표번호',
				name : 'salInoutStatement'
			}, {
				header : '지시/거래처코드',
				name : 'salInoutCode'
			}, {
				header : '제품코드',
				name : 'comProductCode'
			}, {
				header : '제품명',
				name : 'comProductName'
			}, {
				header : '수량',
				name : 'salInoutQuantity'
			}, {
				header : '완제품 LOT_NO',
				name : 'proProcessLotNo'
			}, {
				header : '작성일자',
				name : 'salWriteDate'
			}]
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