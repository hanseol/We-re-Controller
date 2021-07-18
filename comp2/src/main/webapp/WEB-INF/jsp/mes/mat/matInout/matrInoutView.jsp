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
		<h2>자재입출고조회</h2>
	</div>
</div>

<!-- 관리, 지시 탭 이동 -->
<div id="tabs">
	<ul class="nav nav-tabs" role="tablist">
		<li class=""><a onclick='location.href="matrInoutForm.do"'
			aria-controls="tab1" role="tab" data-toggle="tab">관리</a></li>
		<li class="active"><a onclick='location.href="matrInoutView.do"'
			aria-controls="tab2" role="tab" data-toggle="tab">조회</a></li>
	</ul>
</div>



<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-body">
			<div class="row">
				<form id="option">
					<div class="col-md-12">
						일자<input type="date" id="inoutDate" name="inoutDate">~<input type="date" id="inoutEndDate" name="inoutEndDate">
					</div>
					<div class="col-md-3">
						자재코드<input type="text" id="materialCode" name="materialCode">
						<a id="searchMaterialCode" href="${pageContext.request.contextPath}/mat/inout/searchMaterialCode.do">
						<i class="fa fa-search"></i></a>
					</div>
					<div class="col-md-3">
						입고업체<input type="text" id="vendorCode" name="vendorCode">
						<a id="searchVendorCode" href="${pageContext.request.contextPath}/mat/inout/searchVendorCode.do">
						<i class="fa fa-search"></i></a>
					</div>
					<div class="col-md-3">
						자재LOT_NO<input type="text" id="matLot" name="matLot">
						<a id="searchMatLotNo" href="${pageContext.request.contextPath}/mat/lot/searchMatLotNo.do">
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
		<div class="panel-body">
			<div class="row">
				<div class="col-md-9">
					<p class="panel-subtitle">입고</p>
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
				<div class="col-md-9">
					<p class="panel-subtitle">출고</p>
				</div>
			</div>
			<div class="panel-body">
				<div id="outGrid"></div>
			</div>
		</div>
	</div>
</div>




<script>
//그리드모달창을 위한 그리드 선언-------------------------------------
let materialGrid;
let vendorGrid;
let matLotGrid;
//-----------------------------------------------------------
//네비게이션 바 고정.
$('#matNav').addClass('active');
$('#subPages3').addClass('in');
$('#subPages3').attr('aria-expanded','true');
$('#subPages3').attr('style','');
$('.matrInout').addClass('active');


