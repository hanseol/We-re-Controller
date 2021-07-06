<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      
<div class="content-fluid">
	<div class="panel panel-headline">
		<h3>생산계획 검색</h3>
	</div>
</div>

<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-heading">
			<div class="panel-body">
				<div>
					계획일자<input type="date" id="startDate" name="startDate"> 
					   ~ <input type="date" id="endDate" name="endDate">
					<a id="findRow"><i class="fa fa-search" href="erpProductSearch"></i></a>
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
		//console.log(grid.getCheckedRowKeys()); //체크박스 선택된 행의 번호를 배열형태로 가져옴.
		//console.log(grid.getValue(chkRowKey,'comProductCode')); //행의 컬럼명으로 값을 가져옴.

		var chkRowKeys = gridModal.getCheckedRowKeys();
		var code = [];
		for(var i=0; i<chkRowKeys.length; i++){
			proPlanName = gridModal.getValue(chkRowKeys[i],'proPlanName');
			proPlanDate = gridModal.getValue(chkRowKeys[i],'proPlanDate');
			
			/* erpProductCode = gridModal.getValue(chkRowKeys[i],'erpProductCode');
			erpProductName = gridModal.getValue(chkRowKeys[i],'erpProductName');
			erpOrderCode = gridModal.getValue(chkRowKeys[i],'erpOrderCode');
			erpProductDeadline = gridModal.getValue(chkRowKeys[i],'erpProductDeadline');
			erpOrderQty = gridModal.getValue(chkRowKeys[i],'erpOrderQty');
			proPlanQty = gridModal.getValue(chkRowKeys[i],'proPlanQty');
			proWorkDate = gridModal.getValue(chkRowKeys[i],'proWorkDate');
			proPlanSeq = gridModal.getValue(chkRowKeys[i],'proPlanSeq');
			erpCustomerCode = gridModal.getValue(chkRowKeys[i],'erpCustomerCode');
			proPlanExpectQty = gridModal.getValue(chkRowKeys[i],'proPlanExpectQty');
			proPlanDayQty = gridModal.getValue(chkRowKeys[i],'proPlanDayQty'); */
			
			
			
			console.log(proPlanName);
			console.log(proPlanDate);
			
			$("#proPlanName").val(proPlanName);
			$("#date").val(proPlanDate);
			
			/* proPlanGrid.setValue(chkRowKeys[i], 'erpProductCode', erpProductCode, false);
			proPlanGrid.setValue(chkRowKeys[i], 'erpOrderCode', erpOrderCode, false);
			proPlanGrid.setValue(chkRowKeys[i], 'erpProductName', erpProductName, false);
			proPlanGrid.setValue(chkRowKeys[i], 'erpOrderQty', erpOrderQty, false);
			proPlanGrid.setValue(chkRowKeys[i], 'erpProductDeadline', erpProductDeadline, false);
			proPlanGrid.setValue(chkRowKeys[i], 'erpCustomerCode', erpCustomerCode, false); */
			
		}
	}); //end of click button
	
	
	
	//검색버튼
	$(document).on("click", "a[id=findRow]", function() {
				var proPlanName = $("#proPlanName").val();
				var startDate = $("#startDate").val();
				var endDate = $("#endDate").val();
				var proPlanDate = $("#proPlanDate").val();
				var readParams = {
						'proPlanName' : proPlanName,
						'startDate' : startDate,
						'endDate' : endDate,
						'proPlanDate' : proPlanDate
					};
				gridModal.readData(1, readParams, true);
			}); //end of click a
	
	//데이터소스		
	const dataSource = {
		api : {
			readData : {
				url : '${pageContext.request.contextPath}/proPlanName',
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
			header : '계획번호',
			name : 'proPlanCode'
		}, {
			header : '계획명',
			name : 'proPlanName'
		}, {
			header : '계획일자',
			name : 'proPlanDate',
			id : 'select'
		} /* {
			header : '제품코드',
			name : 'erpProductCode',
			hidden : true
		}, {
			header : '제품명',
			name : 'erpProductName',
			hidden : true
		}, {
			header : '주문코드',
			name : 'erpOrderCode',
			hidden : true
		}, {
			header : '납기일자',
			name : 'erpProductDeadline',
			hidden : true
		}, {
			header : '주문량',
			name : 'erpOrderQty',
			hidden : true
		}, {
			header : '작업계획량',
			name : 'proPlanQty',
			hidden : true
		}, {
			header : '작업착수일',
			name : 'proWorkDate',
			hidden : true
		}, {
			header : '작업순서',
			name : 'proPlanSeq',
			hidden : true
		}, {
			header : '고객사코드',
			name : 'erpCustomerCode',
			hidden : true
		}, {
			header : '예상소요량',
			name : 'proPlanExpectQty',
			hidden : true
		}, {
			header : '예상일',
			name : 'proPlanDayQty',
			hidden : true
		} */]
	});
	
	
}); //end of document ready
</script>