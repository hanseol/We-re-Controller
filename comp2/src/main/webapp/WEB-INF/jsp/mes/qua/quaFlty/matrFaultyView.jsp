<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<div class="content-fluid">
	<div>
		<h2>자재불량조회</h2>
	</div>
</div>

<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-body">
			<div class="row">
				<form id="option">
					<div class="col-md-12">
						검사일자&nbsp;&nbsp;&nbsp;<input type="date" id="quaMaterialChkDate" name="quaMaterialChkDate" value="">&nbsp;~&nbsp;<input type="date" id="quaMaterialChkEndDate" name="quaMaterialChkEndDate" value="">	
					</div>
					<div class="col-md-12"><br/></div>
					<div class="col-md-3">
						발주검색&nbsp;&nbsp;&nbsp;<input type="text" id="orderCode" name="orderCode">	
						<a id="searchMatOrderCodeFlty" href="${pageContext.request.contextPath}/mat/order/searchMatOrderCodeFlty.do">
                     	<i class="fa fa-search"></i></a>
					</div>
					<div class="col-md-3">
						자재검색&nbsp;&nbsp;&nbsp;<input type="text" id="materialCode" name="materialCode">
						<a id="searchMaterialCode" href="searchMaterialCode.do">
						<i class="fa fa-search"></i></a>
					</div>
					<div class="col-md-3">
						업체검색&nbsp;&nbsp;&nbsp;<input type="text" id="vendorCode" name="vendorCode">
						<a id="searchVendorCode" href="${pageContext.request.contextPath}/mat/inout/searchVendorCode.do">
						<i class="fa fa-search"></i></a>
					</div>
				</form>
				<div class="col-md-3" align="right">
					<button type="button" class="btn btn-primary" id="search">조회</button>
					<button type="button" class="btn btn-success" id="reset">새자료</button>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-heading">
			<div class="row">
				<div class="col-md-7">
					<p class="panel-subtitle">자재 불량 목록</p>
				</div>
			</div>
			<div class="panel-body">
				<div id="grid"></div>
			</div>
		</div>
	</div>
</div>
<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-heading">
			<div class="row">
				<div class="col-md-7">
					<p class="panel-subtitle">불량 상세내역</p>
				</div>
			</div>
			<div class="panel-body">
				<div id="fltyGrid"></div>
			</div>
		</div>
	</div>
</div>

<script>

		

