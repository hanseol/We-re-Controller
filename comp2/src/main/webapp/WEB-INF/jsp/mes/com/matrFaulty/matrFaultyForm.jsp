<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="content-fluid">
	<div>
		<h2>자재불량코드관리</h2>
	</div>
</div>

<div class="content-fluid">
	<div>
		<div class="my-panel">
			<button type="button" class="btn btn-info" id="modifyRow">저장</button>
		</div>
	</div>
</div>

<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-heading">
			<div class="row">
				<div class="col-md-7">
					<p class="panel-subtitle">자재불량코드 관리</p>
				</div>
				<div class="col-md-5" align="right">
					<button type="button" id=appendRow>추가</button>
					<button type="button" id="deleteRow">삭제</button>
				</div>
			</div>
			<div class="panel-body">
				<div id="matrFaultyGrid"></div>
			</div>
		</div>
	</div>
</div>

<script>
	$(document).ready(function() {
		
		//네비게이션 고정 - 2021.07.23 김한설 수정
		$('#n4000000').addClass('active');
		$('#subPages4000000').addClass('in');
		$('#subPages4000000').attr('aria-expanded','true');
		$('#subPages4000000').attr('style','');
		$('.4060000').addClass('active');
		
		//변수생성
		var productFCode = 0;
		//코드명 검색
		$(document).on("click", "button[id=search]",
				function() {
					productFCode = $("#comCodeDetailId").val();
					var readParams = {
						'comProductFCode' : productFCode,
					};
					grid.readData(1, readParams, true);
				});
		
		
		const dataSource = {
			api : {
				readData : {
					url : '${pageContext.request.contextPath}/matrFaulty/matrFaultyList',
					method : 'GET'
				}, 
 				modifyData: { 
					url: '${pageContext.request.contextPath}/ajax/modifyMatrFaulty',
					method: 'PUT'
				},
			},
			contentType : "application/json"
		};
		
		//디테일 그리드
		const grid = new tui.Grid({
			el : document.getElementById('matrFaultyGrid'),
			rowHeaders : [ 'checkbox' ],
			data : dataSource,
			columns : [ {
				header : '자재불량코드',
				name : 'comMaterialFNo',
			}, {
				header : '자재불량명',
				name : 'comMaterialFName',
				editor : 'text',
			}, {
				header : '자재불량내역',
				name : 'comMaterialFDesc',
				editor : 'text'
			}]
		}); 
		
		
		//Insert
		$(document).on("click", "button[id=appendRow]", function() {
			
			var rowData = {
					comMaterialFName : "",
					comMaterialFDesc : "",
			};
		    
			grid.appendRow(rowData, {
				at: 0,
				focus : true
			});
			grid.enable();
		});
		
		//Delete
		$(document).on("click", "button[id=deleteRow]", function() {
			grid.finishEditing('rowKey','columnName');
			grid.removeCheckedRows(false);
			console.log(finishEditing);
		});
		
		//CRUD
		$(document).on("click", "button[id=modifyRow]", function() {
			grid.finishEditing('rowKey','columnName');
			grid.request('modifyData');
			console.log(finishEditing);
		});
		
		
		// option form reset  
		 $(document).ready(function() {  
		    $("#reset").click(function() {  
		         $("form").each(function() {  
		                if(this.id == "option") this.reset();  
		             });  
		    });  
		 });  
	
	}); //end of document ready
	
</script>
