<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 타이틀 -->
<div class="content-fluid">
	<div>
		<h2>생산 지시 관리</h2>
	</div>
</div>


<!-- 관리, 조회 탭 이동 -->
<div id="tabs">
   <ul class="nav nav-tabs" role="tablist">
     <li class="active"><a onclick='location.href="prodForm.do"' aria-controls="tab1" role="tab" data-toggle="tab">관리</a></li>
     <li class=""><a onclick='location.href="prodView.do"' aria-controls="tab2" role="tab" data-toggle="tab">조회</a></li>
   </ul>
</div>


<!-- 마스터 테이블 -->
<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-body">
			<div class="row">
				<form>
					<div class="col-md-6">
						* 지시일자 <input type="date" id="proOrderDate" name="proOrderDate"> <br/><br/>
						* 작업지시코드 <input type="text" id="proOrderCode" name="proOrderCode" readonly>
						<!-- 지시검색모달 -->
						<a href="${pageContext.request.contextPath}/proOrderSearch.do" rel="modal:open">						
                    		<i class="fa fa-search"></i>
                 		</a>
						
						<!-- 모달창 -->
						<a id="showModal" href="${pageContext.request.contextPath}/planProductSearch.do" rel="modal:open"></a>
					
					</div>
					<div class="col-md-6" align="right">	
						<button type="button" class="btn btn-success" id="findRow">조회</button>
						<button type="reset" class="btn btn-danger" id="reset">새자료</button>
						<button type="button" class="btn btn-fail" id="deleteOrder">지시삭제</button>
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
					<p class="panel-subtitle">생산지시관리</p>
				</div>
				<div class="col-md-5" align="right">
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


<!-- 디테일-디테일테이블 -->
<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-heading">
			<div class="row">
				<div class="col-md-6">
					<p class="panel-subtitle">자재정보</p>
					<div>
						제품코드 <input type="text" id="comProductCode" name="comProductCode" readonly>
						제품명   <input type="text" id="comProductName" name="comProductName" readonly>
						<!-- 지시량  <input type="text" id="proOrderSeq" name="proOrderSeq" readonly> -->
					</div>
					<div class="panel-body">
						<div id="matInfogrid"></div>
					</div>
				</div>
				<div class="col-md-6">
					<p class="panel-subtitle">로트정보</p>	
					<div>
						자재코드 <input type="text" id="comMaterialCode" name="comMaterialCode" readonly>
						자재명   <input type="text" id="comMaterialName" name="comMaterialName" readonly>
						
						<button type="button" id="modifyLot">저장</button>
					</div>
					<div class="panel-body">
						<div id="matLotgrid"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
var proOrdergrid;
var proOrderRowKey;

	$(document).ready(function() {
		// M 조회버튼
		$("#findRow").on("click", function() {
			var proOrderDate = $("#proOrderDate").val();
			var proOrderCode = $("#proOrderCode").val();
			
			var readParams = {
					'proOrderDate' : proOrderDate,
					'proOrderCode' : proOrderCode
			};
			proOrdergrid.readData(1, readParams, true);
		});
		
		/* //M 삭제버튼
		$(document).on("click", "button[id=deleteOrder]", function() {
			
		});
		
		//D 삭제버튼
		$(document).on("click", "button[id=deleteRow]", function() {
			
		});  */

		//D 행추가버튼
		$("#appendRow").on("click", function() {
			var rowData = [ {
				erpProductCode : "",
				erpProductName : "",
				proOrderGubun : "",
				erpOrderCode : "",
				erpProductDeadline : "" ,
				erpOrderQty : "" ,
				proOrderQty : "" ,
				macHourQty : "" ,
				proOrderDayQty : "" ,
				proOrderExpectQty : "" ,
				proWorkDate : "",
				proOrderSeq : "",
				proPlanDetailCode : ""
			} ];
			proOrdergrid.appendRow(rowData, { at : proOrdergrid.getRowCount(), focus : true });
			proOrdergrid.enable();
		});
		
		// D 저장 버튼
		$("#modifyRow").on("click", function() {
			proOrdergrid.finishEditing('rowKey', 'columnName');
			grid.request('modifyData');
		});
		
		// M 리셋버튼  
		$("#reset").click(function() {  
			$("form").each(function() {  
		    	if(this.id == "option") this.reset();
		    	proOrdergrid.clear();
		    	matInfogrid.clear();
		    	matLotgrid.clear();
		    	
		    	$('#comProductCode').val("");
		    	$('#comProductName').val("");
		    	
		    	$('#comMaterialCode').val("");
		    	$('#comMaterialName').val("");
		    	});
			}); 
		
		
		//D-D 저장버튼 **수정예정
		/* $('#modifyLot').on("click", function() {
			
		
			}); */
		
		
		

		
//======================================== 1번 그리드 ======================================== 
		//dataSource	
		const dataSource = {
			api : {
				readData : { url : '${pageContext.request.contextPath}/ajax/proOrder/prodFormList', method : 'GET' },
				modifyData : { url: '${pageContext.request.contextPath}/ajax/proOrder/prodView', method : 'PUT' }
				
			},
			initialRequest : false,
			contentType : "application/json"
		};

		//그리드
		proOrdergrid = new tui.Grid({
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
				header : '구분',
				name : 'proOrderGubun',
				editor: {
		            type: 'select',
		            options: {
		              listItems: [
		                { text: '정상', value: '정상' },
		                { text: '재작업', value: '재작업' }
		              ]
		            }
		          }
			
			}, {
				header : '주문번호',
				name : 'erpOrderCode'
			}, {
				header : '납기일자',
				name : 'erpProductDeadline'
			}, {
				header : '계획량',
				name : 'proPlanQty'
			},{
				header : '주문량',
				name : 'erpOrderQty'
			}, {
				header : '지시량',
				name : 'proOrderQty',
				editor : 'text'
			}, {
				header : 'UPH',
				name : 'macHourQty'
			}, {
				header : '일생산량',
				name : 'proOrderDayQty'
			}, {
				header : '예상작업일수',
				name : 'proOrderExpectQty',
				editor : 'text'
			}, {
				header : '작업일자',
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
				name : 'proOrderSeq',
				editor : 'text'
			}, {
				header : '생산계획디테일코드',
				name : 'proPlanDetailCode',
				hidden : true
			}, {
				header : '고객코드',
				name : 'erpCustomerCode',
				hidden : true 
			} ],
			/* summary : {
	            height : 40,
	            position : 'bottom',
	            columnContent : {
	            	proOrderQty : {
	                  template(val) {
	                     return '합 : ' + val.sum;
	                  }
	             }, proOrderExpectQty : {
	                  template(val) {
	                     return '합 : ' + val.sum;
	                  }
	             }
	        } */
	            
		}); //end of grid(1번)
		

		// 예상소요일 구하기
		proOrdergrid.on('afterChange',ev => {
			var proOrderQty = proOrdergrid.getValue( ev.changes[0].rowKey, 'proOrderQty')
			var proOrderDayQty = proOrdergrid.getValue( ev.changes[0].rowKey, 'proOrderDayQty');
			proOrdergrid.setValue(ev.changes[0].rowKey, 'proOrderExpectQty', (proOrderQty/proOrderDayQty).toFixed(1));
		});
	
	
	