//그리드모달창을 위한 그리드 선언-------------------------------------
let materialGrid;
let orderGrid;
let vendorGrid;
//-----------------------------------------------------------


	$(document).ready(function() {
		
		//네비게이션 고정
		$('#n5000000').addClass('active');
		$('#subPages5000000').addClass('in');
		$('#subPages5000000').attr('aria-expanded','true');
		$('#subPages5000000').attr('style','');
		$('.5030000').addClass('active');
		
		
		// 옵션 폼 리셋버튼  
		$("#reset").click(function() { 
			$("form").each(function() {  
		    	if(this.id == "option") this.reset();
		    	grid.clear();
		    	fltyGrid.clear();
		    	
		    	$('#materialCode').val("");
		    	$('#vendorCode').val("");
		    	$('#orderCode').val("");
		    	});
			}); 

		
		//검색데이터 전송
		$("#search").on("click", function () {

					//데이터를 변수에 담아서 parameter로 만들기.
					
					var materialCode = $("#materialCode").val();
					var vendorCode = $("#vendorCode").val();
					var quaMaterialChkDate = $("#quaMaterialChkDate").val();
					var orderCode = $("#orderCode").val();
					var quaMaterialChkEndDate = $("#quaMaterialChkEndDate").val();
					

					var readParams = {
						'comMaterialCode' : materialCode,
						'erpVendorCode': vendorCode,
						'quaMaterialChkDate': quaMaterialChkDate,
						'erpMaterialOrderCode': orderCode,
						'quaMaterialChkEndDate' : quaMaterialChkEndDate
					};
					grid.readData(1, readParams, true);
					fltyGrid.clear();
				});
		
		
		const dataSource = {
			api : {
				readData : {
					url : '${pageContext.request.contextPath}/ajax/readQuaFlty',
					method : 'GET'
				}
			},
			initialRequest : false,
			contentType : "application/json"
		};
		
		//불량이 있는 발주 그리드
		const grid = new tui.Grid({
			el : document.getElementById('grid'),
			rowHeaders : [ 'checkbox' ],
			data : dataSource,
			scrollX: true,
	        scrollY: true,
	        bodyHeight: 250,
	        rowHeight: 30,
			columns : [ {
				header : '발주코드',
				name : 'erpMaterialOrderCode',
				validation: {
			           required:true
			        },
		        align : 'center'
			}, {
				header : '검사일자',
				name : 'quaMaterialChkDate',
		        align : 'center'
			}, {
				header: '업체명',
				name: 'comCodeDetailName',
		        align : 'center'
			}, {
				header: '자재명',
				name: 'materialName'
			}, {
				header : '발주량',
				name : 'erpMaterialOrderQty',
		        align : 'right',
	            formatter: (ev)=>{return (ev.value == null) ? null : String(ev.value).replace(/\B(?=(\d{3})+(?!\d))/g, ","); }
			}, {
				header: '단가(원)',
				name: 'erpMaterialUnitPrice',
	            formatter: (ev)=>{return (ev.value == null) ? null : String(ev.value).replace(/\B(?=(\d{3})+(?!\d))/g, ","); },
		        align : 'right'
			}, {
				header: '금액(원)',
				name: 'erpMaterialPrice',
	            formatter: (ev)=>{return (ev.value == null) ? null : String(ev.value).replace(/\B(?=(\d{3})+(?!\d))/g, ","); },
		        align : 'right'
			}, {
				header: '불량량',
				name: 'quaMaterialFQty',
		        align : 'right',
	            formatter: (ev)=>{return (ev.value == null) ? null : String(ev.value).replace(/\B(?=(\d{3})+(?!\d))/g, ","); }
			}]
		});
		
		
		//모달 그리드 초기화 ----------------------------------
				orderGrid = grid;
				vendorGrid = grid;
		//-------------------------------------------------

		
		
		
		const fltyDataSource = {
				api : {
					readData : {
						url : '${pageContext.request.contextPath}/ajax/readMatFltyDetail',
						method : 'GET'
					}
				},
				// 바로 값 나오지않게함
				initialRequest : false,
				contentType : "application/json"
			};
		
		
		//불량 그리드
		const fltyGrid = new tui.Grid({
			el : document.getElementById('fltyGrid'),
			rowHeaders : [ 'checkbox' ],
			data : fltyDataSource,
			scrollX: true,
	        scrollY: true,
	        bodyHeight: 150,
	        rowHeight: 30,
			columns : [ {
				header : '발주코드',
				name : 'erpMaterialOrderCode'
			}, {
				header: '자재코드',
				name: 'comMaterialCode'
			}, {
				header: '자재명',
				name: 'comMaterialName'
			}, {
				header : '자재불량코드',
				name : 'comMaterialFCode'
			}, {
				header : '불량명',
				name : 'comMaterialFName'
			}, {
				header : '불량량',
				name : 'quaMaterialFQty',
		        align : 'right',
	            formatter: (ev)=>{return (ev.value == null) ? null : String(ev.value).replace(/\B(?=(\d{3})+(?!\d))/g, ","); }
			}, {
				header: '단가',
				name: 'erpMaterialUnitPrice',
		        align : 'right',
	            formatter: (ev)=>{return (ev.value == null) ? null : String(ev.value).replace(/\B(?=(\d{3})+(?!\d))/g, ","); }
			}, {
				header: '청구금액',
				name: 'erpMatFltyPrice',
		        align : 'right',
	            formatter: (ev)=>{return (ev.value == null) ? null : String(ev.value).replace(/\B(?=(\d{3})+(?!\d))/g, ","); }
			}]
		});
		
//2번 그리드에 클릭한 발주코드에 해당하는 불량데이터 뿌려주기---------------------------------------------------		

 		grid.on('click', ev => {
			var rKey = ev.rowKey;
			var getOrderCode = grid.getValue(rKey, 'erpMaterialOrderCode');
			var readParams = {
					'erpMaterialOrderCode' : getOrderCode
			} 
			fltyGrid.readData(1, readParams, true);
		}); 
//--------------------------------------------------------------------------------------------		

		//날짜 범위 검색 옵션
		var start = $("#quaMaterialChkDate");
		var end = $("#quaMaterialChkEndDate");
		start.change(function(){
			if(end.val() == ""){
				end.val(start.val());
			}
		});
		end.change(function(){
			if(start.val() == ""){
				start.val(end.val());
			}
		});
		
		
		
		//발주코드 모달 로우아이디 값--------------------------------------
		//발주
		$('#searchMatOrderCodeFlty').click(function(event) {
			matOrderCodeSearch(-1);
		});
		
		//업체
		$('#searchVendorCode').click(function(event) {
			vendorCodeSearch(-1);
		});
		//불량
		$('#searchMatFltyCode').click(function(event) {
			matFltyCodeSearch(-1);
		});
		//자재
		$('#searchMaterialCode').click(function(event) {
			materialCodeSearch(-1);
		});
}); //end of document ready

//그리드모달 :모달페이지로 값 넘기기----------------------------------------
//발주
var matOrderRowId;
function matOrderCodeSearch(c) {
	matOrderRowId = c;
	  console.log(matOrderRowId);
	  event.preventDefault();
	  $(".modal").remove();
	  this.blur(); // Manually remove focus from clicked link.
	  console.log(this.href);
	  $.get("${pageContext.request.contextPath}/mat/order/searchMatOrderCodeFlty.do", function(html) {
	    $(html).appendTo('body').modal();
	  });
}
//자재
var materialRowId;
function materialCodeSearch(c) {
	materialRowId = c;
	  console.log(materialRowId);
	  event.preventDefault();
	  $(".modal").remove();
	  this.blur(); // Manually remove focus from clicked link.
	  console.log(this.href);
	  $.get("${pageContext.request.contextPath}/mat/inout/searchMaterialCode.do", function(html) {
	    $(html).appendTo('body').modal();
	  });
}
//업체
var vendorRowId;
function vendorCodeSearch(c) {
	vendorRowId = c;
	  console.log(vendorRowId);
	  event.preventDefault();
	  $(".modal").remove();
	  this.blur(); // Manually remove focus from clicked link.
	  console.log(this.href);
	  $.get("${pageContext.request.contextPath}/mat/inout/searchVendorCode.do", function(html) {
	    $(html).appendTo('body').modal();
	  });
}
//불량
/* var matFltyRowId;
function matFltyCodeSearch(c) {
	matFltyRowId = c;
	  console.log(matFltyRowId);
	  event.preventDefault();
	  $(".modal").remove();
	  this.blur(); // Manually remove focus from clicked link.
	  console.log(this.href);
	  $.get("${pageContext.request.contextPath}/qua/flty/searchMatFltyCode.do", function(html) {
	    $(html).appendTo('body').modal();
	  });
} */
//---------------------------------------------------------------


</script>