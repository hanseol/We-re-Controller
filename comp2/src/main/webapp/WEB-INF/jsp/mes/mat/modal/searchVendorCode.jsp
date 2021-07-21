<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="modal">	
<!-- 20210702 주성원 업체검색 모달창 -->
   
<div class="content-fluid">
	<div class="panel panel-headline">
		<h3>업체 검색</h3>
	</div>
</div>

<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-heading">
			<div class="panel-body">
				<div>
					업체코드 <input type="text" id="comCodeDetailId" name="comCodeDetailId" placeholder="업체코드"/>
				    업체명 <input type="text" id="comCodeDetailName" name="comCodeDetailName" placeholder="업체명"/>
				    <button id="findRow">검색</button>
				</div>
				<div id="vendorModalGrid"></div>
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
	//일딴 한건만 선택했을 때의 경우.
	$("#ok").on("click", function(){
		//console.log(grid.getCheckedRowKeys()); //체크박스 선택된 행의 번호를 배열형태로 가져옴.
		//console.log(grid.getValue(chkRowKey,'comProductCode')); //행의 컬럼명으로 값을 가져옴.

		var chkRowKeys = vendorModalGrid.getCheckedRowKeys();
		var code = [];
		for(var i=0; i<chkRowKeys.length; i++){
			comCodeDetailId = vendorModalGrid.getValue(chkRowKeys[i],'comCodeDetailId');
			comCodeDetailName = vendorModalGrid.getValue(chkRowKeys[i],'comCodeDetailName');
			
			if(vendorRowId == -1){
				$("#vendorCode").val(comCodeDetailId);
			} else if(vendorRowId == -2){
				$("#vendorCodeTwo").val(comCodeDetailId);
			} else if(vendorRowId == -3){//입고인풋 전달
				$("#inVendorCode").val(comCodeDetailId);
			} else if(vendorRowId == -4){//출고인풋 전달
				$("#outVendorCode").val(comCodeDetailId);
			} else {
			
				vendorGrid.blur();
				vendorGrid.setValue(vendorRowId, 'erpVendorCode', comCodeDetailId, false);
				vendorGrid.setValue(vendorRowId, 'comCodeDetailName', comCodeDetailName, false);
			}
			
		}
		

	});

	
	$("#findRow").on("click", function() {
		var comCodeDetailId = $("#comCodeDetailId").val();
		console.log(comCodeDetailId);
		
		var comCodeDetailName = $("#comCodeDetailName").val();
		console.log(comCodeDetailName);
	
		var readParams = {
				'comCodeDetailId' : comCodeDetailId,
				'comCodeDetailName' : comCodeDetailName
			};
		vendorModalGrid.readData(1, readParams, true);
	});
	
	const dataSource = {
		api : {
			readData : {
				url : '${pageContext.request.contextPath}/ajax/searchVendor',
				method : 'GET'
			}
		},
		contentType : "application/json"
	};

	const vendorModalGrid = new tui.Grid({
		el : document.getElementById('vendorModalGrid'),
		rowHeaders : [ 'checkbox' ],
		data : dataSource,
		scrollX: true,
		scrollY: true,
		bodyHeight :300,
		rowHeight: 30,
		columns : [ {
			header : '업체코드',
			name : 'comCodeDetailId'
		}, {
			header : '업체명',
			name : 'comCodeDetailName'
		}, {
			header : '납품목록',
			name : 'comCodeDetailDesc'
		}]
	});
	
}); //end of document ready
</script>
</div>