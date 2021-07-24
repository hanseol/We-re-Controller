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
			<button type="button" class="btn btn-primary" id="search">조회</button>
			<button type="button" class="btn btn-success" id="reset">새자료</button>
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
						<input type="date" id="salInoutDate" name="salInoutDate" class="form-control">			
				</div>
				<div class="col-md-6">
						완제품 LOT_NO
						<input type="text" id="proProcessLotNo" name="proProcessLotNo" class="form-control">	
						<a id="searchReturnProduct" href="${pageContext.request.contextPath}/searchReturnList.do">						
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


let mgrid; //모달 그리드
	$(document).ready(function() {
		$('#n9000000').addClass('active');
		$('#subPages9000000').addClass('in');
		$('#subPages9000000').attr('aria-expanded','true');
		$('#subPages9000000').attr('style','');
		$('.9040000').addClass('active');
		
		$("#search").on("click", function() {
					var salInoutDate = $("#salInoutDate").val();
					var proProcessLotNo = $("#proProcessLotNo").val();
					var readParams = {
						'salInoutDate' : salInoutDate,
						'proProcessLotNo' : proProcessLotNo
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
	        bodyHeight :300, 
	        rowHeight: 30,
			columns : [{
				header : '반품일자',
				name : 'salInoutDate',
				align : 'center',
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
				align : 'center'
			}, {
				header : '완제품 LOT_NO',
				name : 'proProcessLotNo',
				align : 'center'
			}, {
				header : '고객사명',
				name : 'comCustomerName',
				align : 'center'
			}, {
				header : '제품명',
				name : 'comProductName',
				align : 'center'
			}, {
				header : '주문량',
				name : 'salInoutQuantity',
				align : 'right',
				formatter: (ev)=>{return (ev.value == null) ? null : String(ev.value).replace(/\B(?=(\d{3})+(?!\d))/g, ","); }
			}, {
				header : '반품량',
				name : 'salNowQuantity',
				align : 'right',
				formatter: (ev)=>{return (ev.value == null) ? null : String(ev.value).replace(/\B(?=(\d{3})+(?!\d))/g, ","); }
			}, {
				header : '최종 출고량',
				name : 'finalQuantity',
				align : 'right',
				formatter: (ev)=>{return (ev.value == null) ? null : String(ev.value).replace(/\B(?=(\d{3})+(?!\d))/g, ","); }
			}, {
				header : '작성일자',
				name : 'salWriteDate',
				align : 'center'
			}]
		}); 
	
		mgrid = grid;
		
		
		$('#searchReturnProduct').click(function(event) {
			returnProductLotNo(-1);
		});
	
	// option form reset  
	    $("#reset").click(function() {  
	         $("form").each(function() {  
	                if(this.id == "option") this.reset();  
	             });  
	    });  
	
}); //end of document ready

var rowId;

//완제품 LOT_NO 모달
function returnProductLotNo(c) {
	  rowId = c;
	  event.preventDefault();
	  $(".modal").remove();
	  this.blur(); // Manually remove focus from clicked link.
	  console.log(this.href);
	  $.get("searchReturnList.do", function(html) {
	    $(html).appendTo('body').modal();
	  });
}

//반품 수량 계산
function total() {
	var x = $('input[name=]')
}



</script>