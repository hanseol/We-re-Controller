<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="content-fluid">
	<div>
		<h2>입/출고목록조회</h2>
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
				<div class="col-md-3">
						일자
						<input type="date" id="dateGubun" name="dateGubun">
				</div>
				<div class="col-md-3">
						구분 &nbsp;
						<input type="checkbox" id="inGubun" name="gubun" value="1" checked>입고
						<input type="checkbox" id="outGubun" name="gubun" value="2">출고
				</div>
				<div class="col-md-3">
						제품명
						<input type="text" id="comProductName" name="comProductName">	
						<a id="searchProductCode" href="${pageContext.request.contextPath}/searchProductCode.do">						
                     	<i class="fa fa-search"></i></a>
				</div>
				<div class="col-md-3">
						완제품 LOT_NO
						<input type="text" id="proProcessLotNo" name="proProcessLotNo">	
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
$('#n9000000').addClass('active');
$('#subPages9000000').addClass('in');
$('#subPages9000000').attr('aria-expanded','true');
$('#subPages9000000').attr('style','');
$('.9035000').addClass('active');

let mgrid;
	$(document).ready(function() {	
		$(document).on("click", "button[id=search]",
				function() {
					var date = $("#dateGubun").val();
					var inGubun = $("#inGubun").val();
					var outGubun = $("#outGubun").val();
					var gubun;
					var productCode = $("#comProductName").val();
					var productLotNo = $("#proProcessLotNo").val();
					
					//체크박스 옵션
					if ($('input:checkbox[id="inGubun"]').is(":checked") && $('input:checkbox[id="outGubun"]').is(":checked") == true) {
						gubun = null;
					} else if ($('input:checkbox[id="inGubun"]').is(":checked") == true) {
						gubun = 'INOUT002';
					} else if ($('input:checkbox[id="outGubun"]').is(":checked") == true) {
						gubun = 'INOUT003';
					} else {
						gubun = null;
					}
										
					var readParams = {
						'salInoutDate' : date,
						'salInoutGubun' : gubun,
						'comProductName' : productCode,
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
	        bodyHeight :300, 
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
				header : '완제품 LOT_NO',
				name : 'proProcessLotNo'
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