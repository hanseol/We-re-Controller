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
					자재코드 <input type="text" id="matCode" name="matCode" placeholder="자재코드"/>
				    자재명 <input type="text" id="materialName" name="materialName" placeholder="자재명"/>
				    <button id="modalSearch">검색</button>
				</div>
				<div id="matMatrModalGrid"></div>
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
	let matMatrModalGrid;
	
	//확인을 눌렀을 때 선택한 값이 있다면 그 값을 전달 해야 함.
	//일딴 한건만 선택했을 때의 경우.
	$(document).on("click","button[id=ok]", function(){

		var chkRowKeys = matMatrModalGrid.getCheckedRowKeys();
		
		for(var i=0; i<chkRowKeys.length; i++){
			comMaterialCode = matMatrModalGrid.getValue(chkRowKeys[i],'comMaterialCode');
			comMaterialName = matMatrModalGrid.getValue(chkRowKeys[i],'comMaterialName');
			comMaterialSize = matMatrModalGrid.getValue(chkRowKeys[i],'comMaterialSize');
			comMaterialUnit = matMatrModalGrid.getValue(chkRowKeys[i],'comMaterialUnit');
			
			//view 페이지에 뿌려줄 부분 아이디값
			if(materialRowId == -1){
				$("#materialCode").val(comMaterialCode);
			} else if(materialRowId == -2){
				$("#materialCodeTwo").val(comMaterialCode);
			} else {
				materialGrid.blur();
				console.log(materialRowId);
				materialGrid.setValue(materialRowId, 'comMaterialCode', comMaterialCode, false);
				materialGrid.setValue(materialRowId, 'comMaterialName', comMaterialName, false);
				materialGrid.setValue(materialRowId, 'comMaterialSize', comMaterialSize, false);
				materialGrid.setValue(materialRowId, 'comMaterialUnit', comMaterialUnit, false);
			}
		}

		

	});

	
	$(document).on("click", "button[id=modalSearch]", function() {
		var matCode = $("#matCode").val();
		
		var materialName = $("#materialName").val();
	
		var readParams = {
				'comMaterialCode' : matCode,
				'comMaterialName' : materialName
			};
		matMatrModalGrid.readData(1, readParams, true);
	});
	
	const dataSource = {
		api : {
			readData : {
				url : '${pageContext.request.contextPath}/ajax/searchMaterial',
				method : 'GET'
			}
		},
		contentType : "application/json"
	};

	matMatrModalGrid = new tui.Grid({
		el : document.getElementById('matMatrModalGrid'),
		rowHeaders : [ 'checkbox' ],
		data : dataSource,
			scrollX: true,
	        scrollY: true,
	        bodyHeight :300,
	        rowHeight: 30,
		columns : [ {
			header : '자재코드',
			name : 'comMaterialCode'
		}, {
			header : '자재명',
			name : 'comMaterialName'
		}, {
			header : '규격',
			name : 'comMaterialSize',
			hidden : true
		}, {
			header : '관리단위',
			name : 'comMaterialUnit',
			hidden : true
		}]
	});
	
}); //end of document ready
</script>
</div>