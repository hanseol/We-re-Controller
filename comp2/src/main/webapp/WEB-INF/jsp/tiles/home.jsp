<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!-- 20210630 김한설 모달창 출력-->

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
	height: 600px;
	max-height: 600px;
}

.blocker{
	z-index: 1200;
}

</style>

<div class="content-fluid">
	<div>
		<h2>페이지 명</h2>
	</div>
</div>

<div class="content-fluid">
	<div>
		<div class="my-panel">
			
			<!-- 모달창띄우기 -->
			
			<a href="testModal.do" rel="modal:open" id="getData">
			<button type="button" class="btn btn-success" id="showModal">조회</button>
			</a>
			<button type="button" class="btn btn-danger">새자료</button>
			<!-- <button type="button" class="btn btn-warning" id="insertRow">추가저장</button>
			<button type="button" class="btn btn-info" id="updateRow">수정저장</button> -->
			<button type="button" class="btn btn-info" id="modifyRow">저장</button>
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
		
		
		
		$(document).on("click", "button[id=appendRow]", function() {
			var rowData = [ {
				No : "",
				Title : "",
				Content : "",
				Date : ""
			} ];
			grid.appendRow(rowData, {
				at : grid.getRowCount(),
				focus : true
			});
			grid.enable();
		});
		
		$(document).on("click", "button[id=modifyRow]", function() {
			grid.finishEditing('rowKey','columnName');
			grid.request('modifyData');
		});
		
		/* $(document).on("click", "button[id=insertRow]", function() {
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
		}); */
		
		$(document).on("click", "button[id=findRow]", function() {
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
					url : '${pageContext.request.contextPath}/ajax/readBoard',
					method : 'GET'
				},
				/* createData : {
					url : '${pageContext.request.contextPath}/ajax/insertBoard',
					method : 'POST'
				},
				deleteData : {
					url : '${pageContext.request.contextPath}/ajax/deleteBoard',
					method : 'POST'
				},
				updateData : {
					url : '${pageContext.request.contextPath}/ajax/updateBoard',
					method : 'PUT'
				}, */
				modifyData: { url: '${pageContext.request.contextPath}/ajax/modifyBoard', method: 'PUT' },
			},
			contentType : "application/json"
		};

		const grid = new tui.Grid({
			el : document.getElementById('grid'),
			rowHeaders : [ 'checkbox' ],
			data : dataSource,
			columns : [ {
				header : 'No',
				name : 'no',
				editor : 'text'
			}, {
				header : 'Title',
				name : 'title',
				editor : 'text'
			}, {
				header : 'Content',
				name : 'content',
				editor : 'text'
			}, {
				header : 'Date',
				name : 'wdate',
				editor : {
					type : 'datePicker',
					options : {
						format : 'YYYY/MM/dd',
						language: 'ko'
					} 
				}
			} ]
		});
	

		grid.on('click', (ev) => {
			  alert(ev.rowKey);
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