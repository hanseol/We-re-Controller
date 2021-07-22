<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>



<div class="content-fluid">
	<div>
		<h2>자재 입/출고 조회</h2>
	</div>
</div>
<!-- 입고, 출고 탭 이동 -->
<div class="tabs">
   <ul class="nav nav-tabs" role="tablist">
     <li class="tablinks active"><a href="#" onclick="tabgubun('ingrid');" aria-controls="tab1" role="tab" data-toggle="tab">입고</a></li>
     <li class="tablinks"><a href="#" onclick="tabgubun('outgrid');" aria-controls="tab2" role="tab" data-toggle="tab">출고</a></li>
   </ul>
</div>
<!-- ======================================입고시작================================================== -->
<div id="ingrid" class="tabcontent" style="display: block;">

<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-body">
			<div class="row">
				<form id="option">
					<div class="col-md-12">
						입고일자&nbsp;&nbsp;&nbsp;<input type="date" id="inDate" name="inDate">&nbsp;~&nbsp;<input type="date" id="inEndDate" name="inEndDate">
					</div>
					<div class="col-md-12"><br/></div>
					<div class="col-md-4" align="left">
						자재검색&nbsp;&nbsp;&nbsp;<input type="text" id="inMaterialCode" name="inMaterialCode">
						<a id="inSearchMaterialCode" href="${pageContext.request.contextPath}/mat/inout/searchMaterialCode.do">
						<i class="fa fa-search"></i></a>
					</div>
					<div class="col-md-4" align="left">
						업체검색&nbsp;&nbsp;&nbsp;<input type="text" id="inVendorCode" name="inVendorCode">
						<a id="inSearchVendorCode" href="${pageContext.request.contextPath}/mat/inout/searchVendorCode.do">
						<i class="fa fa-search"></i></a>
					</div>
				</form>
				<div class="col-md-4" align="right">
					<button type="button" class="btn btn-primary" id="inSearch">조회</button>
					<button type="button" class="btn btn-success" id="inReset">새자료</button>
				</div>
			</div>
		</div>
	</div>
</div>



<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-body">
			<div class="row">
				<div class="col-md-9">
					<p class="panel-subtitle">입고</p>
				</div>
			</div>
			<div class="panel-body">
				<div id="grid"></div>
			</div>
		</div>
	</div>
</div>

</div>
<!-- ======================================출고시작================================================== -->

<div id="outgrid" class="tabcontent" style="display: none;">
<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-body">
			<div class="row">
				<form id="option">
					<div class="col-md-12">
						출고일자&nbsp;&nbsp;&nbsp;<input type="date" id="outDate" name="outDate">&nbsp;~&nbsp;<input type="date" id="outEndDate" name="outEndDate">
					</div>
					<div class="col-md-12"><br/></div>
					<div class="col-md-4" align="left">
						자재검색&nbsp;&nbsp;&nbsp;<input type="text" id="outMaterialCode" name="outMmaterialCode">
						<a id="outSearchMaterialCode" href="${pageContext.request.contextPath}/mat/inout/searchMaterialCode.do">
						<i class="fa fa-search"></i></a>
					</div>
					<div class="col-md-4" align="left">
						출고공정검색&nbsp;<input type="text" id="outProcessCode" name="outProcessCode">
						<a id="outSearchProcessCode" href="${pageContext.request.contextPath}/mat/inout/searchVendorCode.do">
						<i class="fa fa-search"></i></a>
					</div>
				</form>
				<div class="col-md-4" align="right">
					<button type="button" class="btn btn-primary" id="outSearch">조회</button>
					<button type="button" class="btn btn-success" id="outReset">새자료</button>
				</div>
			</div>
		</div>
	</div>
</div>


<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-body">
			<div class="row">
				<div class="col-md-9">
					<p class="panel-subtitle">출고</p>
				</div>
			</div>
			<div class="panel-body">
				<div id="outGrid"></div>
			</div>
		</div>
	</div>
</div>
</div>





<script>
//그리드모달창을 위한 그리드 선언-------------------------------------
let materialGrid;
let vendorGrid;
var outGrid;
var grid;
//-----------------------------------------------------------

