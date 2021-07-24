<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css">

<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>

<!-- 타이틀 -->
<div class="content-fluid">
	<div>
		<h2>생산 지시 조회</h2>
	</div>
</div>

<!-- 관리, 조회 탭 이동 -->
<div id="tabs">
   <ul class="nav nav-tabs" role="tablist">
     <li class=""><a onclick='location.href="prodForm.do"' aria-controls="tab1" role="tab" data-toggle="tab">관리</a></li>
     <li class="active"><a onclick='location.href="prodView.do"' aria-controls="tab2" role="tab" data-toggle="tab">조회</a></li>
   </ul>
</div>


<!-- 마스터 테이블 -->
<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-body">
			<div class="row">
				<form action="">
					<div class="col-md-8">
					* 일자   &nbsp;&nbsp;&nbsp;<input type="date" id="startDate" name="startDate" class="form-control"> 
						~ <input type="date" id="endDate" name="endDate" class="form-control"> 
						<input type="radio" id="gubun1" name="gubun" value="1" checked> 작업일자
						<input type="radio" id="gubun2" name="gubun" value="2" > 납기일자 <br/><br/>
					* 제품 검색
					<input type="hidden" id="erpProductCode" name="erpProductCode" class="form-control" readonly>
					<input type="text" id="erpProductName" name="erpProductName" class="form-control" readonly> &nbsp;&nbsp;
					* 고객 검색 
					<input type="hidden" id="erpCustomerCode" name="erpCustomerCode" class="form-control" readonly>
					<input type="text" id="erpCustomerName" name="erpCustomerName" class="form-control" readonly> <br/><br/>
						
						<!-- 제품 모달창 -->
						<a id="showModal1" href="${pageContext.request.contextPath}/pro/plan/ProdCode.do" rel="modal:open"></a>
						<!-- 고객 모달창 -->
						<a id="showModal2" href="${pageContext.request.contextPath}/pro/plan/CustomerCode.do" rel="modal:open"></a>
						
					</div>
					<div class="col-md-4" align="right">
						<button type="button" class="btn btn-primary" id="findRow">조회</button>
						<button type="reset" class="btn btn-success" id="reset">새자료</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>


<!-- 디테일 테이블 -->
<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-heading">
			<div class="row">
				<div class="col-md-7">
					<p class="panel-subtitle">생산지시조회</p>
				</div>
			</div>
			<div class="panel-body">
				<div id="grid"></div>
			</div>
		</div>
	</div>
</div>
<script>

	$(document).ready(function() {
		
		//네비게이션 고정
	      $('#n7000000').addClass('active');
	      $('#subPages7000000').addClass('in');
	      $('#subPages7000000').attr('aria-expanded','true');
	      $('#subPages7000000').attr('style','');
	      $('.7020000').addClass('active');
		
		//M 조회 버튼	
		$(document).on("click", "button[id=findRow]",
		      function() {
		 	   var gubun = $("input[name=gubun]:checked").val();
		 	   console.log(gubun);
		         var startDate = $("#startDate").val();
		         var endDate = $("#endDate").val();
		         var erpProductCode = $("#erpProductCode").val();
		         var erpCustomerCode = $("#erpCustomerCode").val();
		         var readParams = {
		      	  'searchCondition' : gubun,
		            'startDate' : startDate,
		            'endDate' : endDate,
		            'erpProductCode' : erpProductCode,
		            'erpCustomerCode' : erpCustomerCode
		         };
		         grid.readData(1, readParams, true);
		      });
		
		// M 리셋버튼  
		$("#reset").click(function() {  
			$("form").each(function() {  
		    	if(this.id == "option") this.reset();
		    	grid.clear();

		    	$('#startDate').val("");
		    	$('#endDate').val("");
		    	$('#erpProductCode').val("");
		    	$('#erpCustomerCode').val("");
		    	});
			}); 

		
		//dataSource	
		const dataSource = {
			api : {
				readData : {
					url : '${pageContext.request.contextPath}/pro/order/prodView',
					method : 'GET'
				}
			},
			initialRequest : false,
			contentType : "application/json"
		};

		const grid = new tui.Grid({
			el : document.getElementById('grid'),
			rowHeaders : [ 'checkbox' ],
			data : dataSource,
			scrollX: true,
	        scrollY: true,
	        bodyHeight :300, 
	        rowHeight: 30,
			columns : [ {
				header : '작업일자',
				name : 'proWorkDate',
				align: 'center'
			}, {
				header : '생산지시코드',
				name : 'proOrderDetailCode',
				align: 'center'
			}, {
				header : '고객사명',
				name : 'comCodeDetailName',
				align: 'center'
			}, {
				header : '제품코드',
				name : 'erpProductCode',
				align: 'center'
			}, {
				header : '제품명',
				name : 'erpProductName',
				align: 'center'
			}, {
				header : '주문번호',
				name : 'erpOrderCode',
				align: 'center'
			}, {
				header : '납기일자',
				name : 'erpProductDeadline',
				align: 'center'
			}, {
				header : '주문량',
				name : 'erpOrderQty',
				align: 'right',
	            formatter: (ev)=>{return (ev.value == null) ? null : String(ev.value).replace(/\B(?=(\d{3})+(?!\d))/g, ","); }
			},  {
				header : '지시량',
				name : 'proOrderQty',
				align: 'right',
	            formatter: (ev)=>{return (ev.value == null) ? null : String(ev.value).replace(/\B(?=(\d{3})+(?!\d))/g, ","); }
			}, {
				header : '작업구분',
				name : 'proOrderGubun',
				align: 'center'
			}, {
				header : '제품LOT_NO',
				name : 'proProcessLotNo',
				align: 'center'
			}, {
				header : '작업순서',
				name : 'proOrderSeq',
				align: 'center'
			}, {
				header : '지시일자',
				name : 'proOrderDate',
				align: 'center'
			}, {
				header : '생산진행여부',
				name : 'proProcessStatus',
				align: 'center'
			} ]
		});

	// M 제품 인풋 한 번 클릭 시 이벤트
	$("#erpProductName").on("click", ev => {
			$("#showModal1").click();
	});
	
	// M 고객 인풋 한 번 클릭 시 이벤트
	$("#erpCustomerName").on("click", ev => {			
			$("#showModal2").click();
	});
	
	
	
	grid.on('response', ev => {
		  const {response} = ev.xhr;
		  const responseObj = JSON.parse(response);

		  console.log('result : ', responseObj.result);
		  console.log('data : ', responseObj.data);
		});
	
	grid.on('check', (ev) => {
		  alert(`check: ${ev.rowKey}`);
	});
	
	
}); //end of document ready
</script>



