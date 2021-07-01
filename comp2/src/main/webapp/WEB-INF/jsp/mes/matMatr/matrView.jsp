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
</style>

<div class="content-fluid">
	<div>
		<h2>자재재고조회</h2>
	</div>
</div>

<div class="content-fluid">
	<div>
		<div class="my-panel">
			<button type="button" class="btn btn-success">조회</button>
			<button type="button" class="btn btn-danger">새자료</button>
			<button type="button" class="btn btn-warning" id="insertRow">추가저장</button>
			<button type="button" class="btn btn-info" id="updateRow">수정저장</button>
		</div>
	</div>
</div>


<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-body">
			<div class="row">
				<div class="col-md-6">
					<form>
						* 계획일자 <input type="date" id="proPlanDate" name="proPlanDate">
					</form>
				</div>
				<div class="col-md-6">* 미생산계획</div>
			</div>
		</div>
	</div>
</div>

<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-heading">
			<div class="row">
				<div class="col-md-7">
					<p class="panel-subtitle">Grid 테스트</p>
					<input type="text" id="no" name="no">
				</div>
				<div class="col-md-5" align="right">
					<button type="button" id="findRow">조회</button>
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
					url : '${pageContext.request.contextPath}/mat/matMatr/readMatMatr',
					method : 'GET'
				},
				createData : {
					url : '${pageContext.request.contextPath}/mat/matMatr/insertMatMatr',
					method : 'POST'
				},
				deleteData : {
					url : '${pageContext.request.contextPath}/mat/matMatr/deleteMatMatr',
					method : 'POST'
				},
				updateData : {
					url : '${pageContext.request.contextPath}/mat/matMatr/updateMatMatr',
					method : 'PUT'
				}
			},
			contentType : "application/json"
		};

		const grid = new tui.Grid({
			el : document.getElementById('grid'),
			rowHeaders : [ 'checkbox' ],
			data : dataSource,
			columns : [ {
				header : '자재코드',
				name : 'comMaterialCode',
				editor : 'text'
			},{
				header : '자재명',
				name : 'comMaterialName',
				editor : 'text'
			},{
				header : '안전재고',
				name : 'comMaterialSafetyStock',
				editor : 'text'
			},{
				header : '이월량',
				name : 'erpMaterialOrderCode',
				editor : 'text'
			},{
				header : '입고량',
				name : 'matInoutQuantity',
				editor : 'text'
			},{
				header : '출고량',
				name : 'matInoutQuantity',
				editor : 'text'
			},{
				header : '현재고',
				name : 'erpMaterialOrderCode',
				editor : 'text'
			},{
				header : '미달량',
				name : 'erpMaterialOrderCode',
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
<%-- <body>
	<div>
		<main>
			<div>
				<h2>자재입출고 조회</h2>
				<!-- 검색(Master) -->
				<form id="masterForm" name="masterForm" method="post">
					<div>
						<label>해당일자</label>
						<div class="tui-datepicker-input tui-datetime-input tui-has-focus"
							style="width: 140px;">
							<input type="text" id="tui-date-picker-target"
								aria-label="Date-Time"> <span class="tui-ico-date"></span>
						</div>
						<label>발주코드</label> <input type="text" id="searchOrderCode"
							name="searchOrderCode">
						<button type="button" id="searchPopBtn">검색</button>
						<label>자재코드</label> <input type="text" id="searchMatrCode"
							name="searchMatrCode">
						<button type="button" id="searchPopBtn">검색</button>
					</div>
					<div align="right">
						<button>조회</button>
						&nbsp;&nbsp;&nbsp;
						<button>초기화</button>
						&nbsp;&nbsp;&nbsp;
						<button>Exel</button>
						&nbsp;&nbsp;&nbsp;
						<button>인쇄</button>
					</div>
				</form>
				<form id="detailForm" name="detailForm" method="post">
					<div>
						<table class="dataTable" border="1" align="center">
							<thead>
								<tr>
									<th>자재코드</th>
									<th>자재명</th>
									<th>안전재고</th>
									<th>이월량</th>
									<th>입고량</th>
									<th>출고량</th>
									<th>현재고</th>
									<th>미달량</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${selectMatList}" var="matr">
									<tr>
										<td>${matr.matrVO.comMaterialCode }</td>
										<td>${matr.matrVO.comMaterialName }</td>
										<td>${matr.matrVO.comMaterialSafetyStock}</td>
										<td>이월량 추가할 자리</td>
										<td>${matr.matInoutVO.matInoutQuantity }</td>
										<td>${matr.matInoutVO.matInoutQuantity }</td>
										<td>현재고 추가할 자리</td>
										<td>미달량 추가할 자리</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</form>
			</div>
		</main>
	</div>
</body>
</html> --%>