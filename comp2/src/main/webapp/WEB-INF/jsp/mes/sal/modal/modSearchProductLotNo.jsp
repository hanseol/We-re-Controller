<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="modal">
<!-- 210701 김현경 LOT_NO 검색 모달창 -->
<!-- 210707 뿌려주는 곳 수정 -->
<!-- 210721 이제와서 또 수정! -->

<div class="content-fluid">
	<div class="panel panel-headline">
		<h3>입고 완제품 LOT_NO 검색</h3>
	</div>
</div>

<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-heading">
			<div class="panel-body">
				<div>
					완제품 LOT_NO <input type="text" id="proProcessLotNo" name="proProcessLotNo" placeholder="완제품 LOT_NO" class="form-control" /> &nbsp;
					제품코드 <input type="text" id="comProductCode" name="erpProductCode" placeholder="제품코드" class="form-control" /> <br> <br>
					제품명 <input type="text" id="comProductName" name="erpProductName" placeholder="제품명" class="form-control" />
					<button id="findRow">검색</button><br>
					<br>
				<div id="modalGrid"></div>
			</div>
		</div>
	</div>
</div>

<div class="content-fluid">
	<a href="#" rel="modal:close"><button id="ok">확인</button></a>
	<a href="#" rel="modal:close"><button id="cancle">취소</button></a>
</div>

<script>
$(document).ready(function() {
	
	//확인을 눌렀을 때 선택한 값이 있다면 그 값을 전달 해야 함.
	//일단 한건만 선택했을 때의 경우.
	$("#ok").on("click", function(){
		//console.log(grid.getCheckedRowKeys()); //체크박스 선택된 행의 번호를 배열형태로 가져옴.
		//console.log(grid.getValue(chkRowKey,'comProductCode')); //행의 컬럼명으로 값을 가져옴.

		var chkRowKeys = grid.getCheckedRowKeys();

		for(var i=0; i<chkRowKeys.length; i++){
			proProcessLotNo = grid.getValue(chkRowKeys[i],'proProcessLotNo');
			erpProductName = grid.getValue(chkRowKeys[i], 'erpProductName')
			salNowQuantity = grid.getValue(chkRowKeys[i], 'salNowQuantity');
			comProductCode = grid.getValue(chkRowKeys[i], 'erpProductCode');
			
			
			console.log(proProcessLotNo);
			console.log(erpProductName);
			console.log(salNowQuantity);
			console.log(comProductCode);
						
			if(rowId == -1) {
				$("#proProcessLotNo").val(proProcessLotNo);
			} else {
				mgrid.blur();
				mgrid.setValue(rowId, 'proProcessLotNo', proProcessLotNo, false);
				mgrid.setValue(rowId, 'comProductName', erpProductName, false);
				mgrid.setValue(rowId, 'salNowQuantity', salNowQuantity, false);
				mgrid.setValue(rowId, 'comProductCode', comProductCode, false);
			}										
		}
	});
	
	$("#findRow").on("click", function() {
		var no = $("#proProcessLotNo").val();
		var code = $("#comProductCode").val();
		var name = $("#comProductName").val();
		var readParams = {
				'proProcessLotNo' : no,
				'comProductCode' : code,
				'comProductName' : name
			};
		grid.readData(1, readParams, true);
	});
	
	const dataSource = {
		api : {
			readData : { //url = modal 페이지
				url : '${pageContext.request.contextPath}/ajax/salM/modSearchProductLotNo',
				method : 'GET'
			}
		},
		contentType : "application/json"
	};

	const grid = new tui.Grid({
		el : document.getElementById('modalGrid'),
		rowHeaders : [ 'checkbox' ],
		data : dataSource,
			scrollX: true,
	        scrollY: true,
	        bodyHeight :300,
	        rowHeight: 30,
		columns : [ {
			header : '완제품 LOT_NO',
			name : 'proProcessLotNo'
		}, {
			header : '제품코드',
			name : 'erpProductCode'
		}, {
			header : '제품명',
			name : 'erpProductName'
		}, {
			header : '현재고',
			name : 'salNowQuantity'
		}]
	});
});
//end of document ready
</script>
</div>	