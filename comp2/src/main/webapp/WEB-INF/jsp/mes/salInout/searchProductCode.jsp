<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- 210701 김현경 제품검색 모달창 -->
   
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
					제품코드 <input type="text" id="productCode" name="productCode" placeholder="제품코드"/>
					제품명 <input type="text" id="productName" name="productName" placeholder="제품명"/>
					<button id="findRow">검색</button>
				</div>
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
			code = grid.getValue(chkRowKeys[i],'productCode');
			console.log(code);
		}
		
		//선택한 값을 뿌려줄 view페이지의 input text 부분 id
		$("#productCode").val(code);
	});
	
	$(document).ready(function() {
		$(document).on("click", "button[id=findRow]",
				function() {
					var code = $("#productCode").val();
					console.log(code);
					var name = $("#productName").val();
					console.log(name);
					var readParams = {
						'erpProductCode' : code,
						'erpProductName' : name
					};
					grid.readData(1, readParams, true);
				});
	
	const dataSource = {
		api : {
			readData : {
				url : '${pageContext.request.contextPath}/mes/salInout/searchProductCode',
				method : 'GET'
			}
		},
		contentType : "application/json"
	};

	const grid = new tui.Grid({
		el : document.getElementById('modalGrid'),
		rowHeaders : [ 'checkbox' ],
		data : dataSource,
		columns : [ {
			header : '제품코드',
			name : 'comProductCode'
		}, {
			header : '제품명',
			name : 'comProductName'
		}, {
			header : '사이즈',
			name : 'comProductSize'
		} ]
	});
	
}); //end of document ready
</script>