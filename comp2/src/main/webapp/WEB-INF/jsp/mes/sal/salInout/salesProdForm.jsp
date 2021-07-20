<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script>
	$(document).ready(function(){
		function tabgubun(evt, inout) {
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
		}
	});
//탭키전환함수

</script>
<div class="content-fluid">
	<div>
		<h2>입/출고목록관리</h2>
	</div>
</div>

<!-- 관리, 지시 탭 이동 -->
<div class="tabs">
   <ul class="nav nav-tabs" role="tablist">
     <li class="tablinks active"><a href="javascript:void(0);" onclick="tabgubun(event, 'ingrid');" aria-controls="tab1" role="tab" data-toggle="tab">입고</a></li>
     <li class="tablinks"><a href="javascript:void(0);" onclick="tabgubun(event, 'outgrid');" aria-controls="tab2" role="tab" data-toggle="tab">출고</a></li>
   </ul>
</div>

<!------------------------------- 입고 -------------------------------------->
<div id="ingrid" class="tabcontent">
<div class="content-fluid">
	<div>
		<div class="my-panel">
			<button type="button" class="btn btn-success" id="search">조회</button>
			<button type="button" class="btn btn-danger" id="reset">새자료</button>
			<button type="button" class="btn btn-warning" id="modifyRow">저장</button>
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
					<p class="panel-subtitle">완제품 입고 목록</p>
				</div>
				<div class="col-md-5" align="right">
					<button type="button" id="appendRow">추가</button>
					<button type="button" id="deleteRow">삭제</button>
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
<div id="outgrid">
<div class="content-fluid">
	<div>
		<div class="my-panel">
			<button type="button" class="btn btn-success" id="search">조회</button>
			<button type="button" class="btn btn-danger" id="reset">새자료</button>
			<button type="button" class="btn btn-warning" id="modifyRow">저장</button>
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
					<p class="panel-subtitle">완제품 출고 목록</p>
				</div>
				<div class="col-md-5" align="right">
					<button type="button" id="appendRow">추가</button>
					<button type="button" id="deleteRow">삭제</button>
				</div>
			</div>
			<div class="panel-body">
				<div id="outListGrid"></div>
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
					<button type="button" id="uappendRow">추가</button>
					<button type="button" id="udeleteRow">삭제</button>
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
//내비바 고정
$('#n9000000').addClass('active');
$('#subPages9000000').addClass('in');
$('#subPages9000000').attr('aria-expanded','true');
$('#subPages9000000').attr('style','');
$('.9030000').addClass('active');


