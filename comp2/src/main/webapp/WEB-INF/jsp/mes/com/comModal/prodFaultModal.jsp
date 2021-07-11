<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="modal"> 

<div class="content-fluid">
	<div class="panel panel-headline">
		<h3>코드 검색</h3>
	</div>
</div>

<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-heading">
			<div class="panel-body">
				<div>
					불량코드 <input type="text" id="comCodeDetailId" placeholder="불량코드"/>
					불량코드명 <input type="text" id="comCodeDetailName" placeholder="불량코드명"/>
					<button id="findRowComCodeModal">검색</button>
				</div>
				<div id="prodFaultGrid"></div>
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
		var code = [];
		for(var i=0; i<chkRowKeys.length; i++){
			comCodeDetailId = grid.getValue(chkRowKeys[i],'comCodeDetailId');
			comCodeDetailName = grid.getValue(chkRowKeys[i],'comCodeDetailName');
		}
		//view 페이지에 뿌려줄 부분 아이디값
		if(FaultCode == -1){
			$("#comCodeDetailId").val(comCodeDetailId);
		} else {
			prodGrid.blur();
			console.log(FaultCode);
			prodGrid.setValue(FaultCode, 'comCodeDetailId', comCodeDetailId, false);
			prodGrid.setValue(FaultCode, 'comCodeDetailName', comCodeDetailName, false);
		}
		
	});
	
	//검색버튼
	$(document).on("click", "button[id=findRowProcModal]", function() {
		var comCodeDetailId = $("#comCodeDetailId").val();
		console.log(comCodeDetailId);
		var comCodeDetailName = $("#comCodeDetailName").val();
		console.log(comCodeDetailName);
		var readParams = {
				'comCodeDetailId' : comCodeDetailId,
				'comCodeDetailName' : comCodeDetailName
			};
		prodGrid.readData(1, readParams, true);
	});
	
	const dataSource = {
			api : {
				readData : {
					url : '${pageContext.request.contextPath}/mes/com/comModal/ProdFaultModal',
					method : 'GET'
				},
			},
			contentType : "application/json"
		};
		
		const grid = new tui.Grid({
			el : document.getElementById('prodFaultGrid'),
			rowHeaders : [ 'checkbox' ],
			data : dataSource,
		    scrollX: true,
		    scrollY: true,
		    bodyHeight :300,
		    rowHeight: 30,
			columns : [ {
				header : '불량코드',
				name : 'comCodeDetailId'
			}, {
				header : '불량코드명',
				name : 'comCodeDetailName'
			} ]
		});
}); //end of document ready
</script>
</div>