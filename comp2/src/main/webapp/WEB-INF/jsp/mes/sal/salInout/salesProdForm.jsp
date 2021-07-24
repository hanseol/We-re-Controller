<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="content-fluid">
	<div>
		<h2>입/출고목록관리</h2>
	</div>
</div>

<!-- 관리, 지시 탭 이동 -->
<div class="tabs">
   <ul class="nav nav-tabs" role="tablist">
     <li class="tablinks active"><a href="#" onclick="tabgubun('ingrid');" aria-controls="tab1" role="tab" data-toggle="tab">입고</a></li>
     <li class="tablinks"><a href="#" onclick="tabgubun('outgrid');" aria-controls="tab2" role="tab" data-toggle="tab">출고</a></li>
   </ul>
</div>

<!------------------------------- 입고 -------------------------------------->
<div id="ingrid" class="tabcontent" style="display: block;">
<div class="content-fluid">
	<div>
		<div class="my-panel">
			<button type="button" class="btn btn-primary" id="inSearch">조회</button>
			<button type="button" class="btn btn-success" id="inReset">새자료</button>
		</div>
	</div>
</div>

<form id="option">
<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-body">
			<div class="row">
				<div class="col-md-4">
						일자
						<input type="date" id="dateGubun" name="dateGubun" class="form-control">
				</div>
				<div class="col-md-4">
						제품명
						<input type="text" id="comProductName" name="comProductName" class="form-control">	
						<a id="searchProductCode" href="${pageContext.request.contextPath}/searchProductCode.do">												
                     	<i class="fa fa-search"></i></a>
				</div>
				<div class="col-md-4">
						완제품 LOT_NO
						<input type="text" id="proProcessLotNo" name="proProcessLotNo" class="form-control">	
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
					<p class="panel-subtitle">완제품 입고 목록</p>
				</div>
				<div class="col-md-5" align="right">
					<button type="button" id="inAppendRow">추가</button>
					<button type="button" id="inDeleteRow">삭제</button>
					<button type="button" id="inModifyRow">저장</button>
				</div>
			</div>
			<div class="panel-body">
				<div id="grid"></div>
			</div>
		</div>
	</div>
</div>
</div>
<!------------------------------- //입고 -------------------------------------->

<!------------------------------- 출고 -------------------------------------->
<div id="outgrid" class="tabcontent" style="display: none;">
<div class="content-fluid">
	<div>
		<div class="my-panel">
			<button type="button" class="btn btn-primary" id="outSearch">조회</button>
			<button type="button" class="btn btn-success" id="outReset">새자료</button>
		</div>
	</div>
</div>

<form id="option">
<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-body">
			<div class="row">
				<div class="col-md-6">
						일자
						<input type="date" id="outDateGubun" name="outDateGubun" class="form-control">
				</div>
				<div class="col-md-6">
						제품명
						<input type="text" id="comProductName" name="comProductName" class="form-control">	
						<a id="outSearchProductCode" href="${pageContext.request.contextPath}/searchProductCode.do">												
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
					<p class="panel-subtitle">완제품 출고 목록</p>
				</div>
				<div class="col-md-5" align="right">
					<button type="button" id="outAppendRow">추가</button>
					<button type="button" id="outDeleteRow">삭제</button>
					<button type="button" id="outModifyRow">저장</button>
				</div>
			</div>
			<div class="panel-body">
				<div id="ogrid"></div>
			</div>
		</div>
	</div>
</div>
<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-heading">
			<div class="row">
				<div class="col-md-7">
					<p class="panel-subtitle">출고 세부 사항</p>
				</div>
				<div class="col-md-5" align="right">
					<button type="button" id="underModifyRow">저장</button>
				</div>
			</div>
			<div class="panel-body">
				<div id="ugrid"></div>
			</div>
		</div>
	</div>
</div>
</div>
<!------------------------------- //출고 -------------------------------------->

