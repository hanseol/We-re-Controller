<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="modal">
<!-- 210701 김현경 고객사검색 모달창 -->

<div class="content-fluid">
	<div class="panel panel-headline">
		<h3>고객사 검색</h3>
	</div>
</div>

<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-heading">
			<div class="panel-body">
				<div>
					고객사코드 <input type="text" id="comCustomerCode" name="erpCustomerCode" placeholder="고객사코드" />
					고객사명 <input type="text" id="comCustomerName" name="erpCustomerName" placeholder="고객사명" />
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
		for(var i=0; i<chkRowKeys.length; i++) {
			code = grid.getValue(chkRowKeys[i],'comCodeDetailId');
			name = grid.getValue(chkRowKeys[i], 'comCodeDetailName');
			
			if (rowId == -1) { //rowId(rowKey)가 -1이면 input에 뿌려주고
				$("#customerCode").val(name);
				code = [];
			} else { //아니면 mgrid(모달그리드)에 뿌려준다
				mgrid.blur();
				mgrid.setValue(rowId, 'salInoutCode', code, false);
			}
		}
		
				
	});
	
	
		
	
	$("#findRow").on("click", function() {
		var code = $("#comCustomerCode").val();
		var name = $("#comCustomerName").val();
		var readParams = { //실제컬럼명 : ~
				'comCodeDetailId' : code,
				'comCodeDetailName' : name
			};
		grid.readData(1, readParams, true);
	});
	
	const dataSource = {
		api : {
			readData : { //url = modal 페이지
				url : '${pageContext.request.contextPath}/ajax/searchCustomerCode',
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
			header : '고객사코드',
			name : 'comCodeDetailId'
		}, {
			header : '고객사명',
			name : 'comCodeDetailName'
		}]
	});
});
//end of document ready
</script>
</div>