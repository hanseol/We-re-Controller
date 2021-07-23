<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="content-fluid">
	<div>
		<h2>자재검사결과 조회</h2>
	</div>
</div>

<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-body">
			<div class="row">
				<form id="option">
					<div class="col-md-12">
						검사일자&nbsp;&nbsp;&nbsp;<input type="date" id="quaChkDate" name="quaChkDate" class="form-control">&nbsp;~&nbsp;<input type="date" id="quaChkEndDate" name="quaChkEndDate" class="form-control">
					</div>
					<div class="col-md-12"><br/></div>
					<div class="col-md-4">
						자재검색&nbsp;&nbsp;&nbsp;<input type="text" id="materialCodeTwo" name="materialCodeTwo" class="form-control">
						<a id="searchMaterialCodeTwo" href="${pageContext.request.contextPath}/mat/inout/searchMaterialCode.do">
						<i class="fa fa-search"></i></a>
					</div>
					<div class="col-md-4">
						업체검색&nbsp;&nbsp;&nbsp;<input type="text" id="vendorCodeTwo" name="vendorCodeTwo" class="form-control">
						<a id="searchVendorCodeTwo" href="${pageContext.request.contextPath}/mat/inout/searchVendorCode.do">
						<i class="fa fa-search"></i></a>
					</div>
				</form>
				<div class="col-md-4" align="right">
					<button type="button" class="btn btn-primary" id="searchPass">조회</button>
					<button type="button" class="btn btn-success" id="reset">새자료</button>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-heading">
			<div class="row">
				<div class="col-md-12">
					<p class="panel-subtitle">검사 완료 목록</p>
				</div>
			</div>
			<div class="panel-body">
				<div id="passGrid"></div>
			</div>
		</div>
	</div>
</div>
<script>
//그리드모달창을 위한 그리드 선언-------------------------------------


let materialTwoGrid;
let vendorTwoGrid;
//-----------------------------------------------------------
	

		

		
//=======================================그리드 버튼설정===========================================
	$(document).ready(function () {
		
		//네비게이션 고정
		$('#n5000000').addClass('active');
		$('#subPages5000000').addClass('in');
		$('#subPages5000000').attr('aria-expanded','true');
		$('#subPages5000000').attr('style','');
		$('.5020000').addClass('active');
		
		// 옵션 폼 리셋버튼  
		$("#reset").click(function() { 
			$("form").each(function() {  
		    	if(this.id == "option") this.reset();
		    	passGrid.clear();
		    	
		    	$('#materialCodeTwo').val("");
		    	$('#vendorCodeTwo').val("");
		    	
		    	});
			}); 
		
		//그리드 [조회]버튼
		$("#searchPass").on("click", function () {

			//데이터를 변수에 담아서 parameter로 만들기.
			var quaChkDate = $("#quaChkDate").val();
			var materialCodeTwo = $("#materialCodeTwo").val();
			var vendorCodeTwo = $("#vendorCodeTwo").val();
			var quaChkEndDate = $("#quaChkEndDate").val();

			var readParams = {
				'quaMaterialDate' : quaChkDate,
				'comMaterialCode': materialCodeTwo,
				'erpVendorCode': vendorCodeTwo,
				'quaMaterialEndDate' : quaChkEndDate
			};
			passGrid.readData(1, readParams, true);
			
		});



	//합격해서 입고된 자재만 등록하는 그리드 데이터
	const passDataSource = {
			api: {
				readData: {
					url: '${pageContext.request.contextPath}/ajax/readQuaChkPass',
					method: 'GET'
				},
				modifyData: {
					url: '${pageContext.request.contextPath}/ajax/modifyQuaChk',
					method: 'PUT'
				}

			},
			// 리스트에 값이 바로 나오지않도록 함.
			/* initialRequest : false, */
			contentType: "application/json"
		};
	//검사완료한  자재 조회
	const passGrid = new tui.Grid({
		el: document.getElementById('passGrid'),
		data: passDataSource,
		scrollX: true,
        scrollY: true,
        bodyHeight: 300, 
        rowHeight: 30,
        

		columns: [{
			header: '발주코드',
			name: 'erpMaterialOrderCode',
			align: 'center'
		}, {
			header: '검사일자',
			name: 'quaMaterialChkDate',
			align: 'center',
		}, {
			header: '입고일자',
			name: 'quaMaterialDate',
			align: 'center'
		}, {
			header: '업체코드',
			name: 'erpVendorCode',
			align: 'center',
			hidden: true
		}, {
			header: '업체명',
			name: 'comCodeDetailName',
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
			header: '규격',
			name: 'comMaterialSize',
			align: 'center'
		}, {
			header: '관리단위',
			name: 'comMaterialUnit',
			align: 'center'
		}, {
			header: '발주량',
			name: 'erpMaterialOrderQty',
			align : 'right'
		}, {
			header: '합격량',
			name: 'quaMaterialPQty',
			align : 'right'
		}, {
			header: '불량량',
			name: 'quaMaterialFQty',
			align : 'right'
		}, {
			header: '단가(원)',
			name: 'erpMaterialUnitPrice',
			align : 'right',
            formatter: (ev)=>{return (ev.value == null) ? null : String(ev.value).replace(/\B(?=(\d{3})+(?!\d))/g, ","); }
		}, {
			header: '금액(원)',
			name: 'erpMaterialPrice',
			align : 'right',
            formatter: (ev)=>{return (ev.value == null) ? null : String(ev.value).replace(/\B(?=(\d{3})+(?!\d))/g, ","); }
		}]
	});
	
	
	//모달 그리드 초기화 ----------------------------------
	materialTwoGrid = passGrid;
	vendorTwoGrid = passGrid;
	//------------------------------------------------
	
	

	
		//날짜 범위 검색 옵션
		var start = $("#quaChkDate");
		var end = $("#quaChkEndDate");
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
	

		//---------------------------그리드2
	//그리드2 자재
	$('#searchMaterialCodeTwo').click(function(event) {
		materialCodeSearch(-2);
	});
	//그리드2 업체
	$('#searchVendorCodeTwo').click(function(event) {
		vendorCodeSearch(-2);
	});
		
	
});//end of document ready
//그리드모달 :모달페이지로 값 넘기기----------------------------------------
//발주
var matOrderRowId;
function matOrderCodeSearch(c) {
matOrderRowId = c;
  //console.log(matOrderRowId);
  event.preventDefault();
  $(".modal").remove();
  this.blur(); // Manually remove focus from clicked link.
  //console.log(this.href);
  $.get("${pageContext.request.contextPath}/mat/order/searchMatOrderCode.do", function(html) {
    $(html).appendTo('body').modal();
  });
}
//자재
var materialRowId;
function materialCodeSearch(c) {
materialRowId = c;
  //console.log(materialRowId);
  event.preventDefault();
  $(".modal").remove();
  this.blur(); // Manually remove focus from clicked link.
  //console.log(this.href);
  $.get("${pageContext.request.contextPath}/mat/inout/searchMaterialCode.do", function(html) {
    $(html).appendTo('body').modal();
  });
}
//업체
var vendorRowId;
function vendorCodeSearch(c) {
vendorRowId = c;
  //console.log(vendorRowId);
  event.preventDefault();
  $(".modal").remove();
  this.blur(); // Manually remove focus from clicked link.
  console.log(this.href);
  $.get("${pageContext.request.contextPath}/mat/inout/searchVendorCode.do", function(html) {
    $(html).appendTo('body').modal();
  });
}
//---------------------------------------------------------------
</script>