<!-- 추가 모달 -->
<a id="searchOrderCode" href="searchOrderCode.do" rel="modal:open"></a>
<a id="searchCustomerCode" href="searchCustomerCode.do"></a>
<a id="searchOrderList" href="searchOrderList.do"></a>

<script>

let mgrid; //모달그리드
let moGrid;
let muGrid;

var grid;
var ogrid;
var ugrid;

//----------------------------------------------------------------입고그리드-----------------------------------------------------------------
	$(document).ready(function() {
		//내비바 고정
		$('#n9000000').addClass('active');
		$('#subPages9000000').addClass('in');
		$('#subPages9000000').attr('aria-expanded','true');
		$('#subPages9000000').attr('style','');
		$('.9030000').addClass('active');
		
		//Read
		$("#inSearch").on("click", function() {
			var date = $("#dateGubun").val();
			var name = $("#comProductName").val();
			var lotno = $("#proProcessLotNo").val();
						
			var readParams = {
				'salInoutDate' : date,
				'comProductName' : name,
				'proProcessLotNo' : lotno
			};
			grid.readData(1, readParams, true);
		});
		
		//Insert
		$("#inAppendRow").on("click", function() {
			var rowData =[{
					salInoutDate : "",
					salInoutGubun : "",
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
		$("#inDeleteRow").on("click", function() {
			grid.removeCheckedRows(false);
		});
		
		//Modify
		$(document).on("click", "button[id=inModifyRow]", function() {
			grid.finishEditing('rowKey','columnName');
			grid.request('modifyData');
		});
		
		
		const dataSource = {
			api : {
				readData : {
					url : '${pageContext.request.contextPath}/ajax/sal/readSalInList',
					method : 'GET'
				},
				modifyData : {
					url : '${pageContext.request.contextPath}/ajax/sal/modifySalInList',
					method : 'PUT'
				}
			},
			initialRequest: false, 
			contentType : "application/json"
		};
		

		grid = new tui.Grid({
			el : document.getElementById('grid'),
			rowHeaders : [ 'checkbox' ],
			data : dataSource,
			scrollX: true,
	        scrollY: true,
	        bodyHeight :300, 
	        rowHeight: 30,
			columns : [ {
				header : '입고일자',
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
				editor : 'text',
				align : 'center'
			}, {
				header : '지시코드',
				name : 'salInoutCode',
				align : 'center'
			}, {
				header : '제품명',
				name : 'comProductName',
				align : 'center'
			}, {
				header : '입고수량',
				name : 'salInoutQuantity',
				align : 'right',
				formatter: (ev)=>{return (ev.value == null) ? null : String(ev.value).replace(/\B(?=(\d{3})+(?!\d))/g, ","); }
			}, {
				header : '전표번호',
				name : 'salInoutStatement',
				hidden : true
			}, {
				header : '입출고구분',
				name : 'salInoutGubun',
				hidden : true
			}, {
				header : '제품코드',
				name : 'comProductCode',
				hidden : true
			}]
		}); 
		

	 
//end ----------------------------------------------------------------입고그리드-----------------------------------------------------------------

//----------------------------------------------------------------출고그리드-----------------------------------------------------------------
		//---------------출고내역조회 그리드-----------------
		//Read
		$("#outSearch").on("click", function() {
					var date = $("#dateGubun").val();
					var name = $("#comProductName").val();
					var lotno = $("#proProcessLotNo").val();
										
					var readParams = {
						'salInoutDate' : date,
						'comProductName' : name,
						'proProcessLotNo' : lotno
					};
					
					ogrid.readData(1, readParams, true);
		});
		
		//Insert
		$("#outAppendRow").on("click", function() {
			var rowData =[{
					salInoutStatement : "",
					salInoutDate : "",
					erpOrderCode : "",
					erpCustomerName : "",
					erpProductName : "",
					erpOrderQty : "",
					erpCustomerCode : "",
					salWriteDate : "",
					salInoutCode : "",
					comProductCode : "",
					proProcessLotNo : ""
			}];
			ogrid.appendRow(rowData, {
				at : 0,
				focus : true
			});
			ogrid.enable();
		});
		
		//Delete
		$("#outDeleteRow").on("click", function() {
			ogrid.removeCheckedRows(false);
		});
		
		//Modify
		$(document).on("click", "button[id=outModifyRow]", function() {
			ogrid.finishEditing('rowKey','columnName');
			ogrid.request('modifyData');
		});
		
		
		const outdataSource = {
			api : {
				readData : {
					url : '${pageContext.request.contextPath}/ajax/sal/readSalOutList',
					method : 'GET'
				},
				modifyData : {
					url : '${pageContext.request.contextPath}/ajax/sal/modifySalOutList',
					method : 'PUT'
				}
			},
			initialRequest: false, 
			contentType : "application/json"
		};
		

		ogrid = new tui.Grid({
			el : document.getElementById('ogrid'),
			rowHeaders : [ 'checkbox' ],
			data : outdataSource,
			scrollX: true,
	        scrollY: true,
	        bodyHeight :150, 
	        rowHeight: 30,
			columns : [ {
				header : '출고일자',
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
				header : '주문코드',
				name : 'erpOrderCode',
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
				header : '고객사코드',
				name : 'erpCustomerCode',
				hidden : true
			}, {
				header : '제품코드',
				name : 'comProductCode',
				hidden : true
			}, {
				header : '로트넘버',
				name : 'proProcessLotNo',
				hidden : true
			}, {
				header : '전표번호',
				name : 'salInoutStatement',
				hidden : true
			}, {
				header : '수량',
				name : 'salNowQuantity',
				hidden : true
			}]
		});
		

		
		//---------------출고세부내역 그리드-----------------
		//Modify
		$(document).on("click", "button[id=underModifyRow]", function() {
			ugrid.finishEditing('rowKey','columnName');
			ugrid.request('modifyData');
		});

		const udataSource = {
				api : {
					readData : {
						url : '${pageContext.request.contextPath}/ajax/sal/underSalOut',
						method : 'GET'
					}, modifyData : {
						url : '${pageContext.request.contextPath}/ajax/sal/underSalModify',
						method : 'PUT'
					}
				},
				initialRequest: false, 
				contentType : "application/json"
			};
		
		ugrid = new tui.Grid({
				el : document.getElementById('ugrid'),
				rowHeaders : [ 'checkbox' ],
				data : udataSource,
				scrollX: true,
		        scrollY: true,
		        bodyHeight :150, 
		        rowHeight: 30,
				columns : [{
					header : '완제품 LOT_NO',
					name : 'proProcessLotNo',
					align : 'center',
					editor : 'text'
				}, {
					header : '현 재고',
					name : 'salNowQuantity',
					align : 'right',
					formatter: (ev)=>{return (ev.value == null) ? null : String(ev.value).replace(/\B(?=(\d{3})+(?!\d))/g, ","); }
				}, {
					header : '출고수량',
					name : 'salOutQuantity',
					align : 'right',
					editor : 'text',
					formatter: (ev)=>{return (ev.value == null) ? null : String(ev.value).replace(/\B(?=(\d{3})+(?!\d))/g, ","); }
				}, {
					header : '전표번호',
					name : 'salInoutStatement',
					hidden : true
				}],
				summary : {
		            height : 40,
		            position : 'bottom',
		            columnContent : {
		            	salOutQuantity : {
		                  template(val) {
		                	 formatter: (ev)=>{return (ev.value == null) ? null : String(ev.value).replace(/\B(?=(\d{3})+(?!\d))/g, ","); }
		                     return 'TOTAL : ' + val.sum;
		                  }
		               }
		            }
		         }
			}); 
		
		mgrid = grid;
		moGrid = ogrid;
		muGrid = ugrid;

//end ----------------------------------------------------------------출고그리드-----------------------------------------------------------------

//--------------------------------------------------------------------기타 실행 함수-----------------------------------------------------------------------------
		
		//input 태그 실행 이벤트
		//제품명
		$('#searchProductCode').click(function(event) {
			productCodeSearch(-1); //매개변수 -1로 함수 실행
		});
		$('#outSearchProductCode').click(function(event) {
			productCodeSearch(-1); //매개변수 -1로 함수 실행
		});
		
		
		//LOT_NO
		$('#searchProductLotNo').click(function(event) {
		 	productLotNoSearch(-1);
		});
		$('#outSearchProductLotNo').click(function(event) {
		 	productLotNoSearch(-1);
		});
		
		
		//입고 : lot_no 클릭 이벤트
		grid.on('dblclick', ev => {
		   if(ev.columnName == 'proProcessLotNo') {
		 	  	 productLotNoSearch(ev.rowKey);	    	  	 
		 	  }
		 });
	 
		
		//출고 : 주문코드 클릭 이벤트
		moGrid.on('dblclick', ev => {
			if(ev.columnName == 'erpOrderCode') {
				orderListSearch(ev.rowKey);
			}
		});
		
		//출고 : 체크 -> 정보 출고세부에 뿌려주기
		ogrid.on('dblclick', ev => {
		var i = ev.rowKey;
		if(ev.columnName == 'salInoutQuantity') {
	  		  var comProductCode = ogrid.getValue(i, 'comProductCode');	  		 	  		  
	  		  var readParams = {
	  				  'comProductCode' : comProductCode
	  		  }
	  		  ugrid.readData(1, readParams, true);
  	  		}
	 	});
		
		
	
	// option form reset  
	$("#inReset").on("click", function() {
	     $("form").each(function() {  
	      	if(this.id == "option") this.reset();  
	     });  
	});
	
	$("#outReset").on("click", function() {
	     $("form").each(function() {  
	      	if(this.id == "option") this.reset();  
	     });  
	});
	

});//end of document ready

//-------------------------------------------------모달 실행 함수----------------------------------------------------
	
	//모달 실행 함수
	var rowId;
	var orowId;
	var urowId;
	
	//입/출고 : 제품명 모달
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
	
	//입고 : 전체 완제품 LOT_NO 모달
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
	
	//출고 : ERP에서 주문 목록 받아오는 모달
	function orderListSearch(c) {
		orowId = c;
		event.preventDefault();
		$(".modal").remove();
		this.blur(); // Manually remove focus from clicked link.
		console.log(this.href);
		$.get("searchOrderList.do", function(html) {
			$(html).appendTo('body').modal();
		});
	}
	
	//출고 세부 : 입고된 완제품 LOT_NO 모달
	function modProductLotNoSearch(c) {
		urowId = c;
		event.preventDefault();
		$(".modal").remove();
		this.blur(); // Manually remove focus from clicked link.
		console.log(this.href);
		$.get("modSearchProductLotNo.do", function(html) {
		    $(html).appendTo('body').modal();
		});
	}
	
	//탭 이동
	function tabgubun(inout) {
		 var evt = window.event;
		  var i, tabcontent, tablinks;
		  tabcontent = document.getElementsByClassName("tabcontent");
		  for (i = 0; i < tabcontent.length; i++) {
		    tabcontent[i].style.display = "none";
		  }
		  tablinks = document.getElementsByClassName("tablinks");
		  for (i = 0; i < tablinks.length; i++) {
		    tablinks[i].className = tablinks[i].className.replace(" active", "");
		  }
		  document.getElementById(inout).style.display = "block";
		  evt.currentTarget.className += " active";
		  
		  if(inout == 'outgrid'){
		        ogrid.refreshLayout();
		        ugrid.refreshLayout();
		  } else if(inout == 'ingrid'){
		        grid.refreshLayout();
		  }
	}
	
	

	
</script>
