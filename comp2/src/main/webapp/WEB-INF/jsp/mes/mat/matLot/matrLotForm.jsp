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

<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-body">
			<div class="row">
				<form id="option">
					<div class="col-md-4">
						일자&nbsp;&nbsp;&nbsp;<input type="date" id="matchDate" name="matchDate">~<input type="date" id="matchEndDate" name="matchEndDate">
					</div>
					<div class="col-md-8" align="left">
						자료구분&nbsp;&nbsp;&nbsp;<input type="checkbox" id="inGubun" name="gubunChkBox">정산입고
						<input type="checkbox" id="outGubun" name="gubunChkBox">정산출고
					</div>
					<div class="col-md-12"><br/></div>
					<div class="col-md-4">
						자재검색&nbsp;&nbsp;&nbsp;<input type="text" id="materialCode" name="materialCode">
						<a id="searchMaterialCode" href="${pageContext.request.contextPath}/mat/inout/searchMaterialCode.do">
						<i class="fa fa-search"></i></a>
					</div>
					<div class="col-md-4" align="left">
						자재LOT검색&nbsp;&nbsp;&nbsp;<input type="text" id="matLot" name="matLot">
						<a id="searchMatLotNo" href="${pageContext.request.contextPath}/mat/lot/searchMatLotNo.do">
						<i class="fa fa-search"></i></a>
					</div>
				</form>
				<div class="col-md-4" align="right">
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
					<p class="panel-subtitle">자재LOT재고 목록</p>
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
<script>
//네비게이션 바 고정.
$('#matNav').addClass('active');
$('#subPages3').addClass('in');
$('#subPages3').attr('aria-expanded','true');
$('#subPages3').attr('style','');
$('.matrLot').addClass('active');

