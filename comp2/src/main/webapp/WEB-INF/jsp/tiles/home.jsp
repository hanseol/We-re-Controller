<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />

<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
<style>
	.my-panel {
		text-align:right;
		border-top: 1px solid gray;
		padding: 10px;
		margin-bottom: 10px;
		background-color: white;
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
			<button type="button" class="btn btn-success">조회</button>
			<button type="button" class="btn btn-danger">새자료</button>
			<button type="button" class="btn btn-warning">저장</button>
			<button type="button" class="btn btn-info">삭제</button>
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
				<div class="col-md-6">
						* 미생산계획
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
				</div>
				<div class="col-md-5" align="right">
					<button type="button">조회</button>
					<button type="button" id="appendRow">추가</button>
					<button type="button">삭제</button>
				</div>
		</div>
		<div class="panel-body">
			<div id="grid"></div>
		</div>
	</div>
</div>

<script>
	$(document).ready(function(){
		
		
		$(document).on("click", "button[id=appendRow]", function(){
			var rowData = [{No: "", Title: "", Content: "",  Date: ""}];
			grid.appendRow(rowData, {
				at : grid.getRowCount(),
				focus : true
			});
			grid.enable();
		})
		
		
		const dataSource = {
			api: {
				readData: { url: '${pageContext.request.contextPath}/mes/readBoard', method: 'GET'},
				modifyData: { url: '/api/modifyData', method: 'PUT' },
				deleteData: { url: '/api/deleteData', method: 'DELETE' }
			},
			contentType:"application/json"
		};
		
		const grid = new tui.Grid({
			el: document.getElementById('grid'),
			rowHeaders: ['checkbox'],
			columns: [
				{
					header: 'No',
					name: 'no',
					editor:'text'
				},
				{
					header: 'Title',
					name: 'title',
					editor:'text'
				},
				{
					header: 'Content',
					name: 'content',
					editor:'text'
				},
				{
					header: 'Date',
					name: 'wdate',
					editor:'text'
				}
			],
			data: dataSource
		});
	});
</script>