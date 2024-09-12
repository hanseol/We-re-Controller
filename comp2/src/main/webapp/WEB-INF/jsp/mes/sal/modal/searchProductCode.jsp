<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<div class="modal">	
<!-- 210701 김현경 제품검색 모달창 -->
<!-- 210707 뿌려주는 곳 수정 -->

<div class="content-fluid">
	<div class="panel panel-headline">
		<h3>제품 검색</h3>
	</div>
</div>

<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-heading">
			<div class="panel-body">
				<div>
					제품코드 <input type="text" id="comProductCode" name="comProductCode" placeholder="제품코드" class="form-control" />
					제품명 <input type="text" id="comProductName" name="comProductName" placeholder="제품명" class="form-control" />
					<button id="findRow">검색</button>
					<br><br>
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
	$("#ok").on("click", function() {
		//console.log(grid.getCheckedRowKeys()); //체크박스 선택된 행의 번호를 배열형태로 가져옴.
		//console.log(grid.getValue(chkRowKey,'comProductCode')); //행의 컬럼명으로 값을 가져옴.

		var chkRowKeys = grid.getCheckedRowKeys();
		for(var i=0; i<chkRowKeys.length; i++){
			name = grid.getValue(chkRowKeys[i], 'comProductName');
		}
		
		//view 페이지에 뿌려줄 부분 아이디값
		if (rowId == -1) { //rowId(rowKey)가 -1이면 input에 뿌려주고
			$("#comProductName").val(name);
			$("#erpProductName").val(name);
		} else { //아니면 mgrid에 뿌려준다
			mgrid.blur();
			ugrid.blur(); //출고 세부
			mgrid.setValue(rowId, 'comProductCode', name, false);
			ugrid.setValue(urowId, 'comProductCode', name, false); //출고 세부
		}	
	});
	
	$("#findRow").on("click", function() {
		var code = $("#comProductCode").val();
		var name = $("#comProductName").val();

		console.log(code);
		console.log(name);
		
		var readParams = {
				'comProductCode' : code,
				'comProductName' : name		
		};
		grid.readData(1, readParams, true);
	});
	
	const dataSource = {
		api : {
			readData : { //url = modal 페이지
				url : '${pageContext.request.contextPath}/ajax/searchProductCode',
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
		columns : [{
			header : '제품코드',
			name : 'comProductCode',
			align : 'center'
		}, {
			header : '제품명',
			name : 'comProductName',
			align : 'center'
		}]
	});
});
//end of document ready
</script>
</div>