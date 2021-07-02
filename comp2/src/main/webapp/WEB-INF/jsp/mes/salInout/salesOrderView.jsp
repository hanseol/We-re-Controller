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
		<h2>주문목록조회</h2>
	</div>
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
				<div class="col-md-4">
						주문일자
						<input type="date" id="orderDate" name="erpProdcutOrderDate">					
				</div>
				<div class="col-md-4">			
						제품코드
						<input type="text" id="productCode" name="productCode">	
						<a href="searchProductCode.do" rel="modal:open">						
                     	<i class="fa fa-search"></i></a>
                  </a>											
				</div>
				<div class="col-md-4">
						업체코드
						<input type="text" id="customerCode" name="customerCode">
						<a href="searchCustomerCode.do" rel="modal:open">					
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
					<p class="panel-subtitle">전체 주문 목록</p>
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
					var orderDate = $("#orderDate").val();
					var productCode = $("#productCode").val();
					var customerCode = $("#customerCode").val();
					var readParams = {
						'erpProductOrderDate' : orderDate,
						'erpProductCode' : productCode,
						'erpCustomerCode' : customerCode
					};
					grid.readData(1, readParams, true);
				});
		
		const dataSource = {
			api : {
				readData : {
					url : '${pageContext.request.contextPath}/ajax/sal/readSalesOrder',
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
			columns : [{
				header : '주문코드',
				name : 'erpOrderCode',
			}, {
				header : '업체코드',
				name : 'erpCustomerCode',
			}, {
				header : '제품코드',
				name : 'erpProductCode',
			}, {
				header : '제품명',
				name : 'erpProductName',
			}, {
				header : '주문량',
				name : 'erpOrderQty',
			}, {
				header : '개당단가',
				name : 'erpProductUnitPrice',
			}, {
				header : '주문일자',
				name : 'erpProductOrderDate',
				editor : {
					type : 'datePicker',
					options : {
						format : 'YYYY/MM/dd',
						language: 'ko'
					} 
				}
			}, {
				header : '납기일자',
				name : 'erpProductDeadline',
				editor : {
					type : 'datePicker',
					options : {
						format : 'YYYY/MM/dd',
						language: 'ko'
					} 
				}
			}]
		}); 
	
	grid.on('response', ev => {
		  const {response} = ev.xhr;
		  const responseObj = JSON.parse(response);

		  console.log('result : ', responseObj.result);
		  console.log('data : ', responseObj.data);
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