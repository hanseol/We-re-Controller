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
			salInoutQuantity = grid.getValue(chkRowKeys[i], 'salInoutQuantity');
			
			
			console.log(proProcessLotNo);
			console.log(erpProductCode);
			console.log(erpCustomerCode);
			console.log(salInoutQuantity);
			
			muGrid.blur();
			
			var rowData =[{
				proProcessLotNo : "",
				comProductCode : "",
				salInoutQuantity : ""
			}];
			muGrid.appendRow(rowData, {
				at : 0,
				focus : true
			});
			
			muGrid.enable();
						
			muGrid.setValue(chkRowKeys[i], 'proProcessLotNo', proProcessLotNo, false);
			//muGrid.setValue(chkRowKeys[i], 'salInoutCode', erpCustomerCode, false); //고객사코드
			muGrid.setValue(chkRowKeys[i], 'comProductCode', erpProductCode, false);
			muGrid.setValue(chkRowKeys[i], 'salInoutQuantity', salInoutQuantity, false); //수량									
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
				url : '${pageContext.request.contextPath}/ajax/modSearchProductLotNo',
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
			header : '수량',
			name : 'salInoutQuantity'
		}]
	});
});
//end of document ready
</script>
</div>	