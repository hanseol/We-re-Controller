<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="modal"> 

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
					제품코드 <input type="text" id="comProductCode" placeholder="제품코드"/>
					제품명<input type="text" id="comProductName" placeholder="제품명"/>
					<button id="findRowProdModal">검색</button>
				</div>
				<div id="modalGrid"></div>
			</div>
		</div>
	</div>
</div>

<div class="content-fluid">
	<a href="#" rel="modal:close"><button id="ok">확인</button></a> <a
		href="#" rel="modal:close"><button id="cancle">취소</button></a>
</div>

<script>
$(document).ready(function() {
	
	//체크박스 값 변수 저장
	$(document).on("click","button[id=ok]", function(){
		var chkRowKeys = grid.getCheckedRowKeys();
		var ProductCode = [];
		for(var i=0; i<chkRowKeys.length; i++){
			ProductCode = grid.getValue(chkRowKeys[i],'comProductCode');
			console.log(ProductCode);
		}
		
		$("#productCode").val(ProductCode);
	});
	
	$(document).on("click", "button[id=findRowProdModal]", function() {
		var ProductCode = $("#comProductCode").val();
		console.log(ProductCode);
		var ProductName = $("#comProductName").val();
		console.log(ProductName);
		var readParams = {
				'comProductCode' : ProductCode,
				'comProductName' : ProductName
			};
		grid.readData(1, readParams, true);
	});
	
	const dataSource = {
			api : {
				readData : {
					url : '${pageContext.request.contextPath}/mes/com/prodUseMatr/ProdUseMatrModal',
					method : 'GET'
				},
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
				header : '제품코드',
				name : 'comProductCode'
			}, {
				header : '제품명',
				name : 'comProductName'
			}, {
				header : '규격',
				name : 'comProductUnit'
			} ]
		});
}); //end of document ready
</script>
</div>