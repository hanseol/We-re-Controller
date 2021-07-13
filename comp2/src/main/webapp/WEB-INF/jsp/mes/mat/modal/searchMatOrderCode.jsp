<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="modal">  
<!-- 20210703 주성원 자재검색 모달창 -->
   
<div class="content-fluid">
	<div class="panel panel-headline">
		<h3>자재발주 검색</h3>
	</div>
</div>

<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-heading">
			<div class="panel-body">
				<div>
					발주코드 <input type="text" id="orderCode" name="orderCode" placeholder="발주코드"/>
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
	//일딴 한건만 선택했을 때의 경우.
	$(document).on("click","button[id=ok]", function(){

		var chkRowKeys = grid.getCheckedRowKeys();
		for(var i=0; i<chkRowKeys.length; i++){
			erpMaterialOrderCode = grid.getValue(chkRowKeys[i],'erpMaterialOrderCode');
			erpMaterialRequestDate = grid.getValue(chkRowKeys[i],'erpMaterialRequestDate');
			erpMaterialOrderQty = grid.getValue(chkRowKeys[i],'erpMaterialOrderQty');
			erpMaterialUnitPrice = grid.getValue(chkRowKeys[i],'erpMaterialUnitPrice');
			erpVendorCode = grid.getValue(chkRowKeys[i],'erpVendorCode');
			comCodeDetailName = grid.getValue(chkRowKeys[i],'comCodeDetailName');
			comMaterialCode = grid.getValue(chkRowKeys[i],'comMaterialCode');
			comMaterialName = grid.getValue(chkRowKeys[i],'comMaterialName');
			comMaterialSize = grid.getValue(chkRowKeys[i],'comMaterialSize');
			comMaterialUnit = grid.getValue(chkRowKeys[i],'comMaterialUnit');
		}
		//로우아이디
		if(matOrderRowId == -1){
			$("#matOrderCode").val(erpMaterialOrderCode);
		} else {
			orderGrid.blur();
			console.log(matOrderRowId);
			orderGrid.setValue(matOrderRowId, 'erpMaterialOrderCode', erpMaterialOrderCode, false);
			orderGrid.setValue(matOrderRowId, 'quaMaterialDate', erpMaterialRequestDate, false);
			orderGrid.setValue(matOrderRowId, 'erpMaterialOrderQty', erpMaterialOrderQty, false);
			orderGrid.setValue(matOrderRowId, 'erpMaterialUnitPrice', erpMaterialUnitPrice, false);
			orderGrid.setValue(matOrderRowId, 'erpVendorCode', erpVendorCode, false);
			orderGrid.setValue(matOrderRowId, 'comCodeDetailName', comCodeDetailName, false);
			orderGrid.setValue(matOrderRowId, 'comMaterialCode', comMaterialCode, false);
			orderGrid.setValue(matOrderRowId, 'comMaterialName', comMaterialName, false);
			orderGrid.setValue(matOrderRowId, 'comMaterialSize', comMaterialSize, false);
			orderGrid.setValue(matOrderRowId, 'comMaterialUnit', comMaterialUnit, false);
			orderGrid.setValue(matOrderRowId, 'quaMaterialChk', 0, false);
			orderGrid.setValue(matOrderRowId, 'quaMaterialPQty', 0, false);
			orderGrid.setValue(matOrderRowId, 'quaMaterialFQty', 0, false);
		}
		

	});

	
	$(document).on("click", "button[id=findRow]", function() {
		var orderCode = $("#orderCode").val();
		
		var materialCode = $("#materialCode").val();
		
		var materialName = $("#materialName").val();
	
		var readParams = {
				'erpMaterialOrderCode' : orderCode,
				'comMaterialCode' : materialCode,
				'comMaterialName' : materialName
			};
		grid.readData(1, readParams, true);
	});
	
	const dataSource = {
		api : {
			readData : {
				url : '${pageContext.request.contextPath}/ajax/searchMatOrder',
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
			header : '발주코드',
			name : 'erpMaterialOrderCode'
		}, {
			header : '발주신청일자',
			name : 'erpMaterialOrderDate'
		}, {
			header : '납품요청일',
			name : 'erpMaterialRequestDate'
		}, {
			header : '업체코드',
			name : 'erpVendorCode',
			hidden: true
		}, {
			header : '업체명',
			name : 'comCodeDetailName',
			hidden: true
		}, {
			header : '자재코드',
			name : 'comMaterialCode',
			hidden: true
		}, {
			header : '자재명',
			name : 'comMaterialName',
			hidden: true
		}, {
			header : '규격',
			name : 'comMaterialSize',
			hidden: true
		}, {
			header : '관리단위',
			name : 'comMaterialUnit',
			hidden: true
		}]
	});
	
}); //end of document ready
</script>
</div>