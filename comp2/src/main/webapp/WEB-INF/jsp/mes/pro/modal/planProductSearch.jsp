<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>



<!-- 생산지시용 모달 -->



<div class="content-fluid">
	<div class="panel panel-headline">
		<h3>계획된 제품 검색</h3>
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
	$("#ok").on("click", function(){
		/* var chkRowKeys = gridModal.getCheckedRows();
		proOrdergrid.appendRows(chkRowKeys); */
		var chkRowKeys = gridModal.getCheckedRowKeys();
		for(var i=0; i<chkRowKeys.length; i++){
			proPlanDetailCode = gridModal.getValue(chkRowKeys[i],'proPlanDetailCode');
			erpProductCode = gridModal.getValue(chkRowKeys[i],'erpProductCode');
			erpProductName = gridModal.getValue(chkRowKeys[i],'erpProductName');
			erpOrderCode = gridModal.getValue(chkRowKeys[i],'erpOrderCode');
			erpProductDeadline = gridModal.getValue(chkRowKeys[i],'erpProductDeadline');
			erpOrderQty = gridModal.getValue(chkRowKeys[i],'erpOrderQty');
			macHourQty = gridModal.getValue(chkRowKeys[i],'macHourQty');
			proOrderDayQty = gridModal.getValue(chkRowKeys[i],'proOrderDayQty');
			proPlanQty = gridModal.getValue(chkRowKeys[i],'proPlanQty');
			erpCustomerCode = gridModal.getValue(chkRowKeys[i],'erpCustomerCode');
			
			console.log(proPlanDetailCode);
			console.log(erpProductCode);
			console.log(erpProductName);
			console.log(erpOrderCode);
			console.log(erpProductDeadline);
			console.log(erpOrderQty);
			console.log(macHourQty);
			console.log(proOrderDayQty);
			
			proOrdergrid.setValue(proOrderRowKey, 'proPlanDetailCode', proPlanDetailCode, false);
			proOrdergrid.setValue(proOrderRowKey, 'erpOrderCode', erpOrderCode, false);
			proOrdergrid.setValue(proOrderRowKey, 'erpProductName', erpProductName, false);
			proOrdergrid.setValue(proOrderRowKey, 'erpProductCode', erpProductCode, false);
			proOrdergrid.setValue(proOrderRowKey, 'erpProductDeadline', erpProductDeadline, false);
			proOrdergrid.setValue(proOrderRowKey, 'erpOrderQty', erpOrderQty, false);
			proOrdergrid.setValue(proOrderRowKey, 'macHourQty', macHourQty, false);
			proOrdergrid.setValue(proOrderRowKey, 'proOrderDayQty', proOrderDayQty, false);
			proOrdergrid.setValue(proOrderRowKey, 'proPlanQty', proPlanQty, false);
			proOrdergrid.setValue(proOrderRowKey, 'erpCustomerCode', erpCustomerCode, false);
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
				url : '${pageContext.request.contextPath}/planProductSearch',
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
			header : '계획디테일코드',
			name : 'proPlanDetailCode'
		}, {
			header : '제품코드',
			name : 'erpProductCode'
		}, {
			header : '제품명',
			name : 'erpProductName'
		}, {
			header : '주문코드',
			name : 'erpOrderCode'
		}, {
			header : '계획량',
			name : 'proPlanQty',
			hidden : true
		}, {
			header : '납기일자',
			name : 'erpProductDeadline'/* ,
			hidden : true */
		}, {
			header : '주문량',
			name : 'erpOrderQty',
			hidden : true
		}, {
			header : 'UPH',
			name : 'macHourQty',
			hidden : true
		}, {
			header : '일생산량',
			name : 'proOrderDayQty',
			hidden : true
		}, {
			header : '고객코드',
			name : 'erpCustomerCode',
			hidden : true
		} ]
	});
	
	
	

	
}); //end of document ready
</script>