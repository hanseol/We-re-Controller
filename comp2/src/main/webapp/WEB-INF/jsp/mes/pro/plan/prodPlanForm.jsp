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
					<div class="col-md-6">
						<input type="hidden" id="proPlanCode" name="proPlanCode">
						* 계획일자   &nbsp;&nbsp;&nbsp;<input type="date" id="date" name="date" > <br/><br/>
						* 생산계획이름  &nbsp;&nbsp;&nbsp; <input type="text" id="proPlanName" name="proPlanName">
						<a href="${pageContext.request.contextPath}/proPlanName.do" rel="modal:open">						
                    		<i class="fa fa-search"></i>
                 		</a>
						<!-- 모달창 -->
						<a id="showModal" href="${pageContext.request.contextPath}/erpProductSearch.do" rel="modal:open"></a>
					</div>
					<div class="col-md-6" align="right">
						<button type="button" class="btn btn-success" id="findRow">조회</button>
						<button type="reset" class="btn btn-danger" id="reset">새자료</button>
						<button type="button" class="btn btn-fail" id="deletePlan">계획삭제</button>
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
					<p class="panel-subtitle">생산계획관리</p>
				</div>
				<div class="col-md-5" align="right">
					<!-- <button type="button">조회</button> -->
					<button type="button" id="appendRow">추가</button>
					<button type="button" id="deleteRow">삭제</button>
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

		//네비게이션 고정
		$('#proNav').addClass('active');
		$('#subPages4').addClass('in');
		$('#subPages4').attr('aria-expanded','true');
		$('#subPages4').attr('style','');
		$('.proProdPlan').addClass('active');
		
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
			 
			proPlanGrid.request('modifyData');
		});
		 
		
		//M 삭제버튼 (계획을 삭제)
		$("#deletePlan").on("click", function() {
			proPlanGrid.checkAll(true);
			proPlanGrid.removeCheckedRows(true);
			proPlanGrid.request('modifyData');
		})
		    
		//D 삭제 버튼 
		$("#deleteRow").on("click", function() {
			proPlanGrid.removeCheckedRows(true);
			proPlanGrid.request('modifyData');
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
		});
		
		
		
		// M 리셋버튼  
		$("#reset").click(function() {  
			$("form").each(function() {  
		    	if(this.id == "option") this.reset();
		    	proPlanGrid.clear();
		    	
		    	$('#date').val("");
		    	$('#proPlanName').val("");
		    	
		    	});
			}); 

		
		
		
		//dataSource		
		const dataSource = {
			api : {
				readData : { url : '${pageContext.request.contextPath}/proPlan/ProdPlanFormList', method : 'GET' },  
				modifyData : { url: '${pageContext.request.contextPath}/proPlan/modifyProdPlan', method: 'PUT' }
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
			}, {
				header : '디테일코드',
				name : 'proPlanDetailCode',
				hidden : true
			}, {
				header : '생산계획코드',
				name : 'proPlanCode'
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

	// 그리드 테마
	tui.Grid.applyTheme('clean', 
		{
			row: {
	       		hover: {
	       			background: "#d5dae1"
	       		}
			},
			cell: {
				header: {
					background: "#003458",
					text: "white"
				},
				currentRow : {
					background: "#d5dae1"
				}
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






