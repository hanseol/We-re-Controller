<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>



<!-- 공용 모달 -->



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
					제품코드 <input type="text" id="comProductCode" name="comProductCode" placeholder="제품코드"/>
					제품명 <input type="text" id="comProductName" name="comProductName" placeholder="제품명"/>
					<a id="findRow"><i class="fa fa-search"></i></a>
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
var gridModal;

$(document).ready(function() {
	
	//확인버튼
	$("#ok").on("click", function(){

		var chkRowKeys = gridModal.getCheckedRowKeys();
		for(var i=0; i<chkRowKeys.length; i++){
			comProductCode = gridModal.getValue(chkRowKeys[i],'comProductCode');
			comProductName = gridModal.getValue(chkRowKeys[i],'comProductName');
			
			console.log(comProductCode);
			
			$("#erpProductCode").val(comProductCode);
			$("#erpProductName").val(comProductName);
		}
	});
	
	
	//데이터소스
	const dataSource = {
		api : {
			readData : {
				url : '${pageContext.request.contextPath}/ProdCode',
				method : 'GET'
			}
		},
		contentType : "application/json"
	};  //end of dataSource

	
	//그리드
	gridModal = new tui.Grid({
		el : document.getElementById('modalGrid'),
		rowHeaders : [ 'checkbox' ],
		data : dataSource,
	   	scrollX: true,
        scrollY: true,
        bodyHeight :300,
        rowHeight: 30,
		columns : [  {
			header : '제품코드',
			name : 'comProductCode'
		}, {
			header : '제품명',
			name : 'comProductName'
		}]
	});
}); //end of document ready

</script>