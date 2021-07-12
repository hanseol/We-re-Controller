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
					자재불량코드 <input type="text" id="matFltyCode" name="matFltyCode" placeholder="자재불량코드"/>
				    불량명 <input type="text" id="fltyName" name="fltyName" placeholder="불량명"/>
				    <button id="findRow">검색</button>
				</div>
				<div class="col-md-6" id="matPassGrid"></div>
				<div class="col-md-6" id="matFltyGrid"></div>
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
			quaMaterialPQty = grid.getValue(chkRowKeys[i],'quaMaterialPQty');
			quaMaterialFQty = grid.getValue(chkRowKeys[i],'quaMaterialFQty');
		}
		//view 페이지에 뿌려줄 부분 아이디값
		if(matFltyRowId == -1){
			$("#materialCode").val(comMaterialFCode);
		} else {
			matFltyGrid.blur();
			console.log(matFltyRowId);
			matFltyGrid.setValue(matFltyRowId, 'comMaterialFCode', comMaterialFCode, false);
			matFltyGrid.setValue(matFltyRowId, 'comMaterialFName', comMaterialFName, false);
			matFltyGrid.setValue(matFltyRowId, 'quaMaterialPQty', quaMaterialPQty, false);
			matFltyGrid.setValue(matFltyRowId, 'quaMaterialFQty', quaMaterialFQty, false);
			if ((quaMaterialPQty == null) || (quaMaterialFQty == null)){
				matFltyGrid.setValue(matFltyRowId, 'quaMaterialChk', 0, false);	
			}else{
				matFltyGrid.setValue(matFltyRowId, 'quaMaterialChk', 1, false);
			}
			
		}
		

	});


	
	$(document).on("click", "button[id=findRow]", function() {
		var matFltyCode = $("#matFltyCode").val();
		
		var fltyName = $("#fltyName").val();
	
		var readParams = {
				'comMaterialFCode' : matFltyCode,
				'comMaterialFName' : fltyName
			};
		grid.readData(1, readParams, true);
	});
	
	const matPassDataSource = {
		api : {
			readData : {
				url : '${pageContext.request.contextPath}/ajax/searchMatFltyQty',
				method : 'GET'
			}
		},
		contentType : "application/json"
	};
	const matPassGrid = new tui.Grid({
		el : document.getElementById('matPassGrid'),
		data : matPassDataSource,
		scrollX: false,
        scrollY: true,
        bodyHeight :500,
        rowHeight: 30,
		columns : [ {
			header : '발주량',
			name : 'erpMaterialOrderQty'
		}, {
			header : '합격량',
			name : 'quaMaterialPQty',
			editor: 'text'
		}, {
			header : '불량량',
			name : 'quaMaterialFQty',
			editor: 'text'
		}]
	});
	
	const matFltyDataSource = {
		api : {
			readData : {
				url : '${pageContext.request.contextPath}/ajax/searchMatFlty',
				method : 'GET'
			}
		},
		contentType : "application/json"
	};

	const matFltyGrid = new tui.Grid({
		el : document.getElementById('matFltyGrid'),
		rowHeaders : [ 'checkbox' ],
		data : matFltyDataSource,
			scrollX: false,
	        scrollY: true,
	        bodyHeight :500,
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
	
	//발주코드 값 들고오기
	var readParam = {
			'erpMaterialOrderCode' : erpMaterialOrderCode
		};
	matPassGrid.readData(1, readParam, true);
	
	
		matPassGrid.on('afterChange',ev => {
		//자동 계산 
		var qty = matPassGrid.getValue( ev.changes[0].rowKey, 'quaMaterialPQty');
		var unitPrice = grid.getValue( ev.changes[0].rowKey, 'erpMaterialUnitPrice');
		grid.setValue( ev.changes[0].rowKey, 'matInoutPrice', qty*unitPrice);
		
	}); 
}); //end of document ready
</script>
</div>