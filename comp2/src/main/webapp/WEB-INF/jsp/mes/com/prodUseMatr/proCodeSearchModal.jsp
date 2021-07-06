<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style type="text/css">
</style>

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
					공정코드 <input type="text" id="comProcessCode" placeholder="공정코드"/>
					공정명<input type="text" id="comProcessName" placeholder="공정명"/>
					<button id="findRowProcModal">검색</button>
				</div>
				<div id="procModalGrid"></div>
			</div>
		</div>
	</div>
</div>

<div class="content-fluid">
	<a href="#" rel="modal:close"><button id="ok">확인</button></a> <a
		href="#" rel="modal:close"><button id="cancle">취소</button></a>
</div>

<script>
var procGrid
$(document).ready(function() {
	
	//체크박스 값 변수 저장
	$(document).on("click","button[id=ok]", function(){
		var chkRowKeys = procGrid.getCheckedRowKeys();
			ProcessCode = procGrid.getValue(chkRowKeys,'comProcessCode');
			ProcessName = procGrid.getValue(chkRowKeys,'comProcessName');
			
			console.log(ProcessCode);
			console.log(ProcessName);
		
			grid.setValue(0, 'comProcessCode', ProcessCode, false);
			grid.setValue(0, 'comProcessName', ProcessName, false);
	});
	
	//검색버튼
	$(document).on("click", "button[id=findRowProcModal]", function() {
		var ProcessCode = $("#comProcessCode").val();
		console.log(ProcessCode);
		var ProcessName = $("#comProcessName").val();
		console.log(ProcessName);
		var readParams = {
				'comProcessCode' : ProcessCode,
				'comProcessName' : ProcessName
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
		
	procGrid = new tui.Grid({
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
				header : '비고',
				name : 'comProductUnit'
			} ]
		});
}); //end of document ready
</script>