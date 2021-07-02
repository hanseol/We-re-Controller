<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 20210701 경윤수 모달창에 넣을 뷰 페이지 출력-->
<style type="text/css">
</style>

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
					공통코드 <input type="text" id="comCodeId" name="comCodeId" placeholder="공통코드" /> 
					코드명 <input type="text" id="comCodeName" name="comCodeName" placeholder="코드명" />
					<button id="findRow">검색</button>
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
	//확인을 눌렀을 때 선택한 값이 있다면 그 값을 전달 해야 함.
	//일딴 한건만 선택했을 때의 경우.
	$(document).on("click","button[id=ok]", function(){
		//console.log(grid.getCheckedRowKeys()); //체크박스 선택된 행의 번호를 배열형태로 가져옴.
		//console.log(grid.getValue(chkRowKey,'comProductCode')); //행의 컬럼명으로 값을 가져옴.
		
	
		var chkRowKeys = grid.getCheckedRowKeys();
		var code = [];
		for(var i=0; i<chkRowKeys.length; i++){
			code = grid.getValue(chkRowKeys[i],'comCodeId');
			console.log(code);
		}
		
		$("#comCodeId").val(code);
	});
	
	$(document).on("click", "button[id=findRow]", function() {
		var code = $("#comCodeId").val();
		console.log(code);
		var name = $("#comCodeName").val();
		console.log(name);
		var readParams = {
				'comCodeId' : comCodeId,
				'comCodeName' : comCodeName
			};
		grid.readData(1, readParams, true);
	});
	
	const dataSource = {
			api : {
				readData : {
					url : '${pageContext.request.contextPath}/mes/com/comCode/ComCodeModal',
					method : 'GET'
				},
			},
			contentType : "application/json"
		};
		
		const grid = new tui.Grid({
			el : document.getElementById('modalGrid'),
			data : dataSource,
		    scrollX: true,
		    scrollY: true,
		    bodyHeight :300,
		    rowHeight: 30,
			columns : [ {
				header : '공통코드',
				name : 'comCodeId',
			}, {
				header : '공통코드명',
				name : 'comCodeName',
			} ]
		});
}); //end of document ready
</script>