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
						* 작업일자 <input type="date" id="proWorkDate" name="proWorkDate"><br><br>
						* 작업지시코드 <input type="text" id="proOrderCode" name="proOrderCode">
						<!-- 지시검색모달 -->
						<a href="${pageContext.request.contextPath}/proOrderSearch.do" rel="modal:open">						
                    		<i class="fa fa-search"></i>
                 		</a>
						
						<!-- 모달창 -->
						<a id="showModal" href="${pageContext.request.contextPath}/erpProductSearch.do" rel="modal:open"></a>
					
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
				<div class="col-md-7">
					<p class="panel-subtitle">자재정보</p>
					<div class="panel-body">
						<div id="matInfogrid"></div>
					</div>
				</div>
				<div class="col-md-5">
					<p class="panel-subtitle">로트정보</p>	
					<div class="panel-body">
						<div id="matLotgrid"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
	$(document).ready(function() {

		
		// M 조회버튼
		$("#findRow").on("click", function() {
			var proWorkDate = $("#proWorkDate").val();
			var proOrderCode = $("#proOrderCode").val();
			
			var readParams = {
					'proWorkDate' : proWorkDate,
					'proOrderCode' : proOrderCode
			};
			grid.readData(1, readParams, true);
		});
		
		/* //M 삭제버튼
		$(document).on("click", "button[id=deleteOrder]", function() {
			
		});
		
		//D 삭제버튼
		$(document).on("click", "button[id=deleteRow]", function() {
			
		}); 
 */
		//D 행추가버튼
		$(document).on("click", "button[id=appendRow]", function() {
			var rowData = [ {
				comProductCode : "",
				comProductName : "",
				proOrderCode : "",
				erpProductDeadline : "",
				erpOrderQty : "" ,
				proOrderQty : "" ,
				macHourQty : "" ,
				dayQty : "" ,
				dayCount : "" ,
				proWorkDate : "" ,
				proOrderSeq : ""
			} ];
			grid.appendRow(rowData, { at : grid.getRowCount(), focus : true });
			grid.enable();
		});
		
		// D 저장 버튼
		$(document).on("click", "button[id=modifyRow]", function() {
			grid.finishEditing('rowKey', 'columnName');
			grid.request('modifyData');
		});
		
	
		//dataSource	
		const dataSource = {
			api : {
				readData : { url : '${pageContext.request.contextPath}/ajax/proOrder/prodFormList', method : 'GET' },
				modifyData : { url: '${pageContext.request.contextPath}/ajax/proOrder/prodView', method : 'PUT' }
			},
			initialRequest : false,
			contentType : "application/json"
		};

		const grid = new tui.Grid({
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
				name : 'dayQty'
			}, {
				header : '일수',
				name : 'dayCount',
				editor : 'text'
			}, {
				header : '작업일자',
				name : 'proWorkDate',
				editor : 'text'
			} , {
				header : '작업순서',
				name : 'proOrderSeq',
				editor : 'text'
			} ]
		});
	
	
	//디테일의 제품코드cell 더블클릭으로 모달창 띄우기	
	grid.on('dblclick', ev => {
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
	
	
}); //end of document ready
</script>



