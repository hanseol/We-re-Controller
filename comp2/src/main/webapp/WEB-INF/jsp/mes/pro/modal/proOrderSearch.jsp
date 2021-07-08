<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      
<div class="content-fluid">
	<div class="panel panel-headline">
		<h3>생산지시 검색</h3>
	</div>
</div>

<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-heading">
			<div class="panel-body">
				<div>
					작업일자<input type="date" id="startDate" name="startDate"> 
					   ~ <input type="date" id="endDate" name="endDate">
					<a id="findRow"><i class="fa fa-search" href="proOrderSearch"></i></a>
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
	$(document).on("click","button[id=ok]", function(){
		var chkRowKeys = gridModal.getCheckedRowKeys();
		var code = [];
		for(var i=0; i<chkRowKeys.length; i++){
			proOrderCode = gridModal.getValue(chkRowKeys[i],'proOrderCode');
			proOrderDate = gridModal.getValue(chkRowKeys[i],'proOrderDate');
			proOrderGubun = gridModal.getValue(chkRowKeys[i],'proOrderGubun');
			
			console.log(proOrderCode);
			console.log(proOrderDate);
			console.log(proOrderGubun);
			
			$("#proOrderCode").val(proOrderCode);
			$("#proOrderDate").val(proOrderDate);
			$("#proOrderGubun").val(proOrderGubun);
			
		}
	}); //end of click button
	
	
	
	//검색버튼
	$(document).on("click", "a[id=findRow]", function() {
				var proOrderCode = $("#proOrderCode").val();
				var startDate = $("#startDate").val();
				var endDate = $("#endDate").val();
				var proOrderDate = $("#proOrderDate").val();
				var proOrderGubun = $("#proOrderGubun").val();
				
				var readParams = {
						'proOrderCode' : proOrderCode,
						'proOrderGubun' : proOrderGubun,
						'startDate' : startDate,
						'endDate' : endDate,
						'proOrderDate' : proOrderDate
					};
				gridModal.readData(1, readParams, true);
			}); //end of click a
	
	//데이터소스		
	const dataSource = {
		api : {
			readData : {
				url : '${pageContext.request.contextPath}/proOrderSearch',
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
			name : 'proOrderCode'
		}, {
			header : '지시일자',
			name : 'proOrderDate'
		}, {
			header : '지시구분',
			name : 'proOrderGubun'
		}]
	});
	
	
}); //end of document ready
</script>