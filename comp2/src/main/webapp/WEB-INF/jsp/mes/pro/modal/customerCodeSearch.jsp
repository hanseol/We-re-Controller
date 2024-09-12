<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>



<!-- 공용 모달 -->



<div class="content-fluid">
	<div class="panel panel-headline">
		<h3>고객사 검색</h3>
	</div>
</div>

<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-heading">
			<div class="panel-body">
				<div>
					고객코드 <input type="text" id="comCodeDetailId" name="comCodeDetailId" placeholder="고객코드"/>
					고객명 <input type="text" id="comCodeDetailName" name="comCodeDetailName" placeholder="고객명"/>
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
			comCodeDetailId = gridModal.getValue(chkRowKeys[i],'comCodeDetailId');
			comCodeDetailName = gridModal.getValue(chkRowKeys[i],'comCodeDetailName');
			
			console.log(comCodeDetailId);
			
			$("#erpCustomerCode").val(comCodeDetailId);
			$("#erpCustomerName").val(comCodeDetailName);
		}
	});
	
	
	//데이터소스
	const dataSource = {
		api : {
			readData : {
				url : '${pageContext.request.contextPath}/CustomerCode',
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
			header : '고객코드',
			name : 'comCodeDetailId'
		}, {
			header : '고객명',
			name : 'comCodeDetailName'
		}]
	});
}); //end of document ready

</script>