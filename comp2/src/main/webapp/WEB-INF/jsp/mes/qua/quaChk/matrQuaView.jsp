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

.modal {
	-webkit-border-radius: 0px;
	border-radius: 0px;
	overflow: visible;
	text-align: center;
	max-width: 900px;
	width: 900px;
	/* height: 600px;
		max-height: 600px; */
}

.blocker {
	z-index: 1200;
}
</style>

<div class="content-fluid">
	<div>
		<h2>자재입고검사조회</h2>
	</div>
</div>

<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-body">
			<div class="row">
				<div class="col-md-12" align="right">
					<button type="button" class="btn btn-danger" id="reset">새자료</button>
				</div>			
				<div class="col-md-12">
					<p class="panel-subtitle">자재 발주 목록</p>
				</div>
				<form id="option">
					<div class="col-md-3">
						입고일자<input type="date" id="materialDate" name="materialDate"> ~ <input type="date" id="materialEndDate" name="materialEndDate">
					</div>
					<div class="col-md-3">
						자재검색<input type="text" id="materialCode" name="materialCode">
						<a id="searchMaterialCode" href="${pageContext.request.contextPath}/mat/inout/searchMaterialCode.do">
						<i class="fa fa-search"></i></a>
					</div>
					<div class="col-md-3">
						업체검색<input type="text" id="vendorCode" name="vendorCode">
						<a id="searchVendorCode" href="${pageContext.request.contextPath}/mat/inout/searchVendorCode.do">
						<i class="fa fa-search"></i></a>
					</div>
				</form>
				<div class="col-md-3" align="right">
					<button type="button" class="btn btn-success" id="search">조회</button>
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
		<div class="panel-body">
			<div class="row">
				<div class="col-md-12">
					<p class="panel-subtitle">검사 완료 목록</p>
				</div>
				<form id="option">
					<div class="col-md-3">
						검사일자<input type="date" id="quaChkDate" name="quaChkDate"> ~ <input type="date" id="quaChkEndDate" name="quaChkEndDate">
					</div>
					<div class="col-md-3">
						자재검색<input type="text" id="materialCodeTwo" name="materialCodeTwo">
						<a id="searchMaterialCodeTwo" href="${pageContext.request.contextPath}/mat/inout/searchMaterialCode.do">
						<i class="fa fa-search"></i></a>
					</div>
					<div class="col-md-3">
						업체검색<input type="text" id="vendorCodeTwo" name="vendorCodeTwo">
						<a id="searchVendorCodeTwo" href="${pageContext.request.contextPath}/mat/inout/searchVendorCode.do">
						<i class="fa fa-search"></i></a>
					</div>
				</form>
				<div class="col-md-3" align="right">
					<button type="button" class="btn btn-success" id="searchPass">조회</button>
				</div>
			</div>
			<div class="panel-body">
				<div id="passGrid"></div>
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
$('.matrQua').addClass('active');

