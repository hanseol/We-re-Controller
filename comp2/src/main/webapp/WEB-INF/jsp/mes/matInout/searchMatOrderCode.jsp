<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
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
					<button type="button" id="findRow"><i class="fa fa-search"></i></button>
				        업체명 <input type="text" id="comCodeDetailName" name="comCodeDetailName" placeholder="업체명"/>
				    <button type="button" id="findRow"><i class="fa fa-search"></i></button>
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
		//console.log(grid.getCheckedRowKeys()); //체크박스 선택된 행의 번호를 배열형태로 가져옴.
		//console.log(grid.getValue(chkRowKey,'comProductCode')); //행의 컬럼명으로 값을 가져옴.

		var chkRowKeys = grid.getCheckedRowKeys();
		var code = [];
		for(var i=0; i<chkRowKeys.length; i++){
			code = grid.getValue(chkRowKeys[i],'comCodeDetailId');
			console.log(code);
		}
		
		$("#comCodeDetailId").val(code);
	});

	
	$(document).on("click", "button[id=findRow]", function() {
		var comCodeDetailId = $("#comCodeDetailId").val();
		console.log(comCodeDetailId);
		
		var comCodeDetailName = $("#comCodeDetailName").val();
		console.log(comCodeDetailName);
		
		var comCodeDetailDesc = $("#comCodeDetailDesc").val();
		console.log(comCodeDetailDesc);
	
		var readParams = {
				'comCodeDetailId' : comCodeDetailId,
				'comCodeDetailName' : comCodeDetailName,
				'comCodeDetailDesc' : comCodeDetailDesc
			};
		grid.readData(1, readParams, true);
	});
	
	const dataSource = {
		api : {
			readData : {
				url : '${pageContext.request.contextPath}/ajax/matInout/searchVendorCode',
				method : 'GET'
			}
		},
		contentType : "application/json"
	};

	const grid = new tui.Grid({
		el : document.getElementById('modalGrid'),
		rowHeaders : [ 'checkbox' ],
		data : dataSource,
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