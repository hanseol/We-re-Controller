<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>



<!-- 공정별 자재 소요 조회용 모달(전체) -->


      
<div class="content-fluid">
	<div class="panel panel-headline">
		<h3>전체 지시 검색</h3>
	</div>
</div>

<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-heading">
			<div class="panel-body">
				<div>
					지시일자<input type="date" id="startDate" name="startDate"> 
					   ~ <input type="date" id="endDate" name="endDate">
					<a id="findRow" href="finishOrderSearch.do">
						<i class="fa fa-search" ></i>
					</a>
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
	
	//확인버튼 
	$("#ok").click(function(){
		var chkRowKeys = gridModal.getCheckedRowKeys();
		var code = [];
		for(var i=0; i<chkRowKeys.length; i++){
			proOrderDetailCode = gridModal.getValue(chkRowKeys[i],'proOrderDetailCode');
		
			console.log(proOrderDetailCode);
		
			$("#totalProOrderDetailCode").val(proOrderDetailCode);
			
		}
	}); //end of click button
	
	
	
	//검색버튼
	$("#findRow").click(function() {
				var startDate = $("#startDate").val();
				var endDate = $("#endDate").val();
				var readParams = {
						'startDate' : startDate,
						'endDate' : endDate,
					};
				gridModal.readData(1, readParams, true);
			}); //end of click a
	
	//데이터소스		
	const dataSource = {
		api : {
			readData : {
				url : '${pageContext.request.contextPath}/totalOrderSearch',
				method : 'GET'
			}
		},
		contentType : "application/json"
	}; //end of dataSource

	//그리드
	const gridModal = new tui.Grid({
		el : document.getElementById('modalGrid'),
		rowHeaders : [ 'checkbox' ],
		data : dataSource,
	   	scrollX: true,
        scrollY: true,
        bodyHeight :300,
        rowHeight: 30,
		columns : [ {
			header : '지시번호',
			name : 'proOrderDetailCode'
		}, {
			header : '지시일자',
			name : 'proWorkDate'
		}, {
			header : '제품명',
			name : 'erpProductName'
		}, {
			header : '생산여부',
			name : 'proProcessStatus',
			align: 'center'
		} ]
	});
	
	
}); //end of document ready
</script>