//=====================================================입고그리드=====================================================
	$(document).ready(function () {
		
		//네비게이션 바 고정.
		$('#n6000000').addClass('active');
		$('#subPages6000000').addClass('in');
		$('#subPages6000000').attr('aria-expanded','true');
		$('#subPages6000000').attr('style','');
		$('.6030000').addClass('active');
		

		// 옵션 폼 리셋버튼  
		$("#inReset").click(function() { 
			$("form").each(function() {  
		    	if(this.id == "option") this.reset();
		    	grid.clear();
		    	
		    	$('#inMaterialCode').val("");
		    	$('#inVendorCode').val("");
		    	
		    	});
			}); 
		
		
		//검색데이터 전송
		$("#inSearch").on("click", function () {

			//데이터를 변수에 담아서 parameter로 만들기.
			var inMaterialCode = $("#inMaterialCode").val();
			var inDate = $("#inDate").val();
			var inVendorCode = $("#inVendorCode").val();
			var inEndDate = $("#inEndDate").val();

			var readParams = {
				'comMaterialCode': inMaterialCode,
				'matInoutDate': inDate,
				'erpVendorCode': inVendorCode,
				'matInoutEndDate' : inEndDate
			};
			grid.readData(1, readParams, true);
		});
		//입고 목록 데이터
		const dataSource = {
			api: {
				readData: {
					url: '${pageContext.request.contextPath}/ajax/readMatInout',
					method: 'GET'
				}

			},
			// 리스트에 값이 바로 나오지않도록 함.
			//initialRequest : false,
			contentType: "application/json"
		};
		//입고 그리드
		grid = new tui.Grid({
			el: document.getElementById('grid'),
			data: dataSource,
			scrollX: true,
	        scrollY: true,
	        bodyHeight: 400, 
	        rowHeight: 30,
			columns: [ {
				header: '전표번호',
				name: 'quaMaterialStatement',
				align: 'center'
			}, {
				header: '자재코드',
				name: 'comMaterialCode',
				align: 'center',
				hidden: true
			}, {
				header: '자재명',
				name: 'comMaterialName',
				align: 'center'
			}, {
				header: '단가(원)',
				name: 'matInoutUnitPrice',
				align: 'right',
	            formatter: (ev)=>{return (ev.value == null) ? null : String(ev.value).replace(/\B(?=(\d{3})+(?!\d))/g, ","); }
			}, {
				header: '수량',
				name: 'matInoutQuantity',
				align: 'right',
				editor: 'text'
			}, {
				header: '금액(원)',
				name: 'matInoutPrice',
				minWidth: 100,
				align: 'right',
	            formatter: (ev)=>{return (ev.value == null) ? null : String(ev.value).replace(/\B(?=(\d{3})+(?!\d))/g, ","); }
			}, {
				header: '관리단위',
				name: 'comMaterialUnit',
				align: 'center'
			}, {
				header: '입고일자',
				name: 'matInoutDate',
				align: 'center',
				editor: {
					type: 'datePicker',
					options: {
						format: 'YYYY/MM/dd',
						language: 'ko'
					}
				}
			}, {
				header: '업체코드',
				name: 'comMaterialVendorCode',
				align: 'center',
				hidden: true
			}, {
				header: '입고업체명',
				name: 'comCodeDetailName',
				align: 'center'
				
			}]
		});
		
//=====================================================출고그리드 시작=====================================================	
		
		// 옵션 폼 리셋버튼  
		$("#outReset").click(function() { 
			$("form").each(function() {  
		    	if(this.id == "option") this.reset();
		    	outGrid.clear();
		    	
		    	$('#outMaterialCode').val("");
		    	$('#outProcessCode').val("");
		    	
		    	});
			}); 
		

		
		
		
		

		//검색데이터 전송
		$("#outSearch").on("click", function () {

			//데이터를 변수에 담아서 parameter로 만들기.
			var outMaterialCode = $("#outMaterialCode").val();
			var outDate = $("#outDate").val();
			var outProcessCode = $("#outProcessCode").val();
			var outEndDate = $("#outEndDate").val();

			var readParams = {
				'comMaterialCode': outMaterialCode,
				'matInoutDate': outDate,
				'comProcessCode': outProcessCode,
				'matInoutEndDate' : outEndDate
			};
			
			outGrid.readData(1, readParams, true);
		});	
		//출고 목록 데이터
		const outDataSource = {
				api: {
					readData: {
						url: '${pageContext.request.contextPath}/ajax/readMatInoutPass',
						method: 'GET'
					}

				},
				// 리스트에 값이 바로 나오지않도록 함.
				//initialRequest : false,
				contentType: "application/json"
			};
		
		//출고 그리드
		outGrid = new tui.Grid({
			el: document.getElementById('outGrid'),
			data: outDataSource,
			scrollX: true,
	        scrollY: true,
	        bodyHeight: 400,
	        rowHeight: 30,
			columns: [{
				header: '전표번호',
				name: 'quaMaterialStatement',
				align: 'center'
			}, {
				header: '자재코드',
				name: 'comMaterialCode',
				align: 'center',
				hidden: true
			}, {
				header: '자재명',
				name: 'comMaterialName',
				align: 'center'
			}, {
				header: '단가(원)',
				name: 'matInoutUnitPrice',
				align: 'right',
	            formatter: (ev)=>{return (ev.value == null) ? null : String(ev.value).replace(/\B(?=(\d{3})+(?!\d))/g, ","); }
			}, {
				header: '수량',
				name: 'matInoutQuantity',
				align: 'right',
				editor: 'text'
			}, {
				header: '금액(원)',
				name: 'matInoutPrice',
				minWidth: 100,
				align: 'right',
	            formatter: (ev)=>{return (ev.value == null) ? null : String(ev.value).replace(/\B(?=(\d{3})+(?!\d))/g, ","); }
			}, {
				header: '관리단위',
				name: 'comMaterialUnit',
				align: 'center'
			}, {
				header: '출고일자',
				name: 'matInoutDate',
				align: 'center'
			}, {
				header: '공정코드',
				name: 'comProcessCode',
				align: 'center',
				hidden: true
			}, {
				header: '출고공정명',
				name: 'comCodeDetailName',
				align: 'center'
			}]
		});
//모달 그리드 초기화 ----------------------------------
		materialGrid = grid;
		vendorGrid = grid;
//--------------------------------------------------
		
//=====================================================출고그리드 끝=====================================================


//=====================================================기타 실행 함수=====================================================
		//자동 계산 (수량 *단가)
		grid.on('afterChange',ev => {
			
			var qty = grid.getValue( ev.changes[0].rowKey, 'matInoutQuantity');
			var unitPrice = grid.getValue( ev.changes[0].rowKey, 'erpMaterialUnitPrice');
			grid.setValue( ev.changes[0].rowKey, 'matInoutPrice', qty*unitPrice);
			
		});
		
		//날짜 범위 검색 옵션
		var start = $("#inoutDate");
		var end = $("#inoutEndDate");
		start.change(function(){
			if(end.val() == ""){
				end.val(start.val());
			}
		});
		end.change(function(){
			if(start.val() == ""){
				start.val(end.val());
			}
		});
		

		
/* 		// 그리드 테마
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
		}); */

		//그리드 로우아이디 지정--------------------------------------
		//입고탭 자재인풋 로우키
		$('#inSearchMaterialCode').click(function(event) {
			materialCodeSearch(-3);
		});
		//입고탭 업체인풋 로우키
		$('#inSearchVendorCode').click(function(event) {
			vendorCodeSearch(-3);
		});
		
		//출고탭 자재인풋 로우키
		$('#outSearchMaterialCode').click(function(event) {
			materialCodeSearch(-4);
		});
		//출고탭 공정인풋 로우키
		$('#outSearchProcessCode').click(function(event) {
			processCodeSearch(-4);
		});
		//-----------------------------------------------------
});//end of document ready
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
	//업체
	var vendorRowId;
	function vendorCodeSearch(c) {
		vendorRowId = c;
		  console.log(vendorRowId);
		  event.preventDefault();
		  $(".modal").remove();
		  this.blur(); // Manually remove focus from clicked link.
		  console.log(this.href);
		  $.get("${pageContext.request.contextPath}/mat/inout/searchVendorCode.do", function(html) {
		    $(html).appendTo('body').modal();
		  });
	}
	//탭 이동
	function tabgubun(inout) {
		 var evt = window.event;
		  var i, tabcontent, tablinks;
		  tabcontent = document.getElementsByClassName("tabcontent");
		  for (i = 0; i < tabcontent.length; i++) {
		    tabcontent[i].style.display = "none";
		  }
		  tablinks = document.getElementsByClassName("tablinks");
		  for (i = 0; i < tablinks.length; i++) {
		    tablinks[i].className = tablinks[i].className.replace(" active", "");
		  }
		  document.getElementById(inout).style.display = "block";
		  evt.currentTarget.className += " active";
		  
			 
		  if(inout == 'outgrid'){
			  outGrid.refreshLayout();
		  } else if(inout == 'ingrid'){
			  grid.refreshLayout();
		  }
	}
</script>