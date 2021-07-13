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

.modal {
	-webkit-border-radius: 0px;
	border-radius: 0px;
	overflow: visible;
	text-align: center;
	max-width: 900px;
	width: 900px;
	/* height: 600px;
		max-height: 600px; */
}

.blocker {
	z-index: 1200;
}
</style>

<div class="content-fluid">
	<div>
		<h2>자재재고조회</h2>
	</div>
</div>

<form id="option">
	<div class="content-fluid">
		<div class="panel panel-headline">
			<div class="panel-body">
				<div class="row">
					<div class="col-md-3">
						일자<input type="date" id="matInoutDate" name="matInoutDate">
					</div>
					<div class="col-md-3">
						자재코드<input type="text" id="materialCode" name="materialCode">
						<a id="searchMaterialCode" href="searchMaterialCode.do">
						<i class="fa fa-search"></i></a>
					</div>
					<div class="col-md-3">
						입고업체<input type="text" id="vendorCode" name="vendorCode">
						<a id="searchVendorCode" href="searchVendorCode.do">
						<i class="fa fa-search"></i></a>
					</div>
					<div class="col-md-3" align="right">
						<button type="button" class="btn btn-success" id="search">조회</button>
						<button type="reset" class="btn btn-danger">새자료</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</form>

<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-body">
			<div class="row">
				<div class="col-md-9">
					<p class="panel-subtitle">자재재고현황</p>
				</div>
			</div>
			<div class="panel-body">
				<div id="grid"></div>
			</div>
		</div>
	</div>
</div>

<script>
//그리드모달창을 위한 그리드 선언-------------------------------------
let materialGrid;
let vendorGrid;
//-----------------------------------------------------------

$(document).ready(function () {
		
	//조회버튼
	$(document).on("click", "button[id=search]",
		function () {
			//데이터를 변수에 담아서 parameter로 만들기.
			var comMaterialCode = $("#materialCode").val();
			var erpVendorCode = $("#vendorCode").val();
			var matInoutDate = $("#matInoutDate").val();
			var readParams = {
				'comMaterialCode': comMaterialCode,
				'erpVendorCode': erpVendorCode,
				'matInoutDate': matInoutDate

			};
			grid.readData(1, readParams, true);
			
			
		});
		
		const dataSource = {
				api: {
					readData: {
						url: '${pageContext.request.contextPath}/ajax/readMatMatr',
						method: 'GET'
					}

				},
				// 바로 값 나오지않게함
				//initialRequest : false,
				contentType: "application/json"
			};

		const grid = new tui.Grid({
			el : document.getElementById('grid'),
			rowHeaders : [ 'checkbox' ],
			data : dataSource,
			scrollX: true,
	        scrollY: true,
	        bodyHeight: 300,
	        rowHeight: 30,
			columns : [ {
				header : '입고일자',
				name : 'matInoutDate'
			}, {
				header : '자재코드',
				name : 'comMaterialCode'
			}, {
				header : '자재명',
				name : 'comMaterialName'
			}, {
				header : '규격',
				name : 'comMaterialSize'
			}, {
				header : '관리단위',
				name : 'comMaterialUnit'
			}, {
				header : '업체코드',
				name : 'erpVendorCode'
			}, {
				header : '현재고',
				name : 'materialStock'
			}, {
				header : '안전재고',
				name : 'comMaterialSafetyStock'
			}]
		});
//모달 그리드 초기화 ----------------------------------
		materialGrid = grid;
		vendorGrid = grid;
//--------------------------------------------------
		
		
		grid.on('response', ev => {
			const {response} = ev.xhr;
			const responseObj = JSON.parse(response);

			console.log('result : ', responseObj.result);
			console.log('data : ', responseObj.data);
		});
		
		// 그리드 테마
		tui.Grid.applyTheme('clean', 
			{
				row: {
		       		hover: {
		       			background: "#DFEFF7"
		       		}
				},
				cell: {
					header: {
						background: "#D5ECED"
					},
					currentRow : {
						background: "#d5dae1"
					}
				}
		});
		
		//발주코드 모달 로우아이디 값--------------------------------------

		//자재
		$('#searchMaterialCode').click(function(event) {
			materialCodeSearch(-1);
		});
		//업체
		$('#searchVendorCode').click(function(event) {
			vendorCodeSearch(-1);
		});

	});
//그리드모달 :모달페이지로 값 넘기기----------------------------------------
//자재
var materialRowId;
function materialCodeSearch(c) {
	materialRowId = c;
	  console.log(materialRowId);
	  event.preventDefault();
	  $(".modal").remove();
	  this.blur(); // Manually remove focus from clicked link.
	  console.log(this.href);
	  $.get("${pageContext.request.contextPath}/matInout/searchMaterialCode.do", function(html) {
	    $(html).appendTo('body').modal();
	  });
}
//업체
var vendorRowId;
function vendorCodeSearch(c) {
	vendorRowId = c;
	  console.log(vendorRowId);
	  event.preventDefault();
	  $(".modal").remove();
	  this.blur(); // Manually remove focus from clicked link.
	  console.log(this.href);
	  $.get("${pageContext.request.contextPath}/matInout/searchVendorCode.do", function(html) {
	    $(html).appendTo('body').modal();
	  });
}
</script>