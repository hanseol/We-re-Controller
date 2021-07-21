<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>



<div class="content-fluid">
	<div>
		<h2>자재재고조회</h2>
	</div>
</div>


<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-body">
			<div class="row">
				<form id="option">
					<div class="col-md-3">
						자재검색<input type="text" id="materialCode" name="materialCode">
						<a id="searchMaterialCode" href="${pageContext.request.contextPath}/mat/inout/searchMaterialCode.do">
						<i class="fa fa-search"></i></a>
					</div>
				</form>
				<div class="col-md-9" align="right">
					<button type="button" class="btn btn-success" id="search">조회</button>
					<button type="button" class="btn btn-danger" id="reset">새자료</button>
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
//네비게이션 바 고정.
$('#matNav').addClass('active');
$('#subPages3').addClass('in');
$('#subPages3').attr('aria-expanded','true');
$('#subPages3').attr('style','');
$('.matrView').addClass('active');

$(document).ready(function () {
	
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
	        bodyHeight: 400,
	        rowHeight: 30,
			columns : [ {
				header : '자재코드',
				name : 'comMaterialCode',
				align : 'center'
			}, {
				header : '자재명',
				name : 'comMaterialName',
				align : 'center'
			}, {
				header : '규격',
				name : 'comMaterialSize',
				align : 'center'
			}, {
				header : '관리단위',
				name : 'comMaterialUnit',
				align : 'center'
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
			}]
		});
//모달 그리드 초기화 ----------------------------------
		materialGrid = grid;
		vendorGrid = grid;
//--------------------------------------------------
		
		
/* 		grid.on('response', ev => {
			const {response} = ev.xhr;
			const responseObj = JSON.parse(response);

			console.log('result : ', responseObj.result);
			console.log('data : ', responseObj.data);
		}); */
		
			
		
		
		
		
		grid.on('click',ev => {
			var rowKey = ev.rowKey;
			var nowStock = grid.getValue(rowKey, 'materialStock'); 
			var safetyStock = grid.getValue(rowKey, 'comMaterialSafetyStock');
			
			if(nowStock < safetyStock){
				tui.Grid.applyTheme('clean',{
					cell: {
						currentRow : {
							background: "red"
						}
					}
				});
			}else return;
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

</script>