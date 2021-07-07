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
var gridModal;

$(document).ready(function() {
	
	//확인버튼
	$(document).on("click","button[id=ok]", function(){
		//console.log(grid.getCheckedRowKeys()); //체크박스 선택된 행의 번호를 배열형태로 가져옴.
		//console.log(grid.getValue(chkRowKey,'comProductCode')); //행의 컬럼명으로 값을 가져옴.

		var chkRowKeys = gridModal.getCheckedRowKeys();
		for(var i=0; i<chkRowKeys.length; i++){
			erpOrderCode = gridModal.getValue(chkRowKeys[i],'erpOrderCode');
			erpProductCode = gridModal.getValue(chkRowKeys[i],'erpProductCode');
			erpProductName = gridModal.getValue(chkRowKeys[i],'erpProductName');
			erpOrderQty = gridModal.getValue(chkRowKeys[i],'erpOrderQty');
			erpProductDeadline = gridModal.getValue(chkRowKeys[i],'erpProductDeadline');
			erpCustomerCode = gridModal.getValue(chkRowKeys[i],'erpCustomerCode');
			
			console.log(erpOrderCode);
			console.log(erpProductCode);
			console.log(erpProductName);
			console.log(erpOrderQty);
			console.log(erpProductDeadline);
			console.log(erpCustomerCode);
			
			proPlanGrid.setValue(proPlanRowKey, 'erpProductCode', erpProductCode, false);
			proPlanGrid.setValue(proPlanRowKey, 'erpOrderCode', erpOrderCode, false);
			proPlanGrid.setValue(proPlanRowKey, 'erpProductName', erpProductName, false);
			proPlanGrid.setValue(proPlanRowKey, 'erpOrderQty', erpOrderQty, false);
			proPlanGrid.setValue(proPlanRowKey, 'erpProductDeadline', erpProductDeadline, false);
			proPlanGrid.setValue(proPlanRowKey, 'erpCustomerCode', erpCustomerCode, false);
		}
	});
	
	
	
	//검색버튼
	$(document).on("click", "a[id=findRow]", function() {
				var erpProductCode = $("#erpProductCode").val();
				var erpProductName = $("#erpProductName").val();
				
				var readParams = {
						'erpProductCode' : erpProductCode,
						'erpProductName' : erpProductName,
					};
				gridModal.readData(1, readParams, true);
			});
	
	//데이터소스
	const dataSource = {
		api : {
			readData : {
				url : '${pageContext.request.contextPath}/erpProductSearch',
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
		columns : [ {
			header : '주문코드',
			name : 'erpOrderCode'
		}, {
			header : '제품코드',
			name : 'erpProductCode'
		}, {
			header : '제품명',
			name : 'erpProductName'
		}, {
			header : '주문량',
			name : 'erpOrderQty'
		}, {
			header : '납기일자',
			name : 'erpProductDeadline',
			hidden : true
		}, {
			header : '고객사코드',
			name : 'erpCustomerCode',
			hidden : true
		} /*,  {
			header : '예상소요량',
			name : 'proPlanExpectQty',
			hidden : true
		}, {
			header : '예상일',
			name : 'proPlanDayQty',
			hidden : true
		}  */]
	});
	
	
	

	
}); //end of document ready
</script>