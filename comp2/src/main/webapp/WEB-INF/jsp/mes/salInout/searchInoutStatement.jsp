<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="modal">
<!-- 210707 김현경 전표번호 모달창 -->

<div class="content-fluid">
	<div class="panel panel-headline">
		<h3>출고 전표번호</h3>
	</div>
</div>

<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-heading">
			<div class="panel-body">
				<div>
					전표번호 <input type="text" id="salInoutStatement" name="salInoutStatement" placeholder="전표번호" /> &nbsp;
					완제품 LOT_NO <input type="text" id="proProcessLotNo" name="proProcessLotNo" placeholder="완제품 LOT_NO" />
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
			code = grid.getValue(chkRowKeys[i],'salInoutStatement');
			console.log(code);
			
			if (rowId == -1) { //rowId(rowKey)가 -1이면 input에 뿌려주고
				$("#inoutStatement").val(code);
			} else { //아니면 mgrid(모달그리드)에 뿌려준다
				mgrid.blur();
				mgrid.setValue(rowId, 'salInoutStatement', code, false);
			}
		}
		
		
	
	});
	
	$(document).on("click", "button[id=findRow]", function() {
		var code = $("#inoutStatement").val();
		var no = $("#proProcessLotNo").val();
		console.log(code, no);
		var readParams = { //실제컬럼명 : ~
				'salInoutStatement' : code,
				'proProcessLotNo' : no
			};
		grid.readData(1, readParams, true);
	});
	
	const dataSource = {
		api : {
			readData : { //url = modal 페이지
				url : '${pageContext.request.contextPath}/mes/salInout/searchInoutStatement',
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
			header : '전표번호',
			name : 'salInoutStatement'
		}, {
			header : '업체코드',
			name : 'salInoutCode'
		}, {
			header : '제품코드',
			name : 'comProductCode'
		}, {
			header : '완제품 LOT_NO',
			name : 'proProcessLotNo'
		}]
	});
});
//end of document ready
</script>
</div>	