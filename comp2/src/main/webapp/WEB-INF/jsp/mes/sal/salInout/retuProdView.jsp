<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<div class="content-fluid">
	<div>
		<h2>반품목록조회</h2>
	</div>
</div>

<!-- 관리, 지시 탭 이동 -->
<div id="tabs">
   <ul class="nav nav-tabs" role="tablist">
     <li class=""><a onclick='location.href="retuProdForm.do"' aria-controls="tab1" role="tab" data-toggle="tab">관리</a></li>
     <li class="active"><a onclick='location.href="retuProdView.do"' aria-controls="tab2" role="tab" data-toggle="tab">조회</a></li>
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
			</div>
			<div class="panel-body">
				<div id="grid"></div>
			</div>
		</div>
	</div>
</div>

<script>
//내비바 고정
$('#salNav').addClass('active');
$('#subPages2').addClass('in');
$('#subPages2').attr('aria-expanded','true');
$('#subPages2').attr('style','');
$('.retuProdView').addClass('active');

let mgrid; //모달 그리드

	$(document).ready(function() {
		$(document).on("click", "button[id=search]",
				function() {
					var returnDate = $("#returnDate").val();
					var productCode = $("#productCode").val();
					var customerCode = $("#customerCode").val();
					var productLotNo = $("#productLotNo").val();
					console.log(returnDate, productLotNo);
					var readParams = {
						'salInoutDate' : returnDate,
						'comProductCode' : productCode,
						'salInoutCode' : customerCode,
						'proProcessLotNo' : productLotNo
					};
					grid.readData(1, readParams, true);
				});
		
		const dataSource = {
			api : {
				readData : {
					url : '${pageContext.request.contextPath}/ajax/sal/readReturnProduct',
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
				header : '반품 전표번호',
				name : 'salInoutStatement',
			}, {
				header : '완제품 LOT_NO',
				name : 'proProcessLotNo',
			}, {
				header : '업체코드',
				name : 'salInoutCode',
			}, {
				header : '제품코드',
				name : 'comProductCode',
			}, {
				header : '주문량',
				name : 'salInoutQuantity',
			}, {
				header : '반품량',
				name : 'returnQuantity',
			}, {
				header : '최종 출고량',
				name : 'finalQuantity',
			}, {
				header : '작성일자',
				name : 'salWriteDate',
			}]
		}); 
	
		mgrid = grid;
		
		
		$('#searchProductLotNo').click(function(event) {
		 	productLotNoSearch(-1);
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

//반품 수량 계산
function total() {
	var x = $('input[name=]')
}



</script>