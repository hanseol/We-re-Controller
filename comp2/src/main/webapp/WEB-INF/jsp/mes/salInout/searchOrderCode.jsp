<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!-- 210705 김현경 지시/고객사구분 모달창 -->

<div class="content-fluid">
	<div class="panel panel-headline">
		<h3>지시 코드</h3>
	</div>
</div>

<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-heading">
			<div class="panel-body">
				<div>
					생산지시디테일코드 <input type="text" id="proOrderDetailCode" name="proOrderDetailCode" placeholder="생산지시디테일코드" />
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
			code = grid.getValue(chkRowKeys[i],'salInoutCode');
		}
		
		//view 페이지에 뿌려줄 부분 아이디값
		 $("#gridInoutCode").val(code);
	
	});
	
	$(document).on("click", "button[id=findRow]", function() {
		var code = $("#proOrderDetailCode").val();
		var no = $("#proProcessLotNo").val();
		console.log(code, no);
		var readParams = { //실제컬럼명 : ~
				'proOrderDetailCode' : code,
				'proProcessLotNo' : no
			};
		grid.readData(1, readParams, true);
	});
	
	const dataSource = {
		api : {
			readData : { //url = modal 페이지
				url : '${pageContext.request.contextPath}/mes/salInout/searchOrderCode',
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
			header : '생산지시디테일코드',
			name : 'proOrderDetailCode'
		}, {
			header : '고객사',
			name : 'erpCustomerCode'
		}, {
			header : '제품코드',
			name : 'erpProductCode'
		}, {
			header : '완제품 LOT_NO',
			name : 'proProcessLotNo'
		}]
	});
});
//end of document ready
</script>