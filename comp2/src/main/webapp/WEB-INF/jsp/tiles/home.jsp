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
		<h2>기능 연구 페이지</h2>
	</div>
</div>

<div class="content-fluid">
	<div>
		<div class="my-panel">
			<!-- 모달창띄우기 -->
			<a href="testModal.do" rel="modal:open" id="getData">
			<i class="fa fa-search" ></i>
			</a>
			<button type="button" class="btn btn-danger">새자료</button>
			<button type="button" class="btn btn-info" id="modifyRow">저장</button>
		</div>
	</div>
</div>

<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-heading">
			<div class="row">
				<div class="col-md-7">
					<p class="panel-subtitle">그리드 테이블 밖에서 값을 입력할 때도 insert 가능.</p>
					<input type="text" id="no" name="no">
				</div>
				<div class="col-md-5" align="right">
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
			var rowData = {
				title : "",
				content : "",
				date : ""
			} ;
			grid.appendRow( rowData, {
				at : 0,
				/*at : grid.getRowCount(),*/
				focus : true
			});
			grid.enable();
		});
		
		$(document).on("click", "button[id=deleteRow]", function() {
			grid.finishEditing('rowKey','columnName');
			grid.removeCheckedRows(false);
		});
		
		$(document).on("click", "button[id=modifyRow]", function() {
			var no = $("#no").val();
			console.log(no);
			grid.finishEditing('rowKey','columnName');
			var requestParams = { 
				"no": no
			};
			grid.setRequestParams(requestParams);
			grid.request('modifyData');
		});
		
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
				modifyData: { url: '${pageContext.request.contextPath}/ajax/modifyBoard', method: 'PUT' },
			},
			contentType : "application/json"
		};
		
		const grid = new tui.Grid({
			el : document.getElementById('grid'),
			rowHeaders : [ 'checkbox' ],
			data : dataSource,
			scrollX: true,
	        scrollY: true,
	        bodyHeight :30, 
	        rowHeight: 30,
			columns : [ {
				header : 'No',
				hidden:'true', 
				name: 'no'
			}, {
				header : 'Title',
				name : 'title',
				editor : 'text',
				align : 'center'
			}, {
				header : 'Content',
				name : 'content',
				editor : 'text',
				align : 'center'
			}, {
				header : 'Date',
				name : 'wdate',
				editor : {
					type : 'datePicker',
					options : {
						format : 'YYYY/MM/dd',
						language: 'ko'
					} 
				},
				align : 'center'
			} ]
		});
	
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
					}
				}
			});
		//grid.on('click', (ev) => {
		//	  alert(ev.rowKey);
		//});
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