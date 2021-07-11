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
					<div class="col-md-3">
						일자<input type="date" id="erpMaterialRequestDate" name="erpMaterialRequestDate">
					</div>
					<div class="col-md-3">
						발주코드<input type="text" id="matOrderCode" name="matOrderCode">
						<a id="searchMatOrderCode" href="searchMatOrderCode.do">
						<i class="fa fa-search"></i></a>
					</div>
					<div class="col-md-3">
						자재코드<input type="text" id="materialCode" name="materialCode">
						<a id="searchMaterialCode" href="searchMaterialCode.do">
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
					<p class="panel-subtitle">자재 발주 목록</p>
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
					<p class="panel-subtitle">검사 완료 목록</p>
				</div>
				<div class="col-md-3" align="right">
					<button type="button" class="btn btn-warning" id="passDeleteRow">선택삭제</button>
				</div>
			</div>
			<div class="panel-body">
				<div id="passGrid"></div>
			</div>
		</div>
	</div>
</div>

<script>
//그리드모달창을 위한 그리드 선언-------------------------------------
let orderGrid;
let materialGrid;
let vendorGrid;
let matFltyGrid;
//-----------------------------------------------------------




	$(document).ready(function () {
		
		// 옵션 폼 리셋버튼  
		$("#reset").click(function() {  
			$("form").each(function() {  
		    	if(this.id == "option") this.reset();
		    	grid.clear();
		    	passGrid.clear();
		    	});
			}); 
		
		//날짜 범위로 지정하는 방법 생각.
		


		//추가버튼 (행 추가)
		$(document).on("click", "button[id=appendRow]",
			function () {
				var rowData = [{
					//여기 수정 해야함.
					발주코드: "",
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
		//삭제 버튼(체크된 행 삭제)
		$(document).on("click", "button[id=passDeleteRow]",
			function () {
				passGrid.removeCheckedRows(false);
				
			});
		
		//검색데이터 전송
		$(document).on("click",	"button[id=search]",
				function () {

					//데이터를 변수에 담아서 parameter로 만들기.
					var erpMaterialRequestDate = $("#erpMaterialRequestDate").val();
					var matOrderCode = $("#matOrderCode").val();
					var materialCode = $("#materialCode").val();
					var erpVendorCode = $("#vendorCode").val();

					var readParams = {
						'erpMaterialRequestDate' : erpMaterialRequestDate,
						'erpMaterialOrderCode': matOrderCode,
						'comMaterialCode': materialCode,
						'erpVendorCode': erpVendorCode
					};
					grid.readData(1, readParams, true);
					passGrid.readData(1, readParams, true);
					
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
			/* initialRequest : false, */
			contentType: "application/json"
		};

		const grid = new tui.Grid({
			el: document.getElementById('grid'),
			rowHeaders: ['checkbox'],
			data: dataSource,
			scrollX: true,
	        scrollY: true,
	        bodyHeight: 150, 
	        rowHeight: 30,
	        

			columns: [{
				header: '발주코드',
				name: 'erpMaterialOrderCode',
				editor: 'text'
			}, {
				header: '입고일자',
				name: 'quaMaterialDate'
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
				name: 'erpMaterialOrderQty'
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
				name: 'erpMaterialPrice',
				editor: 'text'
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
			}, {
				header: '자재불량코드',
				name: 'comMaterialFCode',
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
	        bodyHeight: 150, 
	        rowHeight: 30,
	        

			columns: [{
				header: '발주코드',
				name: 'erpMaterialOrderCode'
			}, {
				header: '입고일자',
				name: 'quaMaterialDate'
			}, {
				header: '업체코드',
				name: 'erpVendorCode'
			}, {
				header: '업체명',
				name: 'comCodeDetailName'
			}, {
				header: '자재코드',
				name: 'comMaterialCode'
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
				name: 'erpMaterialOrderQty'
			}, {
				header: '합격량',
				name: 'quaMaterialPQty'
			}, {
				header: '불량량',
				name: 'quaMaterialFQty'
			}, {
				header: '단가',
				name: 'erpMaterialUnitPrice'
			}, {
				header: '금액',
				name: 'erpMaterialPrice'
			}, {
				header: '검사유무',
				name: 'quaMaterialChk'
			}, {
				header: '검사일자',
				name: 'quaMaterialChkDate'
			}]
		});
		
		
		
		
		
/* 		grid.on('afterChange',ev => {
			//자동 계산 (수량 *단가)
			var qty = grid.getValue( ev.changes[0].rowKey, 'matInoutQuantity');
			var unitPrice = grid.getValue( ev.changes[0].rowKey, 'erpMaterialUnitPrice');
			grid.setValue( ev.changes[0].rowKey, 'matInoutPrice', qty*unitPrice);
			
		}); */
		
		//이 컬럼은 클릭하면 안돼.
		//grid.disableColumn('comCodeDetailName');

		
		
		
		
		

		
//그리드 모달 더블클릭--------------------------------------------------
		//발주
		grid.on('dblclick', ev => {
			if(ev.columnName == 'erpMaterialOrderCode'){
				matOrderCodeSearch(ev.rowKey);
			}

		});		
		
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
		//불량
		grid.on('dblclick', ev =>{
			if(ev.columnName == 'quaMaterialFQty'){
				matFltyCodeSearch(ev.rowKey);
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
		
		//발주코드 모달 로우아이디 값--------------------------------------
		//발주
		$('#searchMatOrderCode').click(function(event) {
			matOrderCodeSearch(-1);
		});
		//자재
		$('#searchMaterialCode').click(function(event) {
			materialCodeSearch(-1);
		});
		//업체
		$('#searchVendorCode').click(function(event) {
			vendorCodeSearch(-1);
		});
		//불량
		$('#searchMatFltyCode').click(function(event) {
			matFltyCodeSearch(-1);
		});
		
});//end of document ready
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
	  $.get("${pageContext.request.contextPath}/matOrder/searchMatOrderCode.do", function(html) {
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
	  $.get("${pageContext.request.contextPath}/matInout/searchMaterialCode.do", function(html) {
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
	  $.get("${pageContext.request.contextPath}/matInout/searchVendorCode.do", function(html) {
	    $(html).appendTo('body').modal();
	  });
}
//불량
var matFltyRowId;
function matFltyCodeSearch(c) {
	matFltyRowId = c;
	  console.log(matFltyRowId);
	  event.preventDefault();
	  $(".modal").remove();
	  this.blur(); // Manually remove focus from clicked link.
	  console.log(this.href);
	  $.get("${pageContext.request.contextPath}/quaFlty/searchMatFltyCode.do", function(html) {
	    $(html).appendTo('body').modal();
	  });
}
//---------------------------------------------------------------
</script>