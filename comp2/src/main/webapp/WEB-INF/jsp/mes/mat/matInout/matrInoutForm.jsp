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

<form id="option">
	<div class="content-fluid">
		<div class="panel panel-headline">
			<div class="panel-body">
				<div class="row">
					<div class="col-md-2">
						일자<input type="date" id="matInoutDate" name="matInoutDate">
					</div>
					<div class="col-md-2">
						입/출고구분<input type="checkbox" id="inGubun" name="gubunChkBox">입고
						<input type="checkbox" id="outGubun" name="gubunChkBox">출고
					</div>
					<div class="col-md-2">
						자재코드
						<input type="text" id="comMaterialCode" name="comMaterialCode">
						<a id="searchMaterialModal" href="${pageContext.request.contextPath}/searchMaterialCode.do" rel="modal:open"><i class="fa fa-search"></i></a>
					</div>
					<div class="col-md-3">
						입고업체
						<input type="text" id="erpVendorCode" name="erpVendorCode">
						<a id="searchVendorModal" href="${pageContext.request.contextPath}/searchVendorCode.do" rel="modal:open"><i class="fa fa-search"></i></a>
					</div>
					<div class="col-md-3">
						<button type="button" class="btn btn-success" id="search">조회</button>
						<button type="button" class="btn btn-info" id="modifyRow">저장</button>
						<button type="button" class="btn btn-danger" id="reset">새자료</button>
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
				<div class="col-md-11">
					<p class="panel-subtitle">자재 입출고 목록</p>
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
	$(document).ready(function () {
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
					일자: "",
					업체코드: "",
					입고업체명: "",
					자재코드: "",
					자재명: "",
					자재LOT_NO: "",
					규격: "",
					관리단위: "",
					입출고: "",
					수량: "",
					단가: "",
					금액: "",
					현재고: ""
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
					var inGubun = $('input:checkbox[id="inGubun"]').is(":checked")
					var outGubun = $('input:checkbox[id="outGubun"]').is(":checked")
					if(inGubun == true && outGubun == false){
						var matInoutGubun = 'INOUT002';
					}else if(inGubun == false && outGubun == true){
						var matInoutGubun = 'INOUT003';
					}

					//데이터를 변수에 담아서 parameter로 만들기.

					var matInoutDate = $("#matInoutDate").val();
					var erpVendorCode = $("#erpVendorCode").val();
					var matInoutGubun = $("#matInoutGubun").val();

					var readParams = {
						'matInoutDate': matInoutDate,
						'erpVendorCode': erpVendorCode,
						'matInoutGubun': matInoutGubun
					};
					grid.readData(1, readParams, true);
				});

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
			initialRequest : false,
			contentType: "application/json"
		};

		const grid = new tui.Grid({
			el: document.getElementById('grid'),
			rowHeaders: ['checkbox'],
			data: dataSource,
			
			columns: [{
				header: '입출고구분',
				name: 'matInoutGubun',
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
				header: '일자',
				name: 'matInoutDate',
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
				header: '입고업체명',
				name: 'comCodeDetailName'
			}, {
				header: '자재코드',
				name: 'comMaterialCode',
				editor: 'text'
			}, {
				header: '자재명',
				name: 'comMaterialName'
			}, {
				header: '자재LOT_NO',
				name: 'matLotNo'
			}, {
				header: '규격',
				name: 'comMaterialSize'
			}, {
				header: '관리단위',
				name: 'comMaterialUnit'
			}, {
				header: '수량',
				name: 'matInoutQuantity',
				editor: 'text'
			}, {
				header: '단가',
				name: 'matInoutUnitPrice',
				editor: 'text'
			}, {
				header: '금액',
				name: 'matInoutPrice',
				editor: 'text'
			}, {
				header: '현재고',
				name: 'materialStock'
			}]
		});
		
		
		
		
		grid.on('afterChange',ev => {
			//자동 계산 (수량 *단가)
			var qty = grid.getValue( ev.changes[0].rowKey, 'matInoutQuantity');
			var unitPrice = grid.getValue( ev.changes[0].rowKey, 'matInoutUnitPrice');
			grid.setValue( ev.changes[0].rowKey, 'matInoutPrice', qty*unitPrice);
			
			//업체코드입력 시 업체명 자동기입
			if(ev.changes[0].columnName = 'erpVendorCode'){
				grid.setValue(ev.changes[0].rowKey, 'comCodeDetailName', ?);
			//자재코드입력 시 자재명 자동기입
			}else if(ev.changes[0].columnName = 'comMaterialCode'){
				grid.setValue(ev.changes[0].rowKey, 'comMaterialName', ?);
			}
			
		});
		
		//이 컬럼은 클릭하면 안돼.
		//grid.disableColumn('comCodeDetailName');

		
		
		
		
		

		//컬럼 더블클릭 이벤트
		grid.on('dblclick', ev => {
			
			for(var i=0; i<=getRowCount().length; i++){
				if((ev.columnName == 'erpVendorCode') && (ev.rowKey != null)){
			         $('#searchVendorModal').click();
				} else if((ev.columnName == 'comMaterialCode') && (ev.rowKey != null)){
			    	  $('#searchMaterialModal').click();
				}
			}
		});
		   

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

	}); //end of document ready
</script>