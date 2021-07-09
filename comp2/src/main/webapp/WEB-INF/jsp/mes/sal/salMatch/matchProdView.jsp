<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<div class="content-fluid">
	<div>
		<h2>정산입/출고목록조회</h2>
	</div>
</div>

<!-- 관리, 지시 탭 이동 -->
<div id="tabs">
   <ul class="nav nav-tabs" role="tablist">
     <li class=""><a onclick='location.href="matchProdForm.do"' aria-controls="tab1" role="tab" data-toggle="tab">관리</a></li>
     <li class="active"><a onclick='location.href="matchProdView.do"' aria-controls="tab2" role="tab" data-toggle="tab">조회</a></li>
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
						구분 &nbsp;
						<input type="checkbox" id="inMatch" name="gubun" value="1" checked>정산입고
						<input type="checkbox" id="outMatch" name="gubun" value="2">정산출고
				</div>
				<div class="col-md-3">
						제품코드
						<input type="text" id="productCode" name="productCode">	
						<a id="searchProductCode" href="${pageContext.request.contextPath}/searchProductCode.do">						
                     	<i class="fa fa-search"></i></a>
				</div>
				<div class="col-md-3">
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
					<p class="panel-subtitle">완제품 정산 입/출고 목록</p>
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
$('.matchProdView').addClass('active');

let mgrid;

	$(document).ready(function() {	
		$(document).on("click", "button[id=search]",
				function() {
					var date = $("#dateGubun").val();
					var inMatch = $("#inMatch").val();
					var outMatch = $("#outMatch").val();
					var gubun;
					var productCode = $("#productCode").val();
					var productLotNo = $("#productLotNo").val();
					
					//체크박스 옵션
					if ($('input:checkbox[id="inMatch"]').is(":checked") && $('input:checkbox[id="outMatch"]').is(":checked") == true) {
						gubun = null;
					} else if ($('input:checkbox[id="inMatch"]').is(":checked") == true) {
						gubun = 'INOUT004';
					} else if ($('input:checkbox[id="outMatch"]').is(":checked") == true) {
						gubun = 'INOUT005';
					} else {
						gubun = null;
					}
										
					var readParams = {
						'salMatchDate' : date,
						'salMatchInout' : gubun,
						'comProductCode' : productCode,
						'proProcessLotNo' : productLotNo
					};
					grid.readData(1, readParams, true);
				});
		
		const dataSource = {
			api : {
				readData : {
					url : '${pageContext.request.contextPath}/ajax/sal/readSalesMatch',
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
				name : 'salMatchDate',
				editor : {
					type : 'datePicker',
					options : {
						format : 'YYYY/MM/dd',
						language: 'ko'
					} 
				}
			},{
				header : '입/출고구분',
				name : 'salMatchInout'
			}, {
				header : '정산 전표번호',
				name : 'salMatchStatement'
			}, {
				header : '제품코드',
				name : 'comProductCode'
			}, {
				header : '제품명',
				name : 'comProductName'
			}, {
				header : '정산수량',
				name : 'salMatchQty'
			}, {
				header : '완제품 LOT_NO',
				name : 'proProcessLotNo'
			}, {
				header : '작성일자',
				name : 'salWriteDate'
			}]
		});
		
		mgrid = grid;
		 
		
		 $('#searchProductCode').click(function(event) {
				productCodeSearch(-1); //매개변수 -1로 함수 실행
			});
		 
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

//모달 실행 함수
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

</script>