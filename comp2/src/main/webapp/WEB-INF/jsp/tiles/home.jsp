<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!-- 20210630 김한설 모달창 출력-->

<div class="content-fluid">
	<div>
		<h2>기능 연구 페이지</h2>
	</div>
</div>

<div class="content-fluid">
	<div>
		<div class="my-panel">
			한설 to do list.. <br/>
			1. 목요일 - 설비페이지 만들기..  <br/>
			2. 금요일 - 품질표준서 페이지 만들기.. (사진첨부...) <br/>
			3. 토요일 - <br/>
			4. 일요일 - <br/>
			5. 월요일 - security 수업 열심히 듣고 권한관리 만들기... <br/>
			<!-- 모달창띄우기 -->
			테스트1<a href="testModal.do" rel="modal:open">
			<i id="test1" class="fa fa-search" ></i>
			</a>
			테스트2<a href="test2Modal.do" rel="modal:open">
			<i id="test2" class="fa fa-search" ></i>
			</a>
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
					<p class="panel-subtitle"><br/><br/>
				</div>
				<div class="col-md-5" align="right">
					<button type="button" id="appendRow">추가</button>
					<button type="button" id="deleteRow">삭제</button>
				</div>
			</div>
			<div>
				테스트1<input type="text" id="no" name="no">
				테스트2<input type="text" id="no2" name="no2">
			</div>
		</div>
		<div class="panel-body">
			<div id="grid" style="width:800px;"></div>
		</div>		
	</div>
</div>

<script>

	//$('#boardNav').removeClass('collapsed');
	$('#memberNav').addClass('active');
	//$('#boardNav').attr('aria-expanded','true'); 

	$('#subPages0').addClass('in');
	$('#subPages0').attr('aria-expanded','true');
	$('#subPages0').attr('style','');
	
	$('.boardList').addClass('active');

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
				align : 'center',
				editor : 'text',
				validation: {
					required:true
				},
				filter : 'text'
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
					},
					currentRow : {
						background: "#d5dae1"
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