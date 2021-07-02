<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
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
		var code = [];
		for(var i=0; i<chkRowKeys.length; i++){
			code = grid.getValue(chkRowKeys[i],'comCodeDetailId');
			console.log(code);
		}
		//view 페이지에 뿌려줄 부분 아이디값
		$("#customerCode").val(code);
	});
	
	$(document).on("click", "button[id=findRow]", function() {
		var code = $("#comCustomerCode").val();
		console.log(code);
		var name = $("#comCustomerName").val();
		console.log(name);
		var desc = $("#comCodeDetailDesc").val();
		console.log(desc);
		var readParams = { //실제컬럼명 : ~
				'comCodeDetailId' : code,
				'comCodeDetailName' : name,
				'comCodeDetailDesc' : desc
			};
		grid.readData(1, readParams, true);
	});
	
	const dataSource = {
		api : {
			readData : { //url = modal 페이지
				url : '${pageContext.request.contextPath}/mes/salInout/searchCustomerCode',
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
		}, {
			header : '설명',
			name : 'comCodeDetailDesc'
		}]
	});
});
//end of document ready
</script>