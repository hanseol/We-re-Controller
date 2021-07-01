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
		<h2>자재입출고조회</h2>
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

		<%--$(document).on("click", "button[id=appendRow]", function() {
			var rowData = [ {
				//여기 수정 해야함.
				자재코드 : "",
				자재명 : "",
				규격 : "",
				입고량 : "",
				출고량 : "",
				현재고 : ""
			} ];
			grid.appendRow(rowData, {
				at : grid.getRowCount(),
				focus : true
			});
			grid.enable();
		});--%>
		
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
				readData : {url : '${pageContext.request.contextPath}/mat/lot/readLotInout', method : 'GET'
				},
				modifyData : {url : '${pageContext.request.contextPath}/ajax/modifyBoard', method : 'PUT'
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
			}, {
				header : '자재명',
				name : 'comMaterialName',
				editor : 'text'
			}, {
				header : '규격',
				name : 'comMaterialSize',
				editor : 'text'
			}, {
				header : '입고량',
				name : 'matInoutQuantity',
				editor : 'text'
			}, {
				header : '출고량',
				name : 'matInoutQuantity',
				editor : 'text'
			}, {
				header : '현재고',
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

				<%--<form id="detailForm" name="detailForm" method="post">
					<div>
						<table class="dataTable" border="1" align="center">
							<thead>
								<tr>
									<th>자재코드</th>
									<th>자재명</th>
									<th>규격</th>
									<th>입고량</th>
									<th>출고량</th>
									<th>현재고</th>
									<!-- 현재고는 계산 -->
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${selectMatLotList}" var="lot">
									<tr>
										<td>${lot.matrVO.comMaterialCode }</td>
										<td>${lot.matrVO.comMaterialName }</td>
										<td>${lot.matrVO.comMaterialSize }</td>
										<td>${lot.matInoutVO.matInoutQuantity }</td>
										<td>${lot.matInoutVO.matInoutQuantity }</td>
										<td>현재고는 계산</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</form>--%>
