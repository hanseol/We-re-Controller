<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css">

<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>

<style>
.my-panel {
	text-align: right;
	border-top: 1px solid gray;
	padding: 10px;
	margin-bottom: 10px;
	background-color: white;
}

.modal{
	-webkit-border-radius :0px;
	border-radius:0px;
	overflow: visible;
	text-align: center;
	max-width: 900px;
	width: 900px;
	/*height: 600px;
	max-height: 600px;*/
}

.blocker{
	z-index: 1200;
}
</style>

<!-- 타이틀 -->
<div class="content-fluid">
	<div>
		<h2>생산 계획 관리</h2>
	</div>
</div>




<!-- 관리, 조회 탭 이동 -->
<div id="tabs">
   <ul class="nav nav-tabs" role="tablist">
     <li class="active"><a onclick='location.href="prodPlanForm.do"' aria-controls="tab1" role="tab" data-toggle="tab">관리</a></li>
     <li class=""><a onclick='location.href="ProdPlanView.do"' aria-controls="tab2" role="tab" data-toggle="tab">조회</a></li>
   </ul>
</div>



<!-- 마스터테이블의 CRUD 버튼 -->
<div class="content-fluid">
	<div>
		<div class="my-panel">
	
			<button type="button" class="btn btn-success" id="findRow">조회</button>
			<button type="button" class="btn btn-danger" id="reset">새자료</button>
			<button type="button" class="btn btn-warning" id="modifyRow">저장</button>
			<!-- <button type="button" class="btn btn-info" id="updateRow">수정저장</button> -->
			
		</div>
	</div>
</div>


<!-- 마스터 테이블 -->
<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-body">
			<div class="row">
				<div class="col-md-6">
					<form>
						* 계획일자   &nbsp;&nbsp;&nbsp;<input type="date" id="date" name="date" > <br/><br/>
							
						* 생산계획명  &nbsp;&nbsp;&nbsp; <input type="text" id="proPlanName" name="proPlanName">  &nbsp;&nbsp;
						<a href="${pageContext.request.contextPath}/proPlanName.do" rel="modal:open">						
                     		<i class="fa fa-search"></i>
                  		</a>
						<!-- 모달창 -->
						<a id="showModal" href="${pageContext.request.contextPath}/erpProductSearch.do" rel="modal:open"></a> 
					</form>
				</div>
				
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
					<p class="panel-subtitle">생산계획관리</p>
				</div>
				<div class="col-md-5" align="right">
					<!-- <button type="button">조회</button> -->
					<button type="button" id="appendRow">추가</button>
					<button type="button" id="deleteRow">삭제</button>
				</div>
			</div>
			<div class="panel-body">
				<div id="grid"></div>
			</div>
		</div>
	</div>
</div>


<script>
	var proPlanGrid;
	$(document).ready(function() {
		
 		
		/*//M 새자료버튼 
		$(document).ready(function() {  
		       $("#reset").click(function() {  
		            $("form").each(function() {  
		                   if(this.id == "option") this.reset();  
		                });  
		       });  
		    });  */ 
		
		
		//M 조회 버튼
		$(document).on("click", "button[id=findRow]", function() {
	               var erpProductCode = $("#erpProductCode").val();
	               var erpCustomerCode = $("#erpCustomerCode").val();
	               var readParams = {
	                  'erpProductCode' : erpProductCode,
	                  'erpCustomerCode' : erpCustomerCode
	               };
	               proPlanGrid.readData(1, readParams, true);
	            });
		 
		//M 저장 버튼
		$(document).on("click", "button[id=modifyRow]", function () {
			var date = $("#date").val();
            var proPlanName = $("#proPlanName").val();
			proPlanGrid.finishEditing('rowKey', 'columnName');
			var requestParams = {
	                  'proPlanDate' : date,
	                  'proPlanName' : proPlanName
	               };
			proPlanGrid.setRequestParams(requestParams);
			proPlanGrid.request('modifyData');
		});
		    
		    
		/* //M 추가저장 버튼
		$(document).on("click", "button[id=insertRow]", function() {
			proPlanGrid.finishEditing('rowKey','columnName');
			proPlanGrid.request('createData');
		});
		
		//M 수정저장 버튼 
		$(document).on("click", "button[id=updateRow]", function() {
			proPlanGrid.finishEditing('rowKey','columnName');
			proPlanGrid.request('updateData');
		}); */
		

		
		
		//D 삭제 버튼 
		$(document).on("click", "button[id=deleteRow]", function() {
			proPlanGrid.removeCheckedRows(true);
			proPlanGrid.request('deleteData');
		});
		
		//D 추가 버튼
		$(document).on("click", "button[id=appendRow]", function() {
			var rowData = [ {
				erpCustomerCode : "",
				erpProductCode : "",
				erpProductName : "",
				erpOrderCode : "",
				erpProductDeadline : "",
				erpOrderQty : "" ,
				proPlanQty : "" ,
				proWorkDate : "" ,
				proPlanSeq : "" 
			} ];
			proPlanGrid.appendRow(rowData, {
				at : 0,
				focus : true
			});
			proPlanGrid.enable();
		});
		
		
		//dataSource		
		const dataSource = {
			api : {
				readData : {
					url : '${pageContext.request.contextPath}/proPlan/ProdPlanView',
					method : 'GET'
				},  
				modifyData: { url: '${pageContext.request.contextPath}/proPlan/modifyProdPlan', method: 'PUT' }
			},
			initialRequest : false,
			contentType : "application/json"
		};
		
		

		proPlanGrid = new tui.Grid({
			el : document.getElementById('grid'),
			rowHeaders : [ 'checkbox' ],
			data : dataSource,
			columns : [ {
				header : '제품코드',
				name : 'erpProductCode',
				validation: {
		               required:true
		            }
			}, {
				header : '제품명',
				name : 'erpProductName'
			}, {
				header : '주문코드',
				name : 'erpOrderCode'
			}, {
				header : '납기일자',
				name : 'erpProductDeadline'
			}, {
				header : '주문량',
				name : 'erpOrderQty'
			}, {
				header : '작업계획량',
				name : 'proPlanQty',
				editor : 'text'
			}, {
				header : '작업착수일',
				name : 'proWorkDate',
				editor : {
					type : 'datePicker',
					options : {
						format : 'YYYY/MM/dd',
						language: 'ko'
					} 
				}
			}, {
				header : '작업순서',
				name : 'proPlanSeq',
				editor : 'text'
			}, {
				header : '고객사코드',
				name : 'erpCustomerCode'
			}, {
				header : '예상소요량',
				name : 'proPlanExpectQty',
				hidden : true
			}, {
				header : '예상일',
				name : 'proPlanDayQty',
				hidden : true
			} ]
		});
		
	//디테일의 제품코드cell 더블클릭으로 모달창 띄우기	
	proPlanGrid.on('dblclick', ev => {
		if(ev.columnName == 'erpProductCode'){
			$('#showModal').click();
		}
	});

	/* 	
	proPlanGrid.on('response', ev => {
		  const {response} = ev.xhr;
		  const responseObj = JSON.parse(response);

		  console.log('result : ', responseObj.result);
		  console.log('data : ', responseObj.data);
		});
	 */
	 
	 //체크박스 클릭시 alert 띄우기
	/* proPlanGrid.on('check', (ev) => {
		  alert(`check: ${ev.rowKey}`);
	}); */
	
}); //end of document ready
</script>