//======================================== 2번 그리드 ======================================== 		
		//dataSource	
		const matDataSource = {
			api : {
				readData : { url : '${pageContext.request.contextPath}/matBomList', method : 'GET' }
			},
			initialRequest : false,
			contentType : "application/json"
		};	
			
		// 디테일-디테일 그리드 (2번 그리드: 자재정보 그리드)
		const matInfogrid = new tui.Grid({
			el : document.getElementById('matInfogrid'),
			rowHeaders : [ 'checkbox' ],
			data : matDataSource,
			scrollX : false,
			scrollY : true,
			columns : [  {
				header : '자재코드',
				name : 'comMaterialCode'
			}, {
				header : '자재이름',
				name : 'comMaterialName'
			}, {
				header : '공정코드',
				name : 'comProcessCode'
			} ]
		}); //end of grid(2번)
	
//======================================== 3번 그리드 ======================================== 		
		//dataSource	
		const lotDataSource = {
			api : {
				readData : { url : '${pageContext.request.contextPath}/matLotList', method : 'GET' }
			},
			initialRequest : false,
			contentType : "application/json"
		};	
		// 디테일-디테일 그리드 (3번 그리드: 자재로트정보 그리드)
		const matLotgrid = new tui.Grid({
			el : document.getElementById('matLotgrid'),
			rowHeaders : [ 'checkbox' ],
			data : lotDataSource,
			scrollX : false,
			scrollY : true,
			columns : [  {
				header : '로트번호',
				name : 'matLotNo'
			}, {
				header : '입고일자',
				name : 'matInoutDate'
			}, {
				header : '수량',
				name : 'matInoutQuantity' 
			}, {
				header : '사용수량', 
				name : '',
				editor : 'text'
			}, {
				header : '구분',
				name : 'matInoutGubun',
				hidden : true 
			}, {
				header : '단가',
				name : 'matInoutUnitPrice',
				hidden : true 
			}, {
				header : '가격',
				name : 'matInoutPrice',
				hidden : true 
			} ]
		
	}); //end of grid(3번)
		
		
//======================================== 그리드 클릭 이벤트 ======================================== 		
	//디테일의 제품코드cell 더블클릭으로 모달창 띄우기	
	proOrdergrid.on('dblclick', ev => {
		if(ev.columnName == 'erpProductCode'){
			proOrderRowKey = ev.rowKey;
			
			$('#showModal').click();
		}
	});
	
	//디테일의 제품코드cell 한번클릭으로 2번그리드에 값 뿌리기	
	proOrdergrid.on('click', ev => {
		if(ev.columnName == 'erpProductCode'){
			var comProductCode = proOrdergrid.getFocusedCell().value;
			var comProductName = proOrdergrid.getValue(ev.rowKey, 'erpProductName');
			
			var readParams = {
					'comProductCode' : comProductCode
			} 
			matInfogrid.readData(1, readParams, true);
			$("#comProductCode").val(comProductCode);
			$("#comProductName").val(comProductName);
		}
	});
	
	// 그리드2의 자재코드cell 한번클릭으로 3번그리드에 값 뿌리기	
	matInfogrid.on('click', ev => {
		if(ev.columnName == 'comMaterialCode'){
			var comMaterialCode = matInfogrid.getFocusedCell().value;
			var comMaterialName = matInfogrid.getValue(ev.rowKey, 'comMaterialName');

			var readParams = {
					'comMaterialCode' : comMaterialCode
			} 
			matLotgrid.readData(1, readParams, true);
			$("#comMaterialCode").val(comMaterialCode);
			$("#comMaterialName").val(comMaterialName);
		}
	});
	
	
	
	// 그리드 테마 	
/* 	tui.proOrdergrid.applyTheme('clean', 
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
	 */
	
}); //end of document ready
</script>



