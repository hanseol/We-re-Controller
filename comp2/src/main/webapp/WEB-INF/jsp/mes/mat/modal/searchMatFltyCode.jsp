<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="modal">  
<!-- 20210703 주성원 자재불량코드 검색 모달창 -->
   
<div class="content-fluid">
	<div class="panel panel-headline">
		<h3>불량코드 검색</h3>
	</div>
</div>

<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-heading">
			<div class="panel-body">
				<div>
					자재불량코드 <input type="text" id="matFltyCode" name="matFltyCode" placeholder="자재불량코드"/>
				    불량명 <input type="text" id="fltyName" name="fltyName" placeholder="불량명"/>
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
		var code = [];
		for(var i=0; i<chkRowKeys.length; i++){
			comMaterialFCode = grid.getValue(chkRowKeys[i],'comMaterialFCode');
			comMaterialFName = grid.getValue(chkRowKeys[i],'comMaterialFName');
		}
		//view 페이지에 뿌려줄 부분 아이디값
		if(matFltyRowId == -1){
			$("#matFltyCode").val(comMaterialFCode);
		} else {
			matFltyGrid.blur();
			console.log(matFltyRowId);
			matFltyGrid.setValue(matFltyRowId, 'comMaterialFCode', comMaterialFCode, false);
			matFltyGrid.setValue(matFltyRowId, 'comMaterialFName', comMaterialFName, false);

			
		}
		

	});


	
	$(document).on("click", "button[id=findRow]", function() {
		var matFltyCode = $("#matFltyCode").val();
		
		var fltyName = $("#fltyName").val();
	
		var readParams = {
				'comMaterialFCode' : matFltyCode,
				'comMaterialFName' : fltyName
			};
		matFltyGrid.readData(1, readParams, true);
	});
	
	const dataSource = {
		api : {
			readData : {
				url : '${pageContext.request.contextPath}/ajax/searchMatFlty',
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
			header : '자재불량코드',
			name : 'comMaterialFCode'
		}, {
			header : '불량명',
			name : 'comMaterialFName'
		}, {
			header : '불량내역',
			name : 'comMaterialFDesc'
		}]
		
	}); 
}); //end of document ready
</script>
</div>