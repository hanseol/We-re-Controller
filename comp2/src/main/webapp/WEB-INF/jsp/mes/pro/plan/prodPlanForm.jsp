<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

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


<!-- 마스터 테이블 -->
<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-body">
			<div class="row">
				<form>
					<div class="col-md-4">
						<input type="hidden" id="proPlanCode" name="proPlanCode">
						* 계획일자   &nbsp;&nbsp;&nbsp;<input type="date" id="date" name="date" class="form-control"> <br/><br/>
					</div>
					<div class="col-md-4">
						* 생산계획이름  &nbsp;&nbsp;&nbsp; <input type="text" id="proPlanName" name="proPlanName" class="form-control">
					<a href="${pageContext.request.contextPath}/pro/plan/proPlanName.do" rel="modal:open">						
                   		<i id="searchImg" class="fa fa-search"></i>
           			</a>
						
                 	</div>
					<!-- 모달창 -->
					<a id="showModal" href="${pageContext.request.contextPath}/pro/plan/erpProductSearch.do" rel="modal:open"></a>
					
				</form>
					<div class="col-md-4" align="right">
						<button type="button" class="btn btn-primary" id="findRow">조회</button>
						<button type="reset" class="btn btn-success" id="reset">새자료</button>
						<button type="button" class="btn btn-fail" id="deletePlan">계획삭제</button>
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
					<!-- <button type="button" id="deleteRow">삭제</button> -->
					<button type="button" id="modifyRow">저장</button>
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
	var proPlanRowKey;
	
	$(document).ready(function() {

		//date 태그 디폴드 값 설정 (오늘 날짜)
		$("#date").val(new Date().toISOString().substring(0,10)); 
		
		//네비게이션 고정
		$('#n7000000').addClass('active');
		$('#subPages7000000').addClass('in');
		$('#subPages7000000').attr('aria-expanded','true');
		$('#subPages7000000').attr('style','');
		$('.7010000').addClass('active');
		
		//M 조회 버튼
		$("#findRow").on("click", function() {
	               var date = $("#date").val();
	               var proPlanCode = $("#proPlanCode").val();
	               
	               var readParams = {
	                  'proPlanDate' : date,
	                  'proPlanCode' : proPlanCode
	               };
	               proPlanGrid.readData(1, readParams, true);
	            });
		 
		//D 저장 버튼
		$("#modifyRow").on("click", function () {
			var date = $("#date").val();
            var proPlanName = $("#proPlanName").val();
            
			proPlanGrid.finishEditing('rowKey', 'columnName');
			
			var requestParams = {
	                  'proPlanDate' : date,
	                  'proPlanName' : proPlanName,
	               };
			proPlanGrid.setRequestParams(requestParams);
			/* 
				//저장 시 알림 메시지 안뜨게 하는거.
				var test = {
				showConfirm : false
			} */
			proPlanGrid.request('modifyData');
		});
		 
		
		//M 삭제버튼 (계획을 삭제)
		$("#deletePlan").on("click", function() {
			proPlanGrid.checkAll(true);
		
			proPlanGrid.request('modifyData');
			$("#reset").click();
		})
		    
		//D 삭제 버튼 : 행만 삭제, 저장버튼 눌러야함.
		$("#deleteRow").on("click", function() {
			proPlanGrid.removeCheckedRows(false);
		});
		
		//D 추가 버튼
		$("#appendRow").on("click", function() {
			    var rowData = {
				erpCustomerCode : "",
				erpProductCode : "",
				erpProductName : "",
				erpOrderCode : "",
				erpProductDeadline : "",
				erpOrderQty : "" ,
				proPlanQty : "" ,
				proWorkDate : "" ,
				proPlanSeq : "" ,
				proPlanCode : $('#proPlanCode').val()
			} ;
			proPlanGrid.appendRow(rowData, { at : 0, focus : true });
			proPlanGrid.enable();
			/* $('#showModal').click(); */ 
		});
		
		
		
		// M 리셋버튼  
		$("#reset").click(function() {  
			$("form").each(function() {  
		    	if(this.id == "option") this.reset();
		    	proPlanGrid.clear();
		    	
		    	$('#proPlanName').val("");
		    	
		    	});
			}); 

		
		
		
		//dataSource		
		const dataSource = {
			api : {
				readData : { url : '${pageContext.request.contextPath}/pro/plan/ProdPlanFormList', method : 'GET' },  
				modifyData : { url: '${pageContext.request.contextPath}/pro/plan/modifyProdPlan', method: 'PUT' }
			},
			initialRequest : false,
			contentType : "application/json"
		};
		
		

		proPlanGrid = new tui.Grid({
			el : document.getElementById('grid'),
			rowHeaders : [ 'checkbox' ],
			data : dataSource,
			scrollX: true,
	        scrollY: true,
	        bodyHeight :300, 
	        rowHeight: 30,
			columns : [ {
				header : '제품코드',
				name : 'erpProductCode',
				align: 'center',
				validation: {
		               required:true
		            }
			}, {
				header : '제품명',
				name : 'erpProductName',
				align: 'center'
			}, {
				header : '주문코드',
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
			}, {
				header : '작업계획량',
				name : 'proPlanQty',
				align: 'right',
				formatter: (ev)=>{return (ev.value == null) ? null : String(ev.value).replace(/\B(?=(\d{3})+(?!\d))/g, ","); },
				editor : 'text'
			}, {
				header : '작업착수일',
				name : 'proWorkDate',
				align: 'center',
				editor : {
					type : 'datePicker',
					options : {
						format : 'YYYY-MM-dd',
						language: 'ko',
						selectableRanges : [[new Date(), new Date(2099, 1, 1)]]
					} 
				}
			},/*  {
				header : '작업순서',
				name : 'proPlanSeq',
				align: 'center',
				editor : 'text'
			},  */{
				header : '고객사코드',
				name : 'erpCustomerCode',
				align: 'center',
				hidden : true
			}, {
				header : '예상소요량',
				name : 'proPlanExpectQty',
				hidden : true
			}, {
				header : '예상일',
				name : 'proPlanDayQty',
				hidden : true
			}, {
				header : '디테일코드',
				name : 'proPlanDetailCode',
				hidden : true
			}, {
				header : '생산계획코드',
				name : 'proPlanCode',
				hidden : true
			} ],
			summary : {
	            height : 40,
	            position : 'bottom',
	            columnContent : {
	            	proPlanQty : {
	                  template(val) {
	                     return '계획 합 : ' + val.sum;
	                  }
	               }
	            }
	         }
		});
		
	//디테일의 제품코드cell 더블클릭으로 모달창 띄우기	
	proPlanGrid.on('dblclick', ev => {
		if(ev.columnName == 'erpProductCode'){
			proPlanRowKey = ev.rowKey;
			
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






