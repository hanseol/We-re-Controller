<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!-- 210705 김현경 지시/고객사구분 모달창 -->

<div class="content-fluid">
	<div class="panel panel-headline">
		<h3>설비 리스트</h3>
	</div>
</div>

<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-heading">
			<div class="panel-body">
				<div>
					제품코드 <input type="text" id="comProductCode" name="comProductCode" placeholder="PROD001~PROD999" />
					설비라인 <input type="text" id="macLineNo" name="macLineNo" placeholder="LINE001~LINE999" />
					<button id="findRow">검색</button>
					<br>
				<div id="macListGrid"></div>
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
	$("#ok").on("click", function(){
		var chkRowKeys = macGrid.getCheckedRowKeys();
		if(chkRowKeys.length!=0){
			var code = macGrid.getValue(chkRowKeys,'macCode');			
			$("#mac").val(code);
		}
	});
	
	$(document).on("click", "button[id=findRow]", function() {
		var prodCode = $("#comProductCode").val();
		var macLineNo = $("#macLineNo").val();
		
		var readParams = { 
				'comProductCode' : prodCode,
				'macLineNo' : macLineNo
			};
		macGrid.readData(1, readParams, true);
	});
	
	const dataSource = {
		api : {
			readData : { //url = modal 페이지
				url : '${pageContext.request.contextPath}/ajax/mac/macList',
				method : 'GET'
			}
		},
		contentType : "application/json"
	};

	const macGrid = new tui.Grid({
		el : document.getElementById('macListGrid'),
		rowHeaders : [ 'checkbox' ],
		data : dataSource,
			scrollX: true,
	        scrollY: true,
	        bodyHeight :500,
	        rowHeight: 30,
		columns : [ {
			header : '설비코드',
			name : 'macCode',
			align : 'center'
		}, {
			header : '설비라인',
			name : 'macLineNo',
			align : 'center'
		},	{
			header : '용도',
			name : 'macUsePurpose',
			align : 'center'
		}, {
			header : '차기점검일',
			name : 'macNextChkDate',
			align : 'center'
		}]
	});
});
//end of document ready
</script>