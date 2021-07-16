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
					자재LOT_NO<input type="text" id="matLotNo" name="matLotNo" placeholder="자재LOT_NO"/>
					자재코드 <input type="text" id="comMaterialCode" name="comMaterialCode" placeholder="자재코드"/>
				 	자재명 <input type="text" id="comMaterialName" name="comMaterialName" placeholder="자재명"/>
				    <button id="findRow">검색</button>
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
	
	//그리드 선언을 ready밖으로 빼기
	//(모달 취소하고 다시 모달 들어가서 체크하면 값을 찾지 못하는 현상 해결)
	let matLotModalGrid;
	
	
	//확인을 눌렀을 때 선택한 값이 있다면 그 값을 전달 해야 함.
	//일딴 한건만 선택했을 때의 경우.
	$(document).on("click","button[id=ok]", function(){

		var chkRowKeys = matLotModalGrid.getCheckedRowKeys();
		var code = [];
		for(var i=0; i<chkRowKeys.length; i++){
			matLotNo = matLotModalGrid.getValue(chkRowKeys[i], 'matLotNo');
			comMaterialCode = matLotModalGrid.getValue(chkRowKeys[i],'comMaterialCode');
			comMaterialName = matLotModalGrid.getValue(chkRowKeys[i],'comMaterialName');
			matInoutQuantity = matLotModalGrid.getValue(chkRowKeys[i],'matInoutQuantity');
			
			//view 페이지에 뿌려줄 부분 아이디값
			if(matrLotRowId == -1){
				$("#matLot").val(matLotNo);
			} else {
				materialGrid.blur();
				materialGrid.setValue(matrLotRowId, 'matLotNo', matLotNo, false);
				materialGrid.setValue(matrLotRowId, 'comMaterialCode', comMaterialCode, false);
				materialGrid.setValue(matrLotRowId, 'comMaterialName', comMaterialName, false);
				materialGrid.setValue(matrLotRowId, 'matInoutQuantity', matInoutQuantity, false);
			}
			
			
		}

		

	});

	
	$(document).on("click", "button[id=findRow]", function() {
		var comMaterialCode = $("#comMaterialCode").val();
		
		var comMaterialName = $("#comMaterialName").val();
		
		var matLotNo = $("#matLotNo").val();
		
		var readParams = {
				'matLotNo' : matLotNo,
				'comMaterialCode' : comMaterialCode,
				'comMaterialName' : comMaterialName
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

	matLotModalGrid = new tui.Grid({
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
		}]
	});
	
}); //end of document ready
</script>
</div>