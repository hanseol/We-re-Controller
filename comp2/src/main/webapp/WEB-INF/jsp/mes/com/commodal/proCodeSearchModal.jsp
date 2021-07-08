<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="modal">  

<div class="content-fluid">
	<div class="panel panel-headline">
		<h3>공정 검색</h3>
	</div>
</div>

<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-heading">
			<div class="panel-body">
				<div>
					공정코드 <input type="text" id="comProcessCode" name="comProcessCode" placeholder="공정코드"/>
					공정명<input type="text" id="comProcessName" name="comProcessName"placeholder="공정명"/>
					<button id="findRowProcModal">검색</button>
				</div>
				<div id="procModalGrid"></div>
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
	//체크박스 값 변수 저장
	$(document).on("click","button[id=ok]", function(){
		var chkRowKeys = grid.getCheckedRowKeys();
		var code = [];
		for(var i=0; i<chkRowKeys.length; i++){
			comProcessCode = grid.getValue(chkRowKeys[i],'comProcessCode');
			comProcessName = grid.getValue(chkRowKeys[i],'comProcessName');
		}
		//view 페이지에 뿌려줄 부분 아이디값
		if(comProcId == -1){
			$("#comProcessCode").val(comProcessCode);
		} else {
			procGrid.blur();
			console.log(comProcId);
			procGrid.setValue(comProcId, 'comProcessCode', comProcessCode, false);
			procGrid.setValue(comProcId, 'comProcessName', comProcessName, false);
		}
		
	});

	//검색버튼
	$(document).on("click", "button[id=findRowProcModal]", function() {
		var comProcessCode = $("#comProcessCode").val();
		console.log(comProcessCode);
		var comProcessName = $("#comProcessName").val();
		console.log(comProcessName);
		var readParams = {
				'comProcessCode' : comProcessCode,
				'comProcessName' : comProcessName
			};
		procGrid.readData(1, readParams, true);
	});
	
	const dataSource = {
			api : {
				readData : {
					url : '${pageContext.request.contextPath}/mes/com/prodUseMatr/proCodeSearchModal',
					method : 'GET'
				},
			},
			contentType : "application/json"
		};
		
	const grid = new tui.Grid({
			el : document.getElementById('procModalGrid'),
			rowHeaders : [ 'checkbox' ],
			data : dataSource,
		    scrollX: true,
		    scrollY: true,
		    bodyHeight :300,
		    rowHeight: 30,
			columns : [ {
				header : '공정코드',
				name : 'comProcessCode'
			}, {
				header : '공정명',
				name : 'comProcessName'
			}, {
				header : '공정설명',
				name : 'comProcessDesc'
			} ]
		});
}); //end of document ready
</script>
</div>