let mgrid; //모달그리드
let muGrid;

	$(document).ready(function() {
		//Read
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
						gubun = 'INOUT002';
					} else if ($('input:checkbox[id="outGubun"]').is(":checked") == true) {
						gubun = 'INOUT003';
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
		
		//Insert
		$(document).on("click", "button[id=appendRow]", function() {
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
		$(document).on("click", "button[id=deleteRow]", function() {
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
					url : '${pageContext.request.contextPath}/ajax/sal/readSalesProduct',
					method : 'GET'
				},
				modifyData : {
					url : '${pageContext.request.contextPath}/ajax/modifySalInoutList',
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
	        bodyHeight :150, 
	        rowHeight: 30,
			columns : [ {
				header : '입고일자',
				name : 'salInoutDate',
				editor : {
					type : 'datePicker',
					options : {
						format : 'YYYY/MM/dd',
						language: 'ko'
					} 
				}
			}, {
				header : '입/출고구분',
				name : 'salInoutGubun',
				editor : {
					type: 'select',
					options : {
					listItems: [
						{text : '입고', value : 'INOUT002'},
						{text : '출고', value : 'INOUT003'}
						]
					}
				}
			}, {
				header : '완제품 LOT_NO/주문코드',
				name : 'proProcessLotNo',
				editor : 'text'
			}, {
				header : '지시코드',
				name : 'salInoutCode'
			}, {
				header : '제품코드',
				name : 'comProductCode'
			}, {
				header : '입고수량',
				name : 'salInoutQuantity',
				formatter: (ev)=>{return (ev.value == null) ? null : String(ev.value).replace(/\B(?=(\d{3})+(?!\d))/g, ","); }
			}, {
				header : '전표번호',
				name : 'salInoutStatement',
				hidden : true
			}]
		}); 
		
	 mgrid = grid;
	 
	//------------------------------------------------------△입고그리드 / 출고그리드▽ --------------------------------------------------------------------------
		$(document).ready(function() {
		//Read
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
						gubun = 'INOUT002';
					} else if ($('input:checkbox[id="outGubun"]').is(":checked") == true) {
						gubun = 'INOUT003';
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
		
		//Insert
		$(document).on("click", "button[id=appendRow]", function() {
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
		$(document).on("click", "button[id=deleteRow]", function() {
			grid.removeCheckedRows(false);
		});
		
		//Modify
		$(document).on("click", "button[id=modifyRow]", function() {
			grid.finishEditing('rowKey','columnName');
			grid.request('modifyData');
		});
		
		
		const outdataSource = {
			api : {
				readData : {
					url : '${pageContext.request.contextPath}/ajax/sal/readSalesProduct',
					method : 'GET'
				},
				modifyData : {
					url : '${pageContext.request.contextPath}/ajax/modifySalInoutList',
					method : 'PUT'
				}
			},
			initialRequest: false, 
			contentType : "application/json"
		};
		

		const outListGrid = new tui.Grid({
			el : document.getElementById('outListGrid'),
			rowHeaders : [ 'checkbox' ],
			data : outdataSource,
			scrollX: true,
	        scrollY: true,
	        bodyHeight :150, 
	        rowHeight: 30,
			columns : [ {
				header : '출고일자',
				name : 'salInoutDate',
				editor : {
					type : 'datePicker',
					options : {
						format : 'YYYY/MM/dd',
						language: 'ko'
					} 
				}
			}, {
				header : '주문코드',
				name : 'proProcessLotNo',
				editor : 'text'
			}, {
				header : '거래처코드',
				name : 'salInoutCode'
			}, {
				header : '제품코드',
				name : 'comProductCode'
			}, {
				header : '출고수량',
				name : 'salInoutQuantity',
				formatter: (ev)=>{return (ev.value == null) ? null : String(ev.value).replace(/\B(?=(\d{3})+(?!\d))/g, ","); }
			}, {
				header : '전표번호',
				name : 'salInoutStatement',
				hidden : true
			}]
		}); 	
	
		
		
		//출고세부그리드
		const udataSource = {
				api : {
					readData : {
						url : '${pageContext.request.contextPath}/ajax/insertSalOutList',
						method : 'GET'
					}
				},
				initialRequest: false, 
				contentType : "application/json"
			};
		
		const ugrid = new tui.Grid({
				el : document.getElementById('ugrid'),
				rowHeaders : [ 'checkbox' ],
				data : udataSource,
				scrollX: true,
		        scrollY: true,
		        bodyHeight :150, 
		        rowHeight: 30,
				columns : [{
					header : '주문코드',
					name : 'erpOrderCode',
					align : 'center',
					hidden : true
				}, {
					header : '완제품 LOT_NO',
					name : 'proProcessLotNo',
					editor : 'text'
				}, {
					header : '현재고',
					name : 'salNowQuantity',
					formatter: (ev)=>{return (ev.value == null) ? null : String(ev.value).replace(/\B(?=(\d{3})+(?!\d))/g, ","); }
				}, {
					header : '출고수량',
					name : 'salOutQuantity',
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
		                     return 'TOTAL : ' + val.sum;
		                  }
		               }
		            }
		         }
			}); 
		muGrid = ugrid;
	
	 
	 $('#searchProductCode').click(function(event) {
			productCodeSearch(-1); //매개변수 -1로 함수 실행
		});
		
	 //모달 : 완제품 LOT_NO
	   grid.on('dblclick', ev => {
		  var i = ev.rowKey;
	      if(ev.columnName == 'proProcessLotNo') {
	    	  if(grid.getValue(i, 'salInoutGubun') == null) {
	    		  alert('입고/출고를 먼저 구분해주세요.');
	    	  } else if(grid.getValue(i, 'salInoutGubun') == 'INOUT002') {
	    	  	 productLotNoSearch(ev.rowKey);	    	  	 
	    	  } else if(grid.getValue(i, 'salInoutGubun') == 'INOUT003') {
	    		  orderListSearch(ev.rowKey); 
	    	  } 
	    	}
	   });
	 
	 muGrid.on('dblclick', ev => {
		if(ev.columnName == 'proProcessLotNo') {
			modProductLotNoSearch(ev.rowKey);
		} else if(ev.columnName == 'erpOrderCode') {
			orderListSearch(ev.rowKey); 
		}
	 });
	 
	 
	 grid.on('dblclick', ev => {
		var j = ev.rowKey;
		if(ev.columnName == 'salInoutQuantity') {
			if(grid.getValue(j, 'salInoutGubun') == 'INOUT003' && grid.getValue(j, 'salInoutQuantity') != null) {
	  		  var proProcessLotNo = grid.getValue(j, 'proProcessLotNo');
	  		  var comProductCode = grid.getValue(j, 'comProductCode');
	  		  var salInoutQuantity = grid.getValue(j, 'salInoutQuantity');
	  		 	  		  
	  		  var readParams = {
	  				  'proProcessLotNo' : proProcessLotNo,
	  				  'comProductCode' : comProductCode,
	  				  'salInoutQuantity' : salInoutQuantity
	  		  }
	  		  
	  		  ugrid.readData(1, readParams, true);
  	  		}
		}
	 });
	 
		$('#searchProductLotNo').click(function(event) {
		 	productLotNoSearch(-1);
		});
	
	
		
	// option form reset  
	 $("#reset").click(function() {  
	         $("form").each(function() {  
	                if(this.id == "option") this.reset();  
	             });  
	 });
	
}); //end of document ready
	
	
	//모달 실행 함수
	var rowId;
	var urowId;
	
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
	
	//입고 : 완제품 LOT_NO 모달
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
	
	//출고 : 완제품 LOT_NO 값 받아오는 모달
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
	
	//출고 : ERP에서 주문 목록 받아오는 모달
	function orderListSearch(c) {
		rowId = c;
		event.preventDefault();
		$(".modal").remove();
		this.blur(); // Manually remove focus from clicked link.
		console.log(this.href);
		$.get("searchOrderList.do", function(html) {
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
});


</script>