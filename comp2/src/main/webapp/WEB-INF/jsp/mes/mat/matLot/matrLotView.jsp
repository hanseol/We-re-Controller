<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="content-fluid">
	<div>
		<h2>자재 LOT 조회</h2>
	</div>
</div>




<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-body">
			<div class="row">
				<form id="option">
					<div class="col-md-12">
						조정일자&nbsp;&nbsp;&nbsp;<input type="date" id="matchDate" name="matchDate">&nbsp;~&nbsp;<input type="date" id="matchEndDate" name="matchEndDate">
					</div>
					<div class="col-md-12"><br/></div>
					<div class="col-md-3">
						자료구분&nbsp;&nbsp;&nbsp;<input type="checkbox" id="inGubun" name="gubunChkBox">정산입고
						<input type="checkbox" id="outGubun" name="gubunChkBox">정산출고
					</div>
					<div class="col-md-3">
						자재검색&nbsp;&nbsp;&nbsp;<input type="text" id="materialCode" name="materialCode">
						<a id="searchMaterialCode" href="${pageContext.request.contextPath}/mat/inout/searchMaterialCode.do">
						<i class="fa fa-search"></i></a>
					</div>
					<div class="col-md-3">
						자재LOT검색&nbsp;&nbsp;&nbsp;<input type="text" id="matLot" name="matLot">
						<a id="searchMatLotNo" href="${pageContext.request.contextPath}/mat/lot/searchMatLotNo.do">
						<i class="fa fa-search"></i></a>
					</div>
				</form>
				<div class="col-md-3" align="right">
					<button type="button" class="btn btn-primary" id="search">조회</button>
					<button type="button" class="btn btn-success" id="reset">새자료</button>
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
					<p class="panel-subtitle">자재LOT재고 목록</p>
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
let matLotGrid;
//-----------------------------------------------------------


$(document).ready(function () {
	
	//네비게이션 바 고정.
	$('#n6000000').addClass('active');
	$('#subPages6000000').addClass('in');
	$('#subPages6000000').attr('aria-expanded','true');
	$('#subPages6000000').attr('style','');
	$('.6050000').addClass('active');
	
	// 옵션 폼 리셋버튼  
	$("#reset").click(function() { 
		$("form").each(function() {  
	    	if(this.id == "option") this.reset();
	    	grid.clear();
	    	
	    	$('#materialCode').val("");
	    	$('#matLot').val("");
	    	
	    	});
		}); 

	
	//입출고구분 체크박스 하나만 체크되거나 해제가능.
	$('input[type="checkbox"][name="gubunChkBox"]').click(function(){
			if($(this).prop('checked')){
			$('input[type="checkbox"][name="gubunChkBox"]').prop('checked',false);
			$(this).prop('checked',true);
		}
	});

	$("#search").on("click", function () {
				//입출고구분 테스트
				var inGubun = $('input:checkbox[id="inGubun"]').is(":checked");
				var outGubun = $('input:checkbox[id="outGubun"]').is(":checked");
				var matMatchInout;
				if(inGubun == true && outGubun == false){
					matMatchInout = 'INOUT004';
				}else if(inGubun == false && outGubun == true){
					matMatchInout = 'INOUT005';
				}

				//데이터를 변수에 담아서 parameter로 만들기.

				var matchDate = $("#matchDate").val();
				var materialCode = $("#materialCode").val();
				var matchEndDate = $("#matchEndDate").val();
				var matLot = $("#matLot").val();
				var readParams = {
					'matMatchDate': matchDate,
					'comMaterialCode': materialCode,
					'matMatchInout': matMatchInout,
					'matchEndDate' : matchEndDate,
					'matLotNo' : matLot
				};
				grid.readData(1, readParams, true);
			});

	const dataSource = {
		api: {
			readData: {
				url: '${pageContext.request.contextPath}/ajax/readMatLot',
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
			header : '조정일자',
			name : 'matMatchDate'
		}, {
			header: '정산입출고구분',
			name: 'matMatchInout',
			formatter: 'listItemText',
			editor : {
				type: 'radio',
				options : {
				listItems: [
					{text : '정산입고', value : 'INOUT004'},
					{text : '정산출고', value : 'INOUT005'}
					]
				}
			},
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
			name: 'matMatchQty'
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
		grid.on('onGridUpdated', ev=>{
			ev.grid.columnDisable(matMatchInout);
		});
	
		//자동 계산 (수량 *단가)
  		grid.on('afterChange', ev => {
  			if (ev.changes[0].columnName == 'matMatchQty') {
  				var match = grid.getValue(ev.changes[0].rowKey, 'matMatchQty');
  				var order = grid.getValue(ev.changes[0].rowKey, 'matInoutQuantity');
  				if(grid.getValue(ev.changes[0].rowKey, 'matMatchInout') == 'INOUT004') {
  					grid.setValue(ev.changes[0].rowKey, 'finalQuantity', parseInt(order) + parseInt(match));
  				} else {
  					grid.setValue(ev.changes[0].rowKey, 'finalQuantity', parseInt(order) - parseInt(match));
  				}
  			}
/*   			var iQty = grid.getValue(rowKey, 'matInoutQuantity');
  			var mQty = grid.getValue(rowKey, 'matMatchQty');
  			if(iQty == mQty){
  				console.log('hi');
  			} */
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
	
//그리드 모달 더블클릭--------------------------------------------------

	//자재
/* 	grid.on('dblclick', ev =>{
		if(ev.columnName == 'comMaterialCode'){
			materialCodeSearch(ev.rowKey);
		}
	}); */
	//자재LOT_NO
/* 	grid.on('dblclick', ev =>{
		if(ev.columnName == 'matLotNo'){
			matLotNoSearch(ev.rowKey);
		}
	}); */
	
//-----------------------------------------------------------------

	
	
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