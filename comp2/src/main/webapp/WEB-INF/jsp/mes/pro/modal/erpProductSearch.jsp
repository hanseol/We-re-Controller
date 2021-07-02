<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      
<div class="content-fluid">
	<div class="panel panel-headline">
		<h3>제품 검색</h3>
	</div>
</div>

<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-heading">
			<div class="panel-body">
				<div>
					제품코드 <input type="text" id="erpProductCode" name="erpProductCode" placeholder="제품코드"/>
					제품명 <input type="text" id="erpProductName" name="erpProductName" placeholder="제품명"/>
					<!-- <i class="fa fa-search" id="findRow"></i> -->
				</div> <br/>
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
		//console.log(grid.getCheckedRowKeys()); //체크박스 선택된 행의 번호를 배열형태로 가져옴.
		//console.log(grid.getValue(chkRowKey,'comProductCode')); //행의 컬럼명으로 값을 가져옴.

		var chkRowKeys = grid.getCheckedRowKeys();
		var code = [];
		for(var i=0; i<chkRowKeys.length; i++){
			code = grid.getValue(chkRowKeys[i],'erpProductCode');
			console.log(code);
		}
		
		$("#no").val(code);
	});
	
	$(document).on("click", "button[id=findRow]", function() {
		var code = $("#erpOrderCode").val();
		/* console.log(code); */
		var name = $("#erpProductCode").val();
		/* console.log(name); */
		var name = $("#erpProductName").val();
		var name = $("#erpOrderQty").val();	
		
		var readParams = {
				'erpOrderCode' : erpOrderCode,
				'erpProductCode' : erpProductCode,
				'erpProductName' : erpProductName,
				'erpOrderQty' : erpOrderQty
			};
		grid.readData(1, readParams, true);
	});
	
	const dataSource = {
		api : {
			readData : {
				url : '${pageContext.request.contextPath}/erpProductSearch',
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
        onCellSelect : function(rowid, iCol, cellcontent, e) {
        	//rowid : id of the row , iCol : index of the cell , cellcontent : content of the cell , e : event object
        	var select = jQuery('#select').jqGrid
        },
		columns : [ {
			header : '주문코드',
			name : 'erpOrderCode',
			id : 'select'
		}, {
			header : '제품코드',
			name : 'erpProductCode'
		}, {
			header : '제품명',
			name : 'erpProductName'
		}, {
			header : '주문량',
			name : 'erpOrderQty'
		} ]
	});
	
}); //end of document ready
</script>