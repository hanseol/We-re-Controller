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
					
					자재코드 <input type="text" id="materialCode" name="materialCode" placeholder="자재코드"/>
				        자재명 <input type="text" id="materialName" name="materialName" placeholder="자재명"/>
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
		columns : [{
			header : '발주입고일자',
			name : 'erpMaterialRequestDate'
		}, {
			header : '발주코드',
			name : 'erpMaterialOrderCode'
		}, {
			header : '자재명',
			name : 'comMaterialName'
		} ]
	});
	
}); //end of document ready
</script>
</div>