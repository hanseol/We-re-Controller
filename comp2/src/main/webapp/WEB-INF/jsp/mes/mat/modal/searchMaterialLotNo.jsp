<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="modal">  
<!-- 20210703 주성원 자재검색 모달창 -->
   
<div class="content-fluid">
	<div class="panel panel-headline">
		<h3>자재 검색</h3>
	</div>
</div>

<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-heading">
			<div class="panel-body">
				<div>
					자재LOT_NO<input type="text" id="matLot" name="matLot" placeholder="자재LOT_NO"/><br/>
					자재코드 <input type="text" id="materialCode" name="materialCode" placeholder="자재코드"/>
				 	자재명 <input type="text" id="materialName" name="materialName" placeholder="자재명"/>
				    <button id="modalSearch">검색</button>
				</div>
				<div id="matLotModalGrid"></div>
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

		var chkRowKeys = matLotModalGrid.getCheckedRowKeys();
		var code = [];
		for(var i=0; i<chkRowKeys.length; i++){
			matLotNo = matLotModalGrid.getValue(chkRowKeys[i], 'matLotNo');
			comMaterialCode = matLotModalGrid.getValue(chkRowKeys[i],'comMaterialCode');
			comMaterialName = matLotModalGrid.getValue(chkRowKeys[i],'comMaterialName');
			matInoutQuantity = matLotModalGrid.getValue(chkRowKeys[i],'matInoutQuantity');
			matInoutDate = matLotModalGrid.getValue(chkRowKeys[i],'matInoutDate');
			
			//view 페이지에 뿌려줄 부분 아이디값
			if(matrLotRowId == -1){
				$("#matLot").val(matLotNo);
			} else {
				materialGrid.blur();
				materialGrid.setValue(matrLotRowId, 'matLotNo', matLotNo, false);
				materialGrid.setValue(matrLotRowId, 'comMaterialCode', comMaterialCode, false);
				materialGrid.setValue(matrLotRowId, 'comMaterialName', comMaterialName, false);
				
				if (materialGrid.getValue(chkRowKeys[i], 'matInoutGubun') == 'INOUT002') { //입고이면
					materialGrid.setValue(matrLotRowId, 'matInoutQuantity', matInoutQuantity, false); //수량
				} else if(materialGrid.getValue(chkRowKeys[i], 'matMatchInout') != null) { //정산입출고이면
					materialGrid.setValue(matrLotRowId, 'matPastQuantity', matInoutQuantity, false); //기존수량
				}
				
			}
			
			
		}

		

	});

	
	$("#modalSearch").on("click", function() {
		var materialCode = $("#materialCode").val();
		
		var materialName = $("#materialName").val();
		
		var matLot = $("#matLot").val();
		
		var readParams = {
				'matLotNo' : matLot,
				'comMaterialCode' : materialCode,
				'comMaterialName' : materialName
			};
		matLotModalGrid.readData(1, readParams, true);
	});
	
	const dataSource = {
		api : {
			readData : {
				url : '${pageContext.request.contextPath}/ajax/searchMaterialLotNo',
				method : 'GET'
			}
		},
		contentType : "application/json"
	};

	const matLotModalGrid = new tui.Grid({
		el : document.getElementById('matLotModalGrid'),
		rowHeaders : [ 'checkbox' ],
		data : dataSource,
		scrollX: true,
        scrollY: true,
        bodyHeight :300,
        rowHeight: 30,
		columns : [ {
			header : '자재LOT_NO',
			name : 'matLotNo'
		}, {
			header : '자재코드',
			name : 'comMaterialCode'
		}, {
			header : '자재명',
			name : 'comMaterialName'
		}, {
			header : '수량',
			name : 'matInoutQuantity'
		}]
	});
	
}); //end of document ready
</script>
</div>