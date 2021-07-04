<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

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
	/* height: 600px;
	max-height: 600px; */
}

.blocker{
	z-index: 1200;
}
</style>

<div class="content-fluid">
	<div>
		<h2>자재발주조회</h2>
	</div>
</div>

<div class="content-fluid">
	<div>
		<div class="my-panel">
			<button type="button" class="btn btn-success" id="search">조회</button>
			<button type="button" class="btn btn-danger" id="reset">새자료</button>
		</div>
	</div>
</div>

<form id="option">
<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-body">
			<div class="row">
				<div class="col-md-4">
						발주일자
						<input type="date" id="erpMaterialOrderDate" name="erpMaterialOrderDate">					
				</div>
				<div class="col-md-4">			
						발주코드
						<input type="text" id="erpMaterialOrderCode" name="erpMaterialOrderCode">	
						<a href="searchMatOrderCode.do" rel="modal:open">						
                     	<i class="fa fa-search"></i></a>
				</div>
				<div class="col-md-4">
						자재코드
						<input type="text" id="comMaterialCode" name="comMaterialCode">
						<a href="searchMaterialCode.do" rel="modal:open">					
						<i class="fa fa-search"></i></a>
				</div>
			</div>
		</div>
	</div>
</div>
</form>

<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-heading">
			<div class="row">
				<div class="col-md-7">
					<p class="panel-subtitle">자재 발주 목록</p>
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

		/* $(document).on("click", "button[id=appendRow]", function() {
			var rowData = [ {
				//여기 수정 해야함.
				발주일자 : "",
				발주번호 : "",
				자재코드 : "",
				자재명 : ""
			} ];
			grid.appendRow(rowData, {
				at : grid.getRowCount(),
				focus : true
			});
			grid.enable();
		}); */
		
		$(document).on("click", "button[id=insertRow]", function() {
			grid.finishEditing('rowKey','columnName');
			grid.request('createData');
		});
		
		$(document).on("click", "button[id=deleteRow]", function() {
			grid.removeCheckedRows(false);
			grid.request('deleteData');
		});
		
		$(document).on("click", "button[id=updateRow]", function() {
			grid.finishEditing('rowKey','columnName');
			grid.request('updateData');
		});
		
		//검색데이터 전송
		$(document).on("click", "button[id=findRow]", function() {
			//데이터를 변수에 담아서 parameter로 만들기.
			var no = $("#no").val();
			console.log(no);
			var readParams = {
					'searchKeyword' : no
				};
			grid.readData(1, readParams, true);
		});
		
		const dataSource = {
			api : {
				readData : {
					url : '${pageContext.request.contextPath}/ajax/matOrder/readMatOrder',
					method : 'GET'
				}
			},
			contentType : "application/json"
		};

		const grid = new tui.Grid({
			el : document.getElementById('grid'),
			rowHeaders : [ 'checkbox' ],
			data : dataSource,
			columns : [ {
				header : '발주일자',
				name : 'erpMaterialOrderDate',
				editor : {
					type : 'datePicker',
					options : {
						format : 'YYYY/MM/dd',
						language: 'ko'
					} 
				}
			},{
				header : '발주코드',
				name : 'erpMaterialOrderCode',
				editor : 'text'
			}, {
				header : '자재코드',
				name : 'comMaterialCode',
				editor : 'text'
			}, {
				header : '자재명',
				name : 'comMaterialName',
				editor : 'text'
			}, {
				header : '입고일자',
				name : 'matInoutDate',
				editor : {
					type : 'datePicker',
					options : {
						format : 'YYYY/MM/dd',
						language: 'ko'
					} 
				}
			}, {
				header : '발주량',
				name : 'erpMaterialOrderQty',
				editor : 'text'
			}, {
				header : '거래처명',
				name : 'erpVendorCode',
				editor : 'text'
			}, {
				header : '자재LOT_NO',
				name : 'matLotNo',
				editor : 'text'
			}, {
				header : '입고량',
				name : 'matInoutQuantity',
				editor : 'text'
			}
			]
		});
	
/* 	grid.on('response', ev => {
		  const {response} = ev.xhr;
		  const responseObj = JSON.parse(response);

		  console.log('result : ', responseObj.result);
		  console.log('data : ', responseObj.data);
		});
	
	grid.on('check', (ev) => {
		  alert(`check: ${ev.rowKey}`);
	}); */
	
}); //end of document ready
</script>
				<!--<form id="detailForm" name="detailForm" method="post" action="">
					<div>
						<table class="dataTable" border="1" align="center">
							<thead>
								<tr>
									<th>발주일자</th>
									<th>발주번호</th>
									<th>자재코드</th>
									<th>자재명</th>
									<th>입고일자</th>
									<th>발주량</th>
									<th>거래처명</th>
									<th>자재LOT_NO</th>
									<th>입고량</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${selectOrderList}" var="order">
									<tr>
										<td>${order.orderVO.erpMaterialOrderDate }</td>
										<td>${order.orderVO.erpMaterialOrderCode }</td>
										<td>${order.matrVO.comMaterialCode }</td>
										<td>${order.matrVO.comMaterialName }</td>
										<td>${order.matInoutVO.matInoutDate }</td>
										<td>${order.orderVO.erpMaterialOrderQty }</td>
										<td>${order.orderVO.erpVendorCode }</td>
										<td>${order.matInoutVO.matLotNo }</td>
										<td>${order.matInoutVO.matInoutQuantity }</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</form>-->