//그리드모달창을 위한 그리드 선언-------------------------------------
let materialGrid;
let matLotGrid;
//-----------------------------------------------------------
	

	$(document).ready(function () {
		
		// 옵션 폼 리셋버튼  
		$("#reset").click(function() { 
			$("form").each(function() {  
		    	if(this.id == "option") this.reset();
		    	grid.clear();
		    	
		    	$('#materialCode').val("");
		    	$('#matLot').val("");
		    	
		    	});
			}); 
		
		//정산입출고구분 체크박스 하나만 체크되거나 해제가능.
		$('input[type="checkbox"][name="gubunChkBox"]').click(function(){
 			if($(this).prop('checked')){
				$('input[type="checkbox"][name="gubunChkBox"]').prop('checked',false);
				$(this).prop('checked',true);
			}
		});

		//추가버튼 (행 추가)
		$("#appendRow").on("click", function () {
				var rowData = [{
					//여기 수정 해야함.
					matMatchDate: "",
					matMatchInout: "",
					matLotNo: "",
					comMaterialCode: "",
					comMaterialName: "",
					matPastQuantity: "",
					matMatchQty: "",
					finalQuantity: ""
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
				grid.reloadData();
			});
		//삭제 버튼(체크된 행 삭제)
		$("#deleteRow").on("click", function () {
				grid.removeCheckedRows(false);
			});

		//검색데이터 전송
		$("#search").on("click", function () {
					//입출고구분 테스트
					var inGubun = $('input:checkbox[id="inGubun"]').is(":checked")
					var outGubun = $('input:checkbox[id="outGubun"]').is(":checked")
					var matMatchInout;
					if(inGubun == true && outGubun == false) {
						matMatchInout = 'INOUT004';
					} else if(inGubun == false && outGubun == true) {
						matMatchInout = 'INOUT005';
					}

					//데이터를 변수에 담아서 parameter로 만들기.

					var matchDate = $("#matchDate").val();
					var matLot = $("#matLot").val();
					var materialCode = $("#materialCode").val();
					var matchEndDate = $("#matchEndDate").val();
					
					var readParams = {
						'matMatchDate': matchDate,
						'matLotNo': matLot,
						'comMaterialCode': materialCode,
						'matMatchInout': matMatchInout,
						'matchEndDate' : matchEndDate
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
			scrollX: true,
	        scrollY: true,
	        bodyHeight :400,
	        rowHeight: 30,
			columns: [{
				header : '입/출고일자',
				name : 'matMatchDate',
				editor : {
					type : 'datePicker',
					options : {
						format : 'YYYY/MM/dd',
						language: 'ko'
					} 
				}
			}, {
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
				header: '자재LOT_NO',
				name: 'matLotNo'
			}, {
				header: '자재코드',
				name: 'comMaterialCode'
			}, {
				header: '자재명',
				name: 'comMaterialName'
			}, {
				header: '기존수량',
				name: 'matPastQuantity'
			}, {
				header: '정산수량',
				name: 'matMatchQty',
				editor: 'text'
			}, {
				header: '최종수량',
				name: 'matInoutQuantity'
			}, {
				header : '전표번호',
				name : 'matMatchStatement',
				hidden : true
			}]
		});
		
//모달 그리드 초기화 ----------------------------------
		materialGrid = grid;
		matLotGrid = grid;
//--------------------------------------------------


		//자동 계산 
  		grid.on('afterChange', ev => {
  			if (ev.changes[0].columnName == 'matMatchQty') {
  				var match = grid.getValue(ev.changes[0].rowKey, 'matMatchQty');
  				var order = grid.getValue(ev.changes[0].rowKey, 'matPastQuantity');
  				if(grid.getValue(ev.changes[0].rowKey, 'matMatchInout') == 'INOUT004') {
  					grid.setValue(ev.changes[0].rowKey, 'matInoutQuantity', parseInt(order)+parseInt(match));
  				} else if(grid.getValue(ev.changes[0].rowKey, 'matMatchInout') == 'INOUT005') {
  					grid.setValue(ev.changes[0].rowKey, 'matInoutQuantity', parseInt(order)-parseInt(match));
  				}
  			}
		});
//그리드 모달 더블클릭--------------------------------------------------

		//자재
		grid.on('dblclick', ev =>{
			if(ev.columnName == 'comMaterialCode'){
				materialCodeSearch(ev.rowKey);
			}
		});
		//자재LOT_NO
		grid.on('dblclick', ev =>{
			if(ev.columnName == 'matLotNo'){
				matLotNoSearchSecond(ev.rowKey);
			}
		});
		
//-----------------------------------------------------------------

		
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
		
		
		//그리드 로우아이디 지정--------------------------------------
		//자재
		$('#searchMaterialCode').click(function(event) {
			materialCodeSearch(-1);
		});

		//LOT
		$('#searchMatLotNo').click(function(event) {
			matLotNoSearch(-1);
		});
		//-----------------------------------------------------

	}); //end of document ready
	//그리드모달 :모달페이지로 값 넘기기----------------------------------------
	//자재
	var materialRowId;
	function materialCodeSearch(c) {
		materialRowId = c;
		  event.preventDefault();
		  $(".modal").remove();
		  this.blur(); // Manually remove focus from clicked link.
		  $.get("${pageContext.request.contextPath}/mat/inout/searchMaterialCode.do", function(html) {
		    $(html).appendTo('body').modal();
		  });
	}
	//자재LOT_NO
	var matrLotRowId;
	function matLotNoSearch(c) {
		matrLotRowId = c;
		  event.preventDefault();
		  $(".modal").remove();
		  this.blur(); // Manually remove focus from clicked link.
		  $.get("${pageContext.request.contextPath}/mat/lot/searchMatLotNo.do", function(html) {
		    $(html).appendTo('body').modal();
		  });
	}
	// 정산테이블에 있는 데이터는 제외한 자재LOT_NO
	var matrLotRowIdSecond;
	function matLotNoSearchSecond(c) {
		matrLotRowIdSecond = c;
		  event.preventDefault();
		  $(".modal").remove();
		  this.blur(); // Manually remove focus from clicked link.
		  $.get("${pageContext.request.contextPath}/mat/lot/searchMatLotNoSecond.do", function(html) {
		    $(html).appendTo('body').modal();
		  });
	}
	//---------------------------------------------------------------
</script>