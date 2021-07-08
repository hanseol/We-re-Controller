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
		<h2>자재입고검사 관리</h2>
	</div>
</div>

<!-- 관리, 지시 탭 이동 -->
<div id="tabs">
	<ul class="nav nav-tabs" role="tablist">
		<li class="active"><a onclick='location.href="matrQuaForm.do"' aria-controls="tab1" role="tab" data-toggle="tab">관리</a></li>
		<li class=""><a onclick='location.href="matrQuaView.do"' aria-controls="tab2" role="tab" data-toggle="tab">조회</a></li>
	</ul>
</div>


<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-body">
			<div class="row">
				<form id="option">
					<div class="col-md-2">
						일자<input type="date" id="matInoutDate" name="matInoutDate">
					</div>
					<div class="col-md-2">
						자재코드<input type="text" id="materialCode" name="materialCode">
						<a id="searchMaterialCode" href="searchMaterialCode.do">
						<i class="fa fa-search"></i></a>
						
						<input type="hidden" id="matLot" name="matLot">
						<a id="searchMatLotNo" href="searchMatLotNo.do"></a>
					</div>
					<div class="col-md-3">
						발주업체<input type="text" id="vendorCode" name="vendorCode">
						<a id="searchVendorCode" href="searchVendorCode.do">
						<i class="fa fa-search"></i></a>
					</div>
				</form>
				<div class="col-md-3">
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
				<div class="col-md-11">
					<p class="panel-subtitle">자재 발주 목록</p>
				</div>
				<div class="col-md-1">
					<button type="button" class="btn btn-info" id="appendRow">추가</button>
					<button type="button" class="btn btn-warning" id="deleteRow">삭제</button>
				</div>
			</div>
			<div class="panel-body">
				<div id="grid"></div>
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




	$(document).ready(function () {
		
		// 옵션 폼 리셋버튼  
		$("#reset").click(function() {  
			$("form").each(function() {  
		    	if(this.id == "option") this.reset();  
		    	});
			}); 
		
		//날짜 범위로 지정하는 방법 생각.
		
		//입출고구분 체크박스 하나만 체크되거나 해제가능.
		$('input[type="checkbox"][name="gubunChkBox"]').click(function(){
 			if($(this).prop('checked')){
				$('input[type="checkbox"][name="gubunChkBox"]').prop('checked',false);
				$(this).prop('checked',true);
			}
		});

		//추가버튼 (행 추가)
		$(document).on("click", "button[id=appendRow]",
			function () {
				var rowData = [{
					//여기 수정 해야함.
					입고일자: "",
					업체코드: "",
					업체명: "",
					자재코드: "",
					자재명: "",
					규격: "",
					관리단위: "",
					발주량: "",
					합격량: "",
					불량량: "",
					단가: "",
					금액: "",
					검사일자:""
				}];
				grid.appendRow(rowData, {
					at: 0,
					focus: true
				});
				grid.enable();
			});
		//저장버튼 (등록, 수정, 삭제)
		$(document).on("click", "button[id=modifyRow]",
			function () {
			//null이면 안되는 값 입력하라고 창 띄우기 넣어야함.
				grid.finishEditing('rowKey', 'columnName');
				
				grid.request('modifyData');
			});
		//삭제 버튼(체크된 행 삭제)
		$(document).on("click", "button[id=deleteRow]",
			function () {
				grid.removeCheckedRows(false);
			});

		//검색데이터 전송
		$(document).on("click",	"button[id=search]",
				function () {
					//입출고구분 테스트
					var inGubun = $('input:checkbox[id="inGubun"]').is(":checked");
					var outGubun = $('input:checkbox[id="outGubun"]').is(":checked");
					var matInoutGubun;
					if(inGubun == true){
						matInoutGubun = 'INOUT002';
					}else if(outGubun == true){
						matInoutGubun = 'INOUT003';
					}
					

					//데이터를 변수에 담아서 parameter로 만들기.
					var comMaterialCode = $("#materialCode").val();
					var matInoutDate = $("#matInoutDate").val();
					var erpVendorCode = $("#vendorCode").val();

					var readParams = {
						'comMaterialCode': comMaterialCode,
						'matInoutDate': matInoutDate,
						'erpVendorCode': erpVendorCode,
						'matInoutGubun': matInoutGubun
					};
					grid.readData(1, readParams, true);
				});

		const dataSource = {
			api: {
				readData: {
					url: '${pageContext.request.contextPath}/ajax/readQuaChk',
					method: 'GET'
				},
				modifyData: {
					url: '${pageContext.request.contextPath}/ajax/modifyQuaChk',
					method: 'PUT'
				}

			},
			// 리스트에 값이 바로 나오지않도록 함.
			initialRequest : false,
			contentType: "application/json"
		};

		const grid = new tui.Grid({
			el: document.getElementById('grid'),
			rowHeaders: ['checkbox'],
			data: dataSource,
			scrollX: true,
	        scrollY: true,
	        bodyHeight: 30, 
	        rowHeight: 30,
	        

			columns: [{
				header: '입고일자',
				name: 'quaMaterialDate',
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
				editor: 'text'
			}, {
				header: '업체명',
				name: 'comCodeDetailName'
			}, {
				header: '자재코드',
				name: 'comMaterialCode',
				editor: 'text'
			}, {
				header: '자재명',
				name: 'comMaterialName'
			}, {
				header: '규격',
				name: 'comMaterialSize'
			}, {
				header: '관리단위',
				name: 'comMaterialUnit'
			}, {
				header: '발주량',
				name: 'erpMaterialOrderQty',
				editor: 'text'
			}, {
				header: '합격량',
				name: 'quaMaterialPQty',
				editor: 'text'
			}, {
				header: '불량량',
				name: 'quaMaterialFQty',
				editor: 'text'
			}, {
				header: '단가',
				name: 'erpMaterialUnitPrice',
				editor: 'text'
			}, {
				header: '금액',
				name: 'matInoutPrice'
			}, {
				header: '검사유무',
				name: 'quaMaterialChk',
				editor: 'text'
			}, {
				header: '검사일자',
				name: 'quaMaterialChkDate',
				editor: {
					type: 'datePicker',
					options: {
						format: 'YYYY/MM/dd',
						language: 'ko'
					}
				}
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
		})
		//자재LOT_NO
		grid.on('dblclick', ev =>{
			if(ev.columnName == 'matLotNo'){
				matLotNoSearch(ev.rowKey);
			}
		})
		
//-----------------------------------------------------------------
		   



		//그리드 응답(제이슨)
		grid.on('response', ev => {
			const { response } = ev.xhr;
			const responseObj = JSON.parse(response);

			console.log('result : ', responseObj.result);
			console.log('data : ', responseObj.data);
		});
/* 
		grid.on('check', (ev) => {
			alert(`check: ${ev.rowKey}`);
		}); */
		$('#searchMaterialCode').click(function(event) {
			materialCodeSearch(-1);
		});
		$('#searchVendorCode').click(function(event) {
			vendorCodeSearch(-1);
		});
		$('#searchMatLotNo').click(function(event) {
			matLotNoSearch(-1);
		});
		
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
	  $.get("searchMaterialCode.do", function(html) {
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
	  $.get("searchVendorCode.do", function(html) {
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
	  $.get("searchMatLotNo.do", function(html) {
	    $(html).appendTo('body').modal();
	  });
}
//---------------------------------------------------------------
</script>