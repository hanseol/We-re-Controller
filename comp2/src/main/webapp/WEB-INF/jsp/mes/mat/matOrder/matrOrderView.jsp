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
		<h2>자재발주조회</h2>
	</div>
</div>

<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-body">
			<div class="row">
				<form id="option">
					<div class="col-md-3">
						발주일자<input type="date" id="erpMaterialOrderDate" name="erpMaterialOrderDate">~<input type="date" id="erpMaterialOrderEndDate" name="erpMaterialOrderEndDate">	
					</div>
					<div class="col-md-3">			
						발주코드
						<input type="text" id="orderCode" name="orderCode">	
						<a id="searchMatOrderCodePure" href="${pageContext.request.contextPath}/mat/order/searchMatOrderCodePure.do">
                     	<i class="fa fa-search"></i></a>
					</div>
					<div class="col-md-3">
						자재코드
						<input type="text" id="materialCode" name="materialCode">
						<a id="searchMaterialCode" href="${pageContext.request.contextPath}/mat/inout/searchMaterialCode.do">					
						
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

<script>
//네비게이션 바 고정.
$('#matNav').addClass('active');
$('#subPages3').addClass('in');
$('#subPages3').attr('aria-expanded','true');
$('#subPages3').attr('style','');
$('.matrOrder').addClass('active');


//그리드모달창을 위한 그리드 선언-------------------------------------
let orderGrid;
let materialGrid;
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
					var materialCode = $("#materialCode").val();
					var erpMaterialOrderDate = $("#erpMaterialOrderDate").val();
					var orderCode = $("#orderCode").val();
					var erpMaterialOrderEndDate = $("#erpMaterialOrderEndDate").val();

					var readParams = {
						'erpMaterialOrderEndDate' : erpMaterialOrderEndDate,
						'comMaterialCode': materialCode,
						'erpMaterialOrderDate': erpMaterialOrderDate,
						'erpMaterialOrderCode': orderCode
					};
					grid.readData(1, readParams, true);
				});
		
		const dataSource = {
			api : {
				readData : {
					url : '${pageContext.request.contextPath}/ajax/readMatOrder',
					method : 'GET'
				}
			},
			contentType : "application/json"
		};

		const grid = new tui.Grid({
			el : document.getElementById('grid'),
			rowHeaders : [ 'checkbox' ],
			data : dataSource,
			scrollX: true,
	        scrollY: true,
	        bodyHeight: 300,
	        rowHeight: 30,
			columns : [ {
				header : '발주일자',
				name : 'erpMaterialOrderDate',
				align : 'center'
			}, {
				header : '발주코드',
				name : 'erpMaterialOrderCode',
				align : 'center'
			}, {
				header: '거래처명',
				name: 'vendorName',
				align : 'center'
			}, {
				header: '자재코드',
				name: 'comMaterialCode',
				align : 'center'
			}, {
				header: '자재명',
				name: 'comMaterialName',
				align : 'center'
			}, {
				header: '규격',
				name: 'comMaterialSize',
				align : 'center'
			}, {
				header: '관리단위',
				name: 'comMaterialUnit',
				align : 'center'
			}, {
				header : '발주량',
				name : 'erpMaterialOrderQty',
				align : 'right'
			}, {
				header: '단가',
				name: 'erpMaterialUnitPrice',
				align : 'right'
			}, {
				header: '금액',
				name: 'erpMaterialPrice',
				align : 'right'
			}]
		});
		
		//모달 그리드 초기화 ----------------------------------
		orderGrid = grid;
		materialGrid = grid;
		//--------------------------------------------------
		
	//데이터 제이슨타입으로 보내기
 	grid.on('response', ev => {
		  const {response} = ev.xhr;
		  const responseObj = JSON.parse(response);

		  console.log('result : ', responseObj.result);
		  console.log('data : ', responseObj.data);
		});
	
	//날짜 범위 검색 옵션
	var start = $("#erpMaterialOrderDate");
	var end = $("#erpMaterialOrderEndDate");
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

	//자재
	$('#searchMaterialCode').click(function(event) {
		materialCodeSearch(-1);
	});
	//발주
	$('#searchMatOrderCodePure').click(function(event) {
		matOrderCodeSearch(-1);
	});
	
	
}); //end of document ready
//그리드모달 :모달페이지로 값 넘기기----------------------------------------
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

</script>