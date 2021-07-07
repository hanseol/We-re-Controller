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
						전표번호
						<input type="text" id="salInoutStatement" name="salInoutStatement">
						<a id="searchInoutStatement" href="searchInoutStatement.do" rel="modal:open">
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
let mgrid; //모달 그리드
	$(document).ready(function() {
		$(document).on("click", "button[id=search]",
				function() {
					var returnDate = $("#returnDate").val();
					var productCode = $("#productCode").val();
					var customerCode = $("#customerCode").val();
					var readParams = {
						'salInoutDate' : returnDate,
						'comProductCode' : productCode,
						'salInoutCode' : customerCode
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
				header : '전표번호',
				name : 'salInoutStatement',
			}, {
				header : '업체코드',
				name : 'salInoutCode',
			}, {
				header : '제품코드',
				name : 'comProductCode',
			}, {
				header : '수량',
				name : 'salInoutQuantity',
			}, {
				header : '작성일자',
				name : 'salWriteDate',
			}]
		}); 
	
		mgrid = grid;
		
		$('#searchInoutStatement').click(function(event) {
			 inoutStatementSearch(-1);
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

//전표번호 모달
function inoutStatementSearch(c) {
	  rowId = c;
	  event.preventDefault();
	  $(".modal").remove();
	  this.blur(); // Manually remove focus from clicked link.
	  console.log(this.href);
	  $.get("searchInoutStatement.do", function(html) {
	    $(html).appendTo('body').modal();
	  });
}

</script>