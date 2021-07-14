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
		<h2>자재LOT재고 조정</h2>
	</div>
</div>

<!-- 관리, 지시 탭 이동 -->
<div id="tabs">
	<ul class="nav nav-tabs" role="tablist">
		<li class="active"><a onclick='location.href="matrLotForm.do"' aria-controls="tab1" role="tab"
				data-toggle="tab">관리</a></li>
		<li class=""><a onclick='location.href="matrLotView.do"' aria-controls="tab2" role="tab"
				data-toggle="tab">조회</a></li>
	</ul>
</div>

<form id="option">
	<div class="content-fluid">
		<div class="panel panel-headline">
			<div class="panel-body">
				<div class="row">
					<div class="col-md-2">
						일자<input type="date" id="matMatchDate" name="matMatchDate">
					</div>
					<div class="col-md-2">
						자료구분<input type="checkbox" id="inGubun" name="gubunChkBox">정산입고
						<input type="checkbox" id="outGubun" name="gubunChkBox">정산출고
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
					<p class="panel-subtitle">자재LOT재고 목록</p>
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
//네비게이션 바 고정.
$('#matNav').addClass('active');
$('#subPages3').addClass('in');
$('#subPages3').attr('aria-expanded','true');
$('#subPages3').attr('style','');
$('.matrLot').addClass('active');

	$(document).ready(function () {
		//날짜 범위로 지정하는 방법 생각.
		
		//정산입출고구분 체크박스 하나만 체크되거나 해제가능.
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
					정산입출고: "",
					일자: "",
					자재코드: "",
					자재명: "",
					자재LOT_NO: "",
					규격: "",
					관리단위: "",
					정산량: "",
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
						var matMatchInout = 'INOUT004';
					}else if(inGubun == false && outGubun == true){
						var matMatchInout = 'INOUT005';
					}

					//데이터를 변수에 담아서 parameter로 만들기.

					var matMatchDate = $("#matMatchDate").val();
					var erpVendorCode = $("#erpVendorCode").val();
					var matMatchInout = $("#matMatchInout").val();

					var readParams = {
						'matMatchDate': matMatchDate,
						'erpVendorCode': erpVendorCode,
						'matMatchInout': matMatchInout
					};
					grid.readData(1, readParams, true);
				});

		const dataSource = {
			api: {
				readData: {
					url: '${pageContext.request.contextPath}/ajax/readMatLot',
					method: 'GET'
				},
				modifyData: {
					url: '${pageContext.request.contextPath}/ajax/modifyMatLot',
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
				header: '정산입출고구분',
				name: 'matMatchInout',
				editor : {
					type: 'select',
					options : {
					listItems: [
						{text : '정산입고', value : 'INOUT004'},
						{text : '정산출고', value : 'INOUT005'}
						]
					}
				}
			}, {
				header: '정산일자',
				name: 'matMatchDate',
				editor: {
					type: 'datePicker',
					options: {
						format: 'YYYY/MM/dd',
						language: 'ko'
					}
				}
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
				header: '정산량',
				name: 'matMatchQty',
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
		
		
		
		//자동 계산 (수량 *단가)
		grid.on('afterChange',ev => {
			var qty = grid.getValue( ev.changes[0].rowKey, 'matInoutQuantity');
			var unitPrice = grid.getValue( ev.changes[0].rowKey, 'matInoutUnitPrice');
			grid.setValue( ev.changes[0].rowKey, 'matInoutPrice', qty*unitPrice);
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

		
		
		
		
		

		//컬럼 더블클릭 이벤트
		grid.on('dblclick', ev => {
			if((ev.columnName == 'erpVendorCode') && (ev.rowKey != null)){
		         $('#searchVendorModal').click();
			} else if((ev.columnName == 'comMaterialCode') && (ev.rowKey != null)){
		    	  $('#searchMaterialModal').click();
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