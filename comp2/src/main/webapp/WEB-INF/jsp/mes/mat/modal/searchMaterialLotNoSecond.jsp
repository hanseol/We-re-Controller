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
				<div class="col-md-12" align="left">
					자재LOT_NO&nbsp;&nbsp;&nbsp;<input type="text" id="modalMatLotSecond" name="modalMatLotSecond" placeholder="자재LOT_NO"/>
				</div>
				<div class="col-md-12"><br/></div>
				<div class="col-md-5" align="left">
					&nbsp;&nbsp;자재코드&nbsp;&nbsp;&nbsp;<input type="text" id="modalMaterialCodeSecond" name="modalMaterialCodeSecond" placeholder="자재코드"/>
				</div>
				<div class="col-md-7" align="left">
				 	자재명&nbsp;&nbsp;&nbsp;<input type="text" id="modalMaterialNameSecond" name="modalMaterialNameSecond" placeholder="자재명"/>
				    <button id="modalSearch">검색</button>
				</div>
				<div class="col-md-12"><br/></div>
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
	$(document).on("click","button[id=ok]", function(){

		var chkRowKeys = matLotModalGrid.getCheckedRowKeys();
		var code = [];
		for(var i=0; i<chkRowKeys.length; i++){
			matLotNo = matLotModalGrid.getValue(chkRowKeys[i], 'matLotNo');
			comMaterialCode = matLotModalGrid.getValue(chkRowKeys[i],'comMaterialCode');
			comMaterialName = matLotModalGrid.getValue(chkRowKeys[i],'comMaterialName');
			matInoutQuantity = matLotModalGrid.getValue(chkRowKeys[i],'matInoutQuantity');
			matInoutDate = matLotModalGrid.getValue(chkRowKeys[i],'matInoutDate');
			
			//view 페이지에 뿌려줄 부분 아이디값
			if(matrLotRowIdSecond == -1){
				$("#matLot").val(matLotNo);
			} else {
				materialGrid.blur();
				materialGrid.setValue(matrLotRowIdSecond, 'matLotNo', matLotNo, false);
				materialGrid.setValue(matrLotRowIdSecond, 'comMaterialCode', comMaterialCode, false);
				materialGrid.setValue(matrLotRowIdSecond, 'comMaterialName', comMaterialName, false);
				
				if (matLotModalGrid.getValue(chkRowKeys[i], 'matInoutGubun') == 'INOUT002') { //입고이면
					materialGrid.setValue(matrLotRowIdSecond, 'matPastQuantity', matInoutQuantity, false); //수량
				} else if(materialGrid.getValue(matrLotRowIdSecond, 'matMatchInout') != null) { //정산입출고이면
					materialGrid.setValue(matrLotRowIdSecond, 'matPastQuantity', matInoutQuantity, false); //기존수량
				}
				
			}
			
			
		}

		

	});

	
	$("#modalSearch").on("click", function() {
		var modalMaterialCodeSecond = $("#modalMaterialCodeSecond").val();
		
		var modalMaterialNameSecond = $("#modalMaterialNameSecond").val();
		
		var modalMatLotSecond = $("#modalMatLotSecond").val();
		
		var readParams = {
				'matLotNo' : modalMatLotSecond,
				'comMaterialCode' : modalMaterialCodeSecond,
				'comMaterialName' : modalMaterialNameSecond
			};
		matLotModalGrid.readData(1, readParams, true);
	});
	
	const dataSource = {
		api : {
			readData : {
				url : '${pageContext.request.contextPath}/ajax/searchMaterialLotNoSecond',
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
		}, {
			header : '구분',
			name : 'matInoutQuantity',
			hidden : true
		}]
	});
	
}); //end of document ready
</script>
</div>