$(document).ready(function () {
	
	// 옵션 폼 리셋버튼  
	$("#reset").click(function() { 
		location.reload(true);
		}); 

	//검색데이터 전송
	$(document).on("click",	"button[id=search]",
			function () {

				//데이터를 변수에 담아서 parameter로 만들기.
				var comMaterialCode = $("#materialCode").val();
				var inoutDate = $("#inoutDate").val();
				var erpVendorCode = $("#vendorCode").val();
				var inoutEndDate = $("#inoutEndDate").val();
				var matLot = $("#matLot").val();
				var readParams = {
					'comMaterialCode': comMaterialCode,
					'matInoutDate': inoutDate,
					'erpVendorCode': erpVendorCode,
					'matInoutEndDate' : inoutEndDate,
					'matLotNo' : matLot
				};
				grid.readData(1, readParams, true);
				outGrid.readData(1, readParams, true);
			});
	//입고목록 데이터
	const dataSource = {
		api: {
			readData: {
				url: '${pageContext.request.contextPath}/ajax/readMatInout',
				method: 'GET'
			}
		},
		// 바로 값 나오지않게함
		/* initialRequest : false, */
		contentType: "application/json"
	};
	//입고 그리드
	const grid = new tui.Grid({
		el: document.getElementById('grid'),
		rowHeaders: ['checkbox'],
		data: dataSource,
		scrollX: true,
        scrollY: true,
        bodyHeight: 150, 
        rowHeight: 30,
		columns: [{
			header: '입고일자',
			name: 'matInoutDate',
			width: '80',
			align: 'center'
			
		}, {
			header: '업체코드',
			name: 'erpVendorCode',
			width: '100',
			align: 'center'
		}, {
			header: '입고업체명',
			name: 'comCodeDetailName',
			width: '100',
			align: 'center'
			
		}, {
			header: '자재코드',
			name: 'comMaterialCode',
			width: '80',
			align: 'center'
		}, {
			header: '자재명',
			name: 'comMaterialName',
			width: '100',
			align: 'center'
		}, {
			header: '규격',
			name: 'comMaterialSize',
			width: '150',
			align: 'center'
		}, {
			header: '관리단위',
			name: 'comMaterialUnit',
			width: '70',
			align: 'center'
		}, {
			header: '자재LOT_NO',
			width: '200',
			name: 'matLotNo',
			align: 'center'
		}, {
			header: '수량',
			name: 'matInoutQuantity',
			width: 'auto',
			minWidth: 100,
			align: 'right'
		}, {
			header: '단가',
			name: 'matInoutUnitPrice',
			width: 'auto',
			minWidth: 100,
			align: 'right'
		}, {
			header: '금액',
			name: 'matInoutPrice',
			width: 'auto',
			minWidth: 100,
			align: 'right'
		}]
	});
	//출고 목록 데이터
	const outDataSource = {
			api: {
				readData: {
					url: '${pageContext.request.contextPath}/ajax/readMatInoutPass',
					method: 'GET'
				},
				modifyData: {
					url: '${pageContext.request.contextPath}/ajax/modifyMatInout',
					method: 'PUT'
				}

			},
			// 리스트에 값이 바로 나오지않도록 함.
			//initialRequest : false,
			contentType: "application/json"
		};
	
		//출고 그리드
		const outGrid = new tui.Grid({
			el: document.getElementById('outGrid'),
			rowHeaders: ['checkbox'],
			data: outDataSource,
			scrollX: true,
	        scrollY: true,
	        bodyHeight: 150,
	        rowHeight: 30,
			columns: [{
				header: '출고일자',
				name: 'matInoutDate',
				width: '80',
				align: 'center'
			}, {
				header: '공정코드',
				name: 'comProcessCode',
				width: '100',
				align: 'center'
			}, {
				header: '출고공정명',
				name: 'comCodeDetailName',
				width: '100',
				align: 'center'
			}, {
				header: '자재코드',
				name: 'comMaterialCode',
				width: '80',
				align: 'center'
			}, {
				header: '자재명',
				name: 'comMaterialName',
				width: '100',
				align: 'center'
			}, {
				header: '규격',
				name: 'comMaterialSize',
				width: '150',
				align: 'center'
			}, {
				header: '관리단위',
				name: 'comMaterialUnit',
				width: '70',
				align: 'center'
			}, {
				header: '자재LOT_NO',
				width: '200',
				name: 'matLotNo',
				align: 'center'
			}, {
				header: '수량',
				name: 'matInoutQuantity',
				width: 'auto',
				minWidth: 100,
				align: 'right'
			}, {
				header: '단가',
				name: 'matInoutUnitPrice',
				width: 'auto',
				minWidth: 100,
				align: 'right'
			}, {
				header: '금액',
				name: 'matInoutPrice',
				width: 'auto',
				minWidth: 100,
				align: 'right'
			}]
		});
//모달 그리드 초기화 ----------------------------------
		materialGrid = grid;
		vendorGrid = grid;
		matLotGrid = grid;
//--------------------------------------------------
/* 	//자동 계산 (수량 *단가)
	grid.on('afterChange',ev => {
		var qty = grid.getValue( ev.changes[0].rowKey, 'matInoutQuantity');
		var unitPrice = grid.getValue( ev.changes[0].rowKey, 'matInoutUnitPrice');
		grid.setValue( ev.changes[0].rowKey, 'matInoutPrice', qty*unitPrice);
	}); */
	
	//데이터 제이슨타입 보기
	grid.on('response', ev => {
		const { response } = ev.xhr;
		const responseObj = JSON.parse(response);

		console.log('result : ', responseObj.result);
		console.log('data : ', responseObj.data);
	});
	
	
	//날짜 범위 검색 옵션
	var start = $("#inoutDate");
	var end = $("inoutEndDate");
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
	
	
	
	//그리드 로우아이디 지정--------------------------------------
	//자재
	$('#searchMaterialCode').click(function(event) {
		materialCodeSearch(-1);
	});
	//업체
	$('#searchVendorCode').click(function(event) {
		vendorCodeSearch(-1);
	});
	//LOT
	$('#searchMatLotNo').click(function(event) {
		matLotNoSearch(-1);
	});
	//-----------------------------------------------------
});
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
//자재LOT_NO
var matrLotRowId;
function matLotNoSearch(c) {
	matrLotRowId = c;
	  console.log(matrLotRowId);
	  event.preventDefault();
	  $(".modal").remove();
	  this.blur(); // Manually remove focus from clicked link.
	  console.log(this.href);
	  $.get("${pageContext.request.contextPath}/mat/lot/searchMatLotNo.do", function(html) {
	    $(html).appendTo('body').modal();
	  });
}
//---------------------------------------------------------------
</script>