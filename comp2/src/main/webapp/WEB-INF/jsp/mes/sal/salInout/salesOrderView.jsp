<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
						제품명
						<input type="text" id="productCode" name="productCode">	
						<a id="searchProductCode" href="${pageContext.request.contextPath}/searchProductCode.do">						
                     	<i class="fa fa-search"></i></a>
                  </a>											
				</div>
				<div class="col-md-4">
						고객사명
						<input type="text" id="customerCode" name="customerCode">
						<a id="searchCustomerCode" href="${pageContext.request.contextPath}/searchCustomerCode.do">					
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


let mgrid; //모달 그리드

	$(document).ready(function() {
		//내비바 고정
		$('#n9000000').addClass('active');
		$('#subPages9000000').addClass('in');
		$('#subPages9000000').attr('aria-expanded','true');
		$('#subPages9000000').attr('style','');
		$('.9010000').addClass('active');
		
		$("#search").on("click", function() {
					var orderDate = $("#orderDate").val();
					var product = $("#productCode").val();
					var customer = $("#customerCode").val();
					var readParams = {
						'erpProductOrderDate' : orderDate,
						'erpProductName' : product,
						'erpCustomerName' : customer
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
			scrollX: true,
	        scrollY: true,
	        bodyHeight :300, 
	        rowHeight: 30,
			columns : [{
				header : '주문일자',
				name : 'erpProductOrderDate',
				align : 'center',
				editor : {
					type : 'datePicker',
					options : {
						format : 'YYYY/MM/dd',
						language: 'ko'
					} 
				}
			}, {
				header : '주문코드',
				name : 'erpOrderCode',
				align : 'center'
			}, {
				header : '고객사명',
				name : 'erpCustomerName',
				align : 'center'
			}, {
				header : '제품명',
				name : 'erpProductName',
				align : 'center'
			}, {
				header : '주문량',
				name : 'erpOrderQty',
				align : 'right',
				formatter: (ev)=>{return (ev.value == null) ? null : String(ev.value).replace(/\B(?=(\d{3})+(?!\d))/g, ","); }
			}, {
				header : '개당단가(원)',
				name : 'erpProductUnitPrice',
				align : 'right',
				formatter: (ev)=>{return (ev.value == null) ? null : String(ev.value).replace(/\B(?=(\d{3})+(?!\d))/g, ","); }
			}, {
				header : '납기일자',
				name : 'erpProductDeadline',
				align : 'center',
				editor : {
					type : 'datePicker',
					options : {
						format : 'YYYY/MM/dd',
						language: 'ko'
					} 
				}
			}]
		}); 
	
		mgrid = grid;
		
		$('#searchProductCode').click(function(event) {
			productCodeSearch(-1);
		});
		
		$('#searchCustomerCode').click(function(event) {
			customerCodeSearch(-1);
		});
	
	// option form reset  
	$("#reset").on("click", function() {
	         $("form").each(function() {  
	                if(this.id == "option") this.reset();  
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