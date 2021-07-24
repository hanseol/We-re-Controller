<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="content-fluid">
	<div>
		<h2>자재 재고 현황</h2>
	</div>
</div>


<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-body">
			<div class="row">
				<form id="option">
					<div class="col-md-6">
						자재검색&nbsp;&nbsp;&nbsp;<input type="text" id="materialCode" name="materialCode" class="form-control">
						<a id="searchMaterialCode" href="${pageContext.request.contextPath}/mat/inout/searchMaterialCode.do">
						<i class="fa fa-search"></i></a>
					</div>
				</form>
				<div class="col-md-6" align="right">
					<button type="button" class="btn btn-primary" id="search">조회</button>
					<button type="button" class="btn btn-success" id="reset">새자료</button>
				</div>
			</div>
		</div>
	</div>
</div>


<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-body">
			<div class="row">
				<div class="col-md-12">
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
//-----------------------------------------------------------

$(document).ready(function () {
	
	//네비게이션 바 고정.
	$('#n6000000').addClass('active');
	$('#subPages6000000').addClass('in');
	$('#subPages6000000').attr('aria-expanded','true');
	$('#subPages6000000').attr('style','');
	$('.6060000').addClass('active');
	
	
	// 옵션 폼 리셋버튼  
	$("#reset").click(function() { 
		$("form").each(function() {  
	    	if(this.id == "option") this.reset();
	    	grid.clear();
	    	
	    	$('#materialCode').val("");
	    	
	    	});
		}); 
		
	//조회버튼
	$("#search").on("click", function () {
			//데이터를 변수에 담아서 parameter로 만들기.
			var comMaterialCode = $("#materialCode").val();
			var erpVendorCode = $("#vendorCode").val();
			var readParams = {
				'comMaterialCode': comMaterialCode,
				'erpVendorCode': erpVendorCode,


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
			data : dataSource,
			scrollX: true,
	        scrollY: true,
	        bodyHeight: 600,
	        rowHeight: 30,
	        columnOptions: {
		        resizable: true
		      },
			columns : [ {
				header : '자재코드',
				name : 'comMaterialCode',
				align : 'center'
			}, {
				header : '자재명',
				name : 'comMaterialName',
				align : 'center',
				width : 'auto',
				minWidth : 100
			}, {
				header : '규격',
				name : 'comMaterialSize',
				align : 'center'
			}, {
				header : '관리단위',
				name : 'comMaterialUnit',
				align : 'center',
				width : 70
			}, {
				header : '현재고',
				name : 'materialStock',
				align : 'right',
	            formatter: (ev)=>{return (ev.value == null) ? null : String(ev.value).replace(/\B(?=(\d{3})+(?!\d))/g, ","); }
			}, {
				header : '안전재고',
				name : 'comMaterialSafetyStock',
				align : 'right',
	            formatter: (ev)=>{return (ev.value == null) ? null : String(ev.value).replace(/\B(?=(\d{3})+(?!\d))/g, ","); }
			}],
			
		});
//모달 그리드 초기화 ----------------------------------
		materialGrid = grid;
		vendorGrid = grid;
//--------------------------------------------------
		
		

		
		
		
		//현재고가 안전재고보다 낮을 때 빨간 글씨.
		grid.on('onGridUpdated',ev => {
			rowColor();
		});

		
		//발주코드 모달 로우아이디 값--------------------------------------
		
		//자재
		$('#searchMaterialCode').click(function(event) {
			materialCodeSearch(-1);
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
	  $.get("${pageContext.request.contextPath}/mat/inout/searchMaterialCode.do", function(html) {
	    $(html).appendTo('body').modal();
	  });
}



//안전재고 현재고 비교 및 색부여 함수.
function rowColor(){
	$(".tui-grid-table tbody tr").each(function(index, item){
		var materialStock = $(this).find('td').eq(4).text();
		var comMaterialSafetyStock = $(this).find('td').eq(5).text();
		
		if(parseInt(materialStock) < parseInt(comMaterialSafetyStock)){
			/* $(this).find('td').css('backgroundColor',"lightgray"); */
			$(this).find('td').css('color','red');
		}
	});
	
}

</script>