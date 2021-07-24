<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


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
				<div class="col-md-5" align="right">
					<button type="button" id="appendRow">추가</button>
					<button type="button" id="deleteRow">삭제</button>
					<button type="button" id="modifyRow">저장</button>
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
		$('#n9000000').addClass('active');
		$('#subPages9000000').addClass('in');
		$('#subPages9000000').attr('aria-expanded','true');
		$('#subPages9000000').attr('style','');
		$('.9040000').addClass('active');
		
		//Read
		$("#search").on("click", function() {
					var salInoutDate = $("#salInoutDate").val();
					var proProcessLotNo = $("#proProcessLotNo").val();
					var readParams = {
						'salInoutDate' : salInoutDate,
						'proProcessLotNo' : proProcessLotNo
					};
					grid.readData(1, readParams, true);
				});
		
		//Insert
		$("#appendRow").on("click", function() {
			var rowData =[{
					salInoutDate : "",
					salInoutCode : "",
					comProductCode : "",
					salInoutQuantity : "",
					proProcessLotNo : "",
					salWriteDate : ""
			}];
			grid.appendRow(rowData, {
				at : 0,
				focus : true
			});
			grid.enable();
		});
		
		//Delete
		$("#deleteRow").on("click", function() {
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
	        bodyHeight :300, 
	        rowHeight: 30,
			columns : [ {
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
				header : '완제품 LOT_NO',
				name : 'proProcessLotNo',
				align : 'center',
				editor : 'text'
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
				editor : 'text',
				formatter: (ev)=>{return (ev.value == null) ? null : String(ev.value).replace(/\B(?=(\d{3})+(?!\d))/g, ","); }
			}, {
				header : '최종 출고량',
				name : 'finalQuantity',
				align : 'right',
				formatter: (ev)=>{return (ev.value == null) ? null : String(ev.value).replace(/\B(?=(\d{3})+(?!\d))/g, ","); }
			}, {
				header : '전표번호',
				name : 'salInoutStatement',
				hidden : true
			}, {
				header : '고객사코드',
				name : 'salInoutCode',
				hidden : true
			}, {
				header : '제품코드',
				name : 'comProductCode',
				hidden : true
			}]
		}); 
	
		mgrid = grid;
		
		//수량 계산
  		mgrid.on('afterChange', ev => { 			
  			if (ev.changes[0].columnName == 'salNowQuantity') {
  				var ret = mgrid.getValue(ev.changes[0].rowKey, 'salNowQuantity');
  				var order = mgrid.getValue(ev.changes[0].rowKey, 'salInoutQuantity');	
  				
				mgrid.setValue(ev.changes[0].rowKey, 'finalQuantity', parseInt(order) - parseInt(ret));
  			}
		});
		

		//모달 : 완제품 LOT_NO
		   grid.on('dblclick', ev => {
		      if(ev.columnName == 'proProcessLotNo'){    
		    	 returnProductLotNo(ev.rowKey);         
		      }
		   });
		 
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


</script>