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
		<h2>자재불량조회</h2>
	</div>
</div>

<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-body">
			<div class="row">
				<form id="option">
					<div class="col-md-3">
						검사일자<input type="date" id="erpMaterialOrderDate" name="erpMaterialOrderDate">	
					</div>
					<div class="col-md-3">
						발주코드
						<input type="text" id="orderCode" name="orderCode">	
						<a href="searchMatOrderCode.do" rel="modal:open">
                     	<i class="fa fa-search"></i></a>
					</div>
					<div class="col-md-3">
						업체코드
						<input type="text" id="vendorCode" name="vendorCode">	
						<a href="searchMatOrderCode.do" rel="modal:open">
                     	<i class="fa fa-search"></i></a>
					</div>
				</form>
				<div class="col-md-3" align="right">
					<button type="button" class="btn btn-success" id="search">조회</button>
					<button type="reset" class="btn btn-danger">새자료</button>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-heading">
			<div class="row">
				<div class="col-md-7">
					<p class="panel-subtitle">자재 발주 목록</p>
				</div>
			</div>
			<div class="panel-body">
				<div id="orderGrid"></div>
			</div>
		</div>
	</div>
</div>

<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-heading">
			<div class="row">
				<div>
					<p class="panel-subtitle">자재 불량 목록</p>
					<div class="col-md-3">
						자재불량코드<input type="text" id="comMaterialCode" name="comMaterialCode">
						<a href="searchMaterialCode.do" rel="modal:open">
						<i class="fa fa-search"></i></a>
					</div>
				</div>
			</div>
			<div class="panel-body">
				<div id="fltyGrid"></div>
			</div>
		</div>
	</div>
</div>

<script>
var orderGrid;

	$(document).ready(function() {
		
		// 옵션 폼 리셋버튼  
		$("#reset").click(function() {  
			$("form").each(function() {  
		    	if(this.id == "option") this.reset();
		    	grid.clear();
		    	});
			}); 

		
		//검색데이터 전송
		$(document).on("click",	"button[id=search]",
				function () {

					//데이터를 변수에 담아서 parameter로 만들기.
					var comMaterialCode = $("#comMaterialCode").val();
					var erpMaterialOrderDate = $("#erpMaterialOrderDate").val();
					var erpMaterialOrderCode = $("#erpMaterialOrderCode").val();

					var readParams = {
						'comMaterialCode': comMaterialCode,
						'erpMaterialOrderDate': erpMaterialOrderDate,
						'erpMaterialOrderCode': erpMaterialOrderCode
					};
					grid.readData(1, readParams, true);
				});
		
		const dataSource = {
			api : {
				readData : {
					url : '${pageContext.request.contextPath}/ajax/readQuaFlty',
					method : 'GET'
				}
			},
			contentType : "application/json"
		};
		
		//불량이 있는 발주 그리드
		orderGrid = new tui.Grid({
			el : document.getElementById('orderGrid'),
			rowHeaders : [ 'checkbox' ],
			data : dataSource,
			scrollX: true,
	        scrollY: true,
	        bodyHeight: 150,
	        rowHeight: 30,
			columns : [ {
				header : '발주코드',
				name : 'erpMaterialOrderCode'
			}, {
				header : '검사일자',
				name : 'quaMaterialChkDate'
			}, {
				header: '업체코드',
				name: 'erpVendorCode'
			}, {
				header: '발주업체명',
				name: 'comCodeDetailName'
			}, {
				header : '발주량',
				name : 'erpMaterialOrderQty'
			}, {
				header: '단가',
				name: 'erpMaterialUnitPrice'
			}, {
				header: '금액',
				name: 'erpMaterialPrice'
			}, {
				header: '불량량',
				name: 'quaMaterialFQty'
			}]
		});
		
		
		const fltyDataSource = {
				api : {
					readData : {
						url : '${pageContext.request.contextPath}/ajax/readMatFltyDetail',
						method : 'GET'
					}
				},
				// 바로 값 나오지않게함
				initialRequest : false,
				contentType : "application/json"
			};
		
		
		//불량 그리드
		const fltyGrid = new tui.Grid({
			el : document.getElementById('fltyGrid'),
			rowHeaders : [ 'checkbox' ],
			data : fltyDataSource,
			scrollX: true,
	        scrollY: true,
	        bodyHeight: 150,
	        rowHeight: 30,
			columns : [ {
				header : '발주코드',
				name : 'erpMaterialOrderCode'
			}, {
				header: '자재코드',
				name: 'comMaterialCode'
			}, {
				header: '자재명',
				name: 'comMaterialName'
			}, {
				header : '자재불량코드',
				name : 'comMaterialFCode'
			}, {
				header : '불량명',
				name : 'comMaterialFName'
			}, {
				header : '불량량',
				name : 'quaMaterialFQty'
			}, {
				header: '단가',
				name: 'erpMaterialUnitPrice'
			}, {
				header: '청구금액',
				name: 'erpMatFltyPrice'
			}]
		});
		
		orderGrid.on('click', ev => {
			if(ev.columnName == 'erpMaterialOrderCode'){

				//데이터 넘겨주기.
				var materialOrderCode = orderGrid.getFocusedCell().value;

				var readParams = {
						'erpMaterialOrderCode' : materialOrderCode
				} 
				fltyGrid.readData(1, readParams, true);

				
			}
		});
		

/* 	grid.applyTheme('custom', { 
		  row: { 
		    hover: { 
		      background: '#00eeff' 
		    }
		  }
		});
	 */
}); //end of document ready
</script>