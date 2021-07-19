<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="modal">
<!-- 210719 김현경 주문 목록 검색 모달창 -->

<div class="content-fluid">
	<div class="panel panel-headline">
		<h3>제품주문서 목록</h3>
	</div>
</div>

<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-heading">
			<div class="panel-body">
				<div>
					고객사코드 <input type="text" id="erpCustomerCode" name="erpCustomerCode" placeholder="고객사코드" />
					제품코드 <input type="text" id="erpProductCode" name="erpProductCode" placeholder="제품코드" />
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
	$(document).on("click","button[id=ok]", function(){
		//console.log(grid.getCheckedRowKeys()); //체크박스 선택된 행의 번호를 배열형태로 가져옴.
		//console.log(grid.getValue(chkRowKey,'comProductCode')); //행의 컬럼명으로 값을 가져옴.

		var chkRowKeys = grid.getCheckedRowKeys();

		for(var i=0; i<chkRowKeys.length; i++){
			erpOrderCode = grid.getValue(chkRowKeys[i], 'erpOrderCode');
			erpCustomerCode = grid.getValue(chkRowKeys[i], 'erpCustomerCode');
			erpProductCode = grid.getValue(chkRowKeys[i],'erpProductCode');
			erpOrderQty = grid.getValue(chkRowKeys[i], 'erpOrderQty');
			
					
			console.log(erpProductCode);
			console.log(erpCustomerCode);
			console.log(erpOrderQty);
			console.log(erpOrderCode);
			
			mgrid.blur();
			mgrid.setValue(rowId, 'comProductCode', erpProductCode, false);
			mgrid.setValue(rowId, 'salInoutCode', erpCustomerCode, false);
			mgrid.setValue(rowId, 'salInoutQuantity', erpOrderQty, false);
			mgrid.setValue(rowId, 'proProcessLotNo', erpOrderCode, false);
		}
	});
	
	$(document).on("click", "button[id=findRow]", function() {
		var no = $("#erpCustomerCode").val();
		var code = $("#erpProductCode").val();
		var readParams = {
				'erpCustomerCode' : no,
				'erpProductCode' : code
			};
		grid.readData(1, readParams, true);
	});
	
	const dataSource = {
		api : {
			readData : { //url = modal 페이지
				url : '${pageContext.request.contextPath}/ajax/searchOrderList',
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
			header : '주문코드',
			name : 'erpOrderCode'
		}, {
			header : '고객사코드',
			name : 'erpCustomerCode'
		}, {
			header : '제품코드',
			name : 'erpProductCode'
		}, {
			header : '주문량',
			name : 'erpOrderQty'
		}]
	});
});
//end of document ready
</script>
</div>	