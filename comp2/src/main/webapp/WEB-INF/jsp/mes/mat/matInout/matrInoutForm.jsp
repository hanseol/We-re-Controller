<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

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
		<h2>자재입출고관리</h2>
	</div>
</div>

<!-- 관리, 지시 탭 이동 -->
<div id="tabs">
	<ul class="nav nav-tabs" role="tablist">
		<li class="active"><a onclick='location.href="matrInoutForm.do"' aria-controls="tab1" role="tab"
				data-toggle="tab">관리</a></li>
		<li class=""><a onclick='location.href="matrInoutView.do"' aria-controls="tab2" role="tab"
				data-toggle="tab">조회</a></li>
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
						<a id="searchMaterialCode" href="searchMaterialCode.do">
						<i class="fa fa-search"></i></a>
					</div>
					<div class="col-md-3">
						입고업체<input type="text" id="vendorCode" name="vendorCode">
						<a id="searchVendorCode" href="searchVendorCode.do">
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
					<button type="button" class="btn btn-info" id="modifyRow">저장</button>
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
				<div class="col-md-3" align="right">
					<button type="button" class="btn btn-info" id="appendRow">추가</button>
					<button type="button" class="btn btn-warning" id="deleteRow">선택삭제</button>
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
				<div class="col-md-3" align="right">
					<button type="button" class="btn btn-warning" id="deleteRow">선택삭제</button><!-- 구분해야해!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
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
		
		//날짜 범위로 지정하는 방법 생각.
		

		//추가버튼 (행 추가)
		$("#appendRow").on("click", function () {
				var rowData = [{
					//여기 수정 해야함.
					matInoutDate: "",
					erpVendorCode: "",
					comCodeDetailName: "",
					comMaterialCode: "",
					comMaterialName: "",
					comMaterialSize: "",
					comMaterialUnit: "",
					matLotNo: "",
					matInoutQuantity: "",
					matInoutUnitPrice: "",
					matInoutPrice: "",
					materialStock: "",
					comProcessCode: "",
					comProcessName: ""
				}];
				grid.appendRow(rowData, {
					at: 0,
					focus: true
				});
				grid.enable();
			});
		//저장버튼 (등록, 수정, 삭제)
		$("#modifyRow").on("click", function () {
			//null이면 안되는 값 입력하라고 창 띄우기 넣어야함.
				grid.finishEditing('rowKey', 'columnName');
				
				grid.request('modifyData');
			});
		
		//삭제 버튼(체크된 행 삭제)
		$("#deleteRow").on("click", function () {
				grid.removeCheckedRows(false);
				outGrid.removeCheckedRows(false);
			});

		//검색데이터 전송
		$("#search").on("click", function () {

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
				'matLot' : matLot
			};
			grid.readData(1, readParams, true);
			outGrid.readData(1, readParams, true);
		});
		//입고 목록 데이터
		const dataSource = {
			api: {
				readData: {
					url: '${pageContext.request.contextPath}/ajax/readMatInout',
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
		//입고 그리드
		const grid = new tui.Grid({
			el: document.getElementById('grid'),
			rowHeaders: ['checkbox'],
			data: dataSource,
			scrollX: true,
	        scrollY: true,
	        bodyHeight: 300, 
	        rowHeight: 30,
			columns: [{
				header: '입고일자',
				name: 'matInoutDate',
				width: '80',
				align: 'center',
				editor: {
					type: 'datePicker',
					options: {
						format: 'YYYY/MM/dd',
						language: 'ko'
					}
				}
			}, {
				header: '업체코드',
				name: 'erpVendorCode',
				width: '100',
				align: 'center',
				editor: 'text'
			}, {
				header: '입고업체명',
				name: 'comCodeDetailName',
				width: '100',
				align: 'center'
				
			}, {
				header: '자재코드',
				name: 'comMaterialCode',
				width: '80',
				align: 'center',
				editor: 'text'
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
				align: 'right',
				editor: 'text'
			}, {
				header: '단가(원)',
				name: 'matInoutUnitPrice',
				width: 'auto',
				minWidth: 100,
				align: 'right',
	            formatter: (ev)=>{return (ev.value == null) ? null : String(ev.value).replace(/\B(?=(\d{3})+(?!\d))/g, ","); }
			}, {
				header: '금액(원)',
				name: 'matInoutPrice',
				width: 'auto',
				minWidth: 100,
				align: 'right',
	            formatter: (ev)=>{return (ev.value == null) ? null : String(ev.value).replace(/\B(?=(\d{3})+(?!\d))/g, ","); }
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
	        bodyHeight: 300,
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
				header: '단가(원)',
				name: 'matInoutUnitPrice',
				width: 'auto',
				minWidth: 100,
				align: 'right'
			}, {
				header: '금액(원)',
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
		
		
		
		
		grid.on('afterChange',ev => {
			//자동 계산 (수량 *단가)
			var qty = grid.getValue( ev.changes[0].rowKey, 'matInoutQuantity');
			var unitPrice = grid.getValue( ev.changes[0].rowKey, 'erpMaterialUnitPrice');
			grid.setValue( ev.changes[0].rowKey, 'matInoutPrice', qty*unitPrice);
			
		});
		
		//이 컬럼은 클릭하면 안돼.
		//grid.disableColumn('comCodeDetailName');

		
		
		
		
		

		
//그리드 모달 더블클릭--------------------------------------------------
		//업체
		grid.on('dblclick', ev => {
			if(ev.columnName == 'erpVendorCode'){
				vendorCodeSearch(ev.rowKey);
			}

		});
		//자재
		grid.on('dblclick', ev =>{
			if(ev.columnName == 'comMaterialCode'){
				materialCodeSearch(ev.rowKey);
			}
		});
		//자재LOT_NO
		grid.on('dblclick', ev =>{
			if(ev.columnName == 'matLotNo'){
				matLotNoSearch(ev.rowKey);
			}
		});
		
//-----------------------------------------------------------------
		   



		//그리드 응답(제이슨)
		grid.on('response', ev => {
			const { response } = ev.xhr;
			const responseObj = JSON.parse(response);

			console.log('result : ', responseObj.result);
			console.log('data : ', responseObj.data);
		});
		
		
		//날짜 범위 검색 옵션
		var start = $("#inoutDate");
		var end = $("#inoutEndDate");
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
});//end of document ready
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