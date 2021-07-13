<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="modal">
<!-- 210701 김현경 LOT_NO 검색 모달창 -->
<!-- 210707 뿌려주는 곳 수정 -->

<div class="content-fluid">
	<div class="panel panel-headline">
		<h3>완제품 LOT_NO 검색</h3>
	</div>
</div>

<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-heading">
			<div class="panel-body">
				<div>
					완제품 LOT_NO <input type="text" id="proProcessLotNo" name="proProcessLotNo" placeholder="완제품 LOT_NO" /> &nbsp;
					제품코드 <input type="text" id="comProductCode" name="erpProductCode" placeholder="제품코드" /> <br> <br>
					제품명 <input type="text" id="comProductName" name="erpProductName" placeholder="제품명" />
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
			proProcessLotNo = grid.getValue(chkRowKeys[i],'proProcessLotNo');
			erpProductCode = grid.getValue(chkRowKeys[i], 'erpProductCode');
			erpCustomerCode = grid.getValue(chkRowKeys[i], 'erpCustomerCode');
			proOrderDetailCode = grid.getValue(chkRowKeys[i], 'proOrderDetailCode');
			proProcessQuantity = grid.getValue(chkRowKeys[i], 'proProcessQuantity');
			
			console.log(proProcessLotNo);
			console.log(erpProductCode);
			console.log(erpCustomerCode);
			console.log(proOrderDetailCode);
			console.log(proProcessQuantity);
			
			//view 페이지에 뿌려줄 부분 아이디값
			if (rowId == -1) { //rowId(rowKey)가 -1이면 input에 뿌려주고
				$("#productLotNo").val(proProcessLotNo);
				proProcessLotNo = [];
			} else { //아니면 mgrid(모달그리드)에 뿌려준다
				mgrid.blur();
				mgrid.setValue(rowId, 'proProcessLotNo', proProcessLotNo, false);
				mgrid.setValue(rowId, 'comProductCode', erpProductCode, false);
				mgrid.setValue(rowId, 'salInoutQuantity', proProcessQuantity, false);
								
				if (mgrid.getValue(chkRowKeys[i], 'salInoutGubun') == 'INOUT002') { //입고이면 지시코드
					mgrid.setValue(rowId, 'salInoutCode', proOrderDetailCode, false);
					console.log('안녕 난 입고')
				} else { //출고이거나 다른 곳에서 부르면 고객사코드
					mgrid.setValue(rowId, 'salInoutCode', erpCustomerCode, false);
					console.log('안녕 난 출고')
				}
			}
		}
	});
	
	$(document).on("click", "button[id=findRow]", function() {
		var no = $("#proProcessLotNo").val();
		var code = $("#erpProductCode").val();
		var name = $("#erpProductName").val();
		var readParams = {
				'proProcessLotNo' : no,
				'erpProductCode' : code,
				'erpProductName' : name
			};
		grid.readData(1, readParams, true);
	});
	
	const dataSource = {
		api : {
			readData : { //url = modal 페이지
				url : '${pageContext.request.contextPath}/ajax/searchProductLotNo',
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
		}]
	});
});
//end of document ready
</script>
</div>	