//그리드모달창을 위한 그리드 선언-------------------------------------
let orderGrid;
let materialGrid;
let vendorGrid;
let matFltyGrid;
let materialTwoGrid;
let vendorTwoGrid;
//-----------------------------------------------------------
let erpMaterialOrderCode;
//=======================================그리드1 버튼설정===========================================	
	$(document).ready(function () {
			
			// 옵션 폼 리셋버튼  
			$("#reset").click(function() { 
				$("form").each(function() {  
			    	if(this.id == "option") this.reset();
			    	grid.clear();
			    	passGrid.clear();
			    	
			    	$('#materialCode').val("");
			    	$('#vendorCode').val("");
			    	
			    	});
				}); 
		
		//그리드1 [조회]버튼
		$("#search").on("click", function () {

			//데이터를 변수에 담아서 parameter로 만들기.
			var materialDate = $("#materialDate").val();
			var materialCode = $("#materialCode").val();
			var vendorCode = $("#vendorCode").val();
			var materialEndDate = $("#materialEndDate").val();

			var readParams = {
				'quaMaterialDate' : materialDate,
				'comMaterialCode': materialCode,
				'erpVendorCode': vendorCode,
				'quaMaterialEndDate' : materialEndDate
			};
			grid.readData(1, readParams, true);
			
		});
		

		
//=======================================그리드2 버튼설정===========================================		
		//그리드2 [조회]버튼
		$("#searchPass").on("click", function () {

			//데이터를 변수에 담아서 parameter로 만들기.
			var quaChkDate = $("#quaChkDate").val();
			var materialCodeTwo = $("#materialCodeTwo").val();
			var vendorCodeTwo = $("#vendorCodeTwo").val();
			var quaChkEndDate = $("#quaChkEndDate").val();

			var readParams = {
				'quaMaterialDate' : quaChkDate,
				'comMaterialCode': materialCodeTwo,
				'erpVendorCode': vendorCodeTwo,
				'quaMaterialEndDate' : quaChkEndDate
			};
			passGrid.readData(1, readParams, true);
			
		});
		
		




	const dataSource = {
		api: {
			readData: {
				url: '${pageContext.request.contextPath}/ajax/readQuaChk',
				method: 'GET'
			}

		},
		// 바로 값 나오지않게함
		//initialRequest : false,
		contentType: "application/json"
	};

	const grid = new tui.Grid({
		el: document.getElementById('grid'),
		rowHeaders: ['checkbox'],
		data: dataSource,
		scrollX: true,
        scrollY: true,
        bodyHeight :300,
        rowHeight: 30,
		columns: [{
			header: '발주코드',
			name: 'erpMaterialOrderCode',
			align: 'center'
		}, {
			header: '입고일자',
			name: 'quaMaterialDate',
			align: 'center'
		}, {
			header: '업체코드',
			name: 'erpVendorCode',
			align: 'center',
			hidden: true
		}, {
			header: '업체명',
			name: 'comCodeDetailName',
			align: 'center'
		}, {
			header: '자재코드',
			name: 'comMaterialCode',
			align: 'center',
			hidden: true
		}, {
			header: '자재명',
			name: 'comMaterialName',
			align: 'center'
		}, {
			header: '규격',
			name: 'comMaterialSize',
			align: 'center'
		}, {
			header: '관리단위',
			name: 'comMaterialUnit',
			align: 'center'
		}, {
			header: '발주량',
			name: 'erpMaterialOrderQty',
			align : 'right'
		}, {
			header: '합격량',
			name: 'quaMaterialPQty',
			align : 'right'
		}, {
			header: '불량량',
			name: 'quaMaterialFQty',
			align : 'right'
		}, {
			header: '불량코드',
			name: 'comMaterialFCode',
			align: 'center'
			
		}, {
			header: '단가(원)',
			name: 'erpMaterialUnitPrice',
			align : 'right',
            formatter: (ev)=>{return (ev.value == null) ? null : String(ev.value).replace(/\B(?=(\d{3})+(?!\d))/g, ","); }
		}, {
			header: '금액(원)',
			name: 'erpMaterialPrice',
			align : 'right',
            formatter: (ev)=>{return (ev.value == null) ? null : String(ev.value).replace(/\B(?=(\d{3})+(?!\d))/g, ","); }
		}, {
			header: '검사유무',
			name: 'quaMaterialChk',
			align : 'center'
			
		}, {
			header: '검사일자',
			name: 'quaMaterialChkDate',
			hidden: true
		}, {
			header: '전표',
			name: 'quaMaterialStatement',
			hidden: true
		}]
	});
//모달 그리드 초기화 ----------------------------------
	orderGrid = grid;
	materialGrid = grid;
	vendorGrid = grid;
	matFltyGrid = grid;
//--------------------------------------------------

	//합격해서 입고된 자재만 등록하는 그리드 데이터
	const passDataSource = {
			api: {
				readData: {
					url: '${pageContext.request.contextPath}/ajax/readQuaChkPass',
					method: 'GET'
				},
				modifyData: {
					url: '${pageContext.request.contextPath}/ajax/modifyQuaChk',
					method: 'PUT'
				}

			},
			// 리스트에 값이 바로 나오지않도록 함.
			/* initialRequest : false, */
			contentType: "application/json"
		};
	//검사완료한  자재 조회
	const passGrid = new tui.Grid({
		el: document.getElementById('passGrid'),
		rowHeaders: ['checkbox'],
		data: passDataSource,
		scrollX: true,
        scrollY: true,
        bodyHeight: 300, 
        rowHeight: 30,
        

		columns: [{
			header: '발주코드',
			name: 'erpMaterialOrderCode',
			align: 'center'
		}, {
			header: '검사일자',
			name: 'quaMaterialChkDate',
			align: 'center',
		}, {
			header: '입고일자',
			name: 'quaMaterialDate',
			align: 'center'
		}, {
			header: '업체코드',
			name: 'erpVendorCode',
			align: 'center',
			hidden: true
		}, {
			header: '업체명',
			name: 'comCodeDetailName',
			align: 'center'
		}, {
			header: '자재코드',
			name: 'comMaterialCode',
			align: 'center',
			hidden: true
		}, {
			header: '자재명',
			name: 'comMaterialName',
			align: 'center'
		}, {
			header: '규격',
			name: 'comMaterialSize',
			align: 'center'
		}, {
			header: '관리단위',
			name: 'comMaterialUnit',
			align: 'center'
		}, {
			header: '발주량',
			name: 'erpMaterialOrderQty',
			align : 'right'
		}, {
			header: '합격량',
			name: 'quaMaterialPQty',
			align : 'right'
		}, {
			header: '불량량',
			name: 'quaMaterialFQty',
			align : 'right'
		}, {
			header: '단가(원)',
			name: 'erpMaterialUnitPrice',
			align : 'right',
            formatter: (ev)=>{return (ev.value == null) ? null : String(ev.value).replace(/\B(?=(\d{3})+(?!\d))/g, ","); }
		}, {
			header: '금액(원)',
			name: 'erpMaterialPrice',
			align : 'right',
            formatter: (ev)=>{return (ev.value == null) ? null : String(ev.value).replace(/\B(?=(\d{3})+(?!\d))/g, ","); }
		}]
	});
	//그리드2 모달그리드 선언 초기화-----------------------------------------------------
	materialTwoGrid = passGrid;
	vendorTwoGrid = passGrid;
	
/* 	//자동 계산 (조회페이지는 필요없음)
		grid.on('afterChange',ev => {
			//합격량
			var pQty = grid.getValue( ev.changes[0].rowKey, 'quaMaterialPQty');
			//발주량
		var oQty = grid.getValue( ev.changes[0].rowKey, 'erpMaterialOrderQty');
			//불량량
		var fQty = grid.getValue( ev.changes[0].rowKey, 'quaMaterialFQty');
			//단가
		var uQty = grid.getValue( ev.changes[0].rowKey, 'erpMaterialUnitPrice');
		//합격량(발주량-불량량)
		grid.setValue( ev.changes[0].rowKey, 'quaMaterialPQty', oQty-fQty);
		//금액(발주량*단가)
		grid.setValue( ev.changes[0].rowKey, 'erpMaterialPrice', oQty*uQty);
		
		//불량량에 값이 존재할 경우 불량코드 활성화
		if((fQty == null)||(fQty == '0')) {
			grid.setValue( ev.changes[0].rowKey, 'comMaterialFCode', '');
		}
	}); */
	//그리드 모달 더블클릭--------------------------------------------------
/* 	//발주
	grid.on('dblclick', ev => {
		if(ev.columnName == 'erpMaterialOrderCode'){
			matOrderCodeSearch(ev.rowKey);
		}

	}); */		
	
/*  //업체
	grid.on('dblclick', ev => {
		if(ev.columnName == 'erpVendorCode'){
			vendorCodeSearch(ev.rowKey);
		}

	}); */
/*  //자재
	grid.on('dblclick', ev =>{
		if(ev.columnName == 'comMaterialCode'){
			materialCodeSearch(ev.rowKey);
		}
	}); */
	//불량
/* 		grid.on('dblclick', ev =>{
		if(ev.columnName == 'quaMaterialFQty'){
			matFltyCodeSearch(ev.rowKey);
		}
	}); */
	
//-----------------------------------------------------------------
	
	
		//날짜 범위 검색 옵션(그리드1)
		var start = $("#materialDate");
		var end = $("#materialEndDate");
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
	
		//날짜 범위 검색 옵션(그리드2)
		var start = $("#quaChkDate");
		var end = $("#quaChkEndDate");
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
	//---------------------------그리드1
	//발주
	$('#searchMatOrderCode').click(function(event) {
		matOrderCodeSearch(-1);
	});
	//자재
	$('#searchMaterialCode').click(function(event) {
		materialCodeSearch(-1);
	});
		//불량
	$('#searchMatFltyCode').click(function(event) {
		matFltyCodeSearch(-1);
	});
		//---------------------------그리드2
	//그리드2 자재
	$('#searchMaterialCodeTwo').click(function(event) {
		materialCodeSearch(-2);
	});
	//그리드2 업체
	$('#searchVendorCodeTwo').click(function(event) {
		vendorCodeSearch(-2);
	});
		
	
});//end of document ready
//그리드모달 :모달페이지로 값 넘기기----------------------------------------
//발주
var matOrderRowId;
function matOrderCodeSearch(c) {
matOrderRowId = c;
  //console.log(matOrderRowId);
  event.preventDefault();
  $(".modal").remove();
  this.blur(); // Manually remove focus from clicked link.
  //console.log(this.href);
  $.get("${pageContext.request.contextPath}/mat/order/searchMatOrderCode.do", function(html) {
    $(html).appendTo('body').modal();
  });
}
//자재
var materialRowId;
function materialCodeSearch(c) {
materialRowId = c;
  //console.log(materialRowId);
  event.preventDefault();
  $(".modal").remove();
  this.blur(); // Manually remove focus from clicked link.
  //console.log(this.href);
  $.get("${pageContext.request.contextPath}/mat/inout/searchMaterialCode.do", function(html) {
    $(html).appendTo('body').modal();
  });
}
//업체
var vendorRowId;
function vendorCodeSearch(c) {
vendorRowId = c;
  //console.log(vendorRowId);
  event.preventDefault();
  $(".modal").remove();
  this.blur(); // Manually remove focus from clicked link.
  console.log(this.href);
  $.get("${pageContext.request.contextPath}/mat/inout/searchVendorCode.do", function(html) {
    $(html).appendTo('body').modal();
  });
}
//불량
var matFltyRowId;
function matFltyCodeSearch(c) {
matFltyRowId = c;
  //console.log(matFltyRowId);
  event.preventDefault();
  $(".modal").remove();
  this.blur(); // Manually remove focus from clicked link.
  console.log(this.href);
  $.get("${pageContext.request.contextPath}/qua/flty/searchMatFltyCode.do", function(html) {
    $(html).appendTo('body').modal();
  });
}
//---------------------------------------------------------------
</script>