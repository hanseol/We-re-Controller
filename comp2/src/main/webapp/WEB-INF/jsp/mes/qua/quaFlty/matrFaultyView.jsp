<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

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
		<h2>자재불량조회</h2>
	</div>
</div>

<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-body">
			<div class="row">
				<form id="option">
					<div class="col-md-3">
						검사일자<input type="date" id="quaMaterialChkDate" name="quaMaterialChkDate" value="">~<input type="date" id="quaMaterialChkEndDate" name="quaMaterialChkEndDate" value="">	
					</div>
					<div class="col-md-3">
						발주코드
						<input type="text" id="orderCode" name="orderCode">	
						<a id="searchMatOrderCodePure" href="${pageContext.request.contextPath}/mat/order/searchMatOrderCodePure.do">
                     	<i class="fa fa-search"></i></a>
					</div>
					<div class="col-md-3">
						입고업체<input type="text" id="vendorCode" name="vendorCode">
						<a id="searchVendorCode" href="${pageContext.request.contextPath}/mat/inout/searchVendorCode.do">
						<i class="fa fa-search"></i></a>
					</div>
				</form>
				<div class="col-md-3" align="right">
					<button type="button" class="btn btn-success" id="search">조회</button>
					<button type="button" class="btn btn-danger" id="reset">새자료</button>
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
					<p class="panel-subtitle">자재 발주 목록</p>
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
					<p class="panel-subtitle">자재 불량 목록</p>
				</div>
			</div>
			<div class="panel-body">
				<div id="fltyGrid"></div>
			</div>
		</div>
	</div>
</div>

<script>
//네비게이션 고정
$('#quaNav').addClass('active');
$('#subPages6').addClass('in');
$('#subPages6').attr('aria-expanded','true');
$('#subPages6').attr('style','');
$('.matrFaulty').addClass('active');
		

//그리드모달창을 위한 그리드 선언-------------------------------------
let orderGrid;
let vendorGrid;
//-----------------------------------------------------------


	$(document).ready(function() {
		
		// 옵션 폼 리셋버튼  
		$("#reset").click(function() { 
			location.reload(true);
			}); 

		
		//검색데이터 전송
		$(document).on("click",	"button[id=search]",
				function () {

					//데이터를 변수에 담아서 parameter로 만들기.
					var vendorCode = $("#vendorCode").val();
					var quaMaterialChkDate = $("#quaMaterialChkDate").val();
					var orderCode = $("#orderCode").val();
					var quaMaterialChkEndDate = $("#quaMaterialChkEndDate").val();
					

					var readParams = {
						'erpVendorCode': vendorCode,
						'quaMaterialChkDate': quaMaterialChkDate,
						'erpMaterialOrderCode': orderCode,
						'quaMaterialChkEndDate' : quaMaterialChkEndDate
					};
					grid.readData(1, readParams, true);
				});
		
		
		const dataSource = {
			api : {
				readData : {
					url : '${pageContext.request.contextPath}/ajax/readQuaFlty',
					method : 'GET'
				}
			},
			contentType : "application/json"
		};
		
		//불량이 있는 발주 그리드
		const grid = new tui.Grid({
			el : document.getElementById('grid'),
			rowHeaders : [ 'checkbox' ],
			data : dataSource,
			scrollX: true,
	        scrollY: true,
	        bodyHeight: 300,
	        rowHeight: 30,
			columns : [ {
				header : '발주코드',
				name : 'erpMaterialOrderCode',
				validation: {
			           required:true
			        }
			}, {
				header : '검사일자',
				name : 'quaMaterialChkDate'
			}, {
				header: '업체코드',
				name: 'erpVendorCode'
			}, {
				header: '발주업체명',
				name: 'comCodeDetailName'
			}, {
				header : '발주량',
				name : 'erpMaterialOrderQty'
			}, {
				header: '단가',
				name: 'erpMaterialUnitPrice'
			}, {
				header: '금액',
				name: 'erpMaterialPrice'
			}, {
				header: '불량량',
				name: 'quaMaterialFQty'
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
				name : 'quaMaterialFQty'
			}, {
				header: '단가',
				name: 'erpMaterialUnitPrice'
			}, {
				header: '청구금액',
				name: 'erpMatFltyPrice'
			}]
		});
		
//2번 그리드에 클릭한 발주코드에 해당하는 불량데이터 뿌려주기---------------------------------------------------		
		grid.on('click', ev => {
			if(ev.columnName == 'erpMaterialOrderCode'){

				//데이터 넘겨주기.
				var materialOrderCode = grid.getFocusedCell().value;
				var matFltyCode = $("#matFltyCode").val();
				var readParams = {
						'erpMaterialOrderCode' : materialOrderCode,
						'comMaterialFCode' : matFltyCode
				} 
				fltyGrid.readData(1, readParams, true);
				console.log(readData);
				
			}
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
		
		
		// 그리드 테마
		tui.Grid.applyTheme('clean', 
			{
				row: {
		       		hover: {
		       			background: "#DFEFF7"
		       		}
				},
				cell: {
					header: {
						background: "#D5ECED"
					},
					currentRow : {
						background: "#d5dae1"
					}
				}
		});
		
		
		//발주코드 모달 로우아이디 값--------------------------------------
		//발주
		$('#searchMatOrderCodePure').click(function(event) {
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
	  $.get("${pageContext.request.contextPath}/mat/order/searchMatOrderCodePure.do", function(html) {
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