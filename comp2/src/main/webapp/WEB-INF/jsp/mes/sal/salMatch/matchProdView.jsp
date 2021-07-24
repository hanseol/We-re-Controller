<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<div class="content-fluid">
	<div>
		<h2>정산입/출고목록조회</h2>
	</div>
</div>

<!-- 관리, 지시 탭 이동 -->
<div id="tabs">
   <ul class="nav nav-tabs" role="tablist">
     <li class=""><a onclick='location.href="matchProdForm.do"' aria-controls="tab1" role="tab" data-toggle="tab">관리</a></li>
     <li class="active"><a onclick='location.href="matchProdView.do"' aria-controls="tab2" role="tab" data-toggle="tab">조회</a></li>
   </ul>
</div>


<div class="content-fluid">
	<div>
		<div class="my-panel">
			<button type="button" class="btn btn-primary" id="search">조회</button>
			<button type="button" class="btn btn-success" id="reset">새자료</button>
		</div>
	</div>
</div>

<form id="option">
<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-body">
			<div class="row">
				<div class="col-md-4">
						일자
						<input type="date" id="dateGubun" name="dateGubun" class="form-control">
				</div>
				<div class="col-md-4">
						구분 
						<input type="checkbox" id="inMatch" name="gubun" value="1" checked>정산입고
						<input type="checkbox" id="outMatch" name="gubun" value="2" >정산출고
				</div>
				<div class="col-md-4">
						완제품 LOT_NO
						<input type="text" id="proProcessLotNo" name="proProcessLotNo" class="form-control">	
						<a id="searchProductLotNo" href="${pageContext.request.contextPath}/modSearchProductLotNo.do">						
                     	<i class="fa fa-search"></i></a>
				</div>
			</div>
		</div>
	</div>
</div>
</form>

<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-heading">
			<div class="row">
				<div class="col-md-7">
					<p class="panel-subtitle">완제품 정산 입/출고 목록</p>
				</div>
			</div>
			<div class="panel-body">
				<div id="grid"></div>
			</div>
		</div>
	</div>
</div>

<script>

let mgrid;

	$(document).ready(function() {
		//내비바 고정
		$('#n9000000').addClass('active');
		$('#subPages9000000').addClass('in');
		$('#subPages9000000').attr('aria-expanded','true');
		$('#subPages9000000').attr('style','');
		$('.9060000').addClass('active');
		
		$("#search").on("click", function() {
					var date = $("#dateGubun").val();
					var inMatch = $("#inMatch").val();
					var outMatch = $("#outMatch").val();
					var gubun;
					var proProcessLotNo = $("#proProcessLotNo").val();
					
					//체크박스 옵션
					if ($('input:checkbox[id="inMatch"]').is(":checked") && $('input:checkbox[id="outMatch"]').is(":checked") == true) {
						gubun = null;
					} else if ($('input:checkbox[id="inMatch"]').is(":checked") == true) {
						gubun = 'INOUT004';
					} else if ($('input:checkbox[id="outMatch"]').is(":checked") == true) {
						gubun = 'INOUT005';
					} else {
						gubun = null;
					}
										
					var readParams = {
						'salMatchDate' : date,
						'salMatchInout' : gubun,
						'proProcessLotNo' : proProcessLotNo
					};
					grid.readData(1, readParams, true);
				});
		
		const dataSource = {
			api : {
				readData : {
					url : '${pageContext.request.contextPath}/ajax/sal/readSalesMatch',
					method : 'GET'
				}
			},
			initialRequest: false, 
			contentType : "application/json"
		};

		const grid = new tui.Grid({
			el : document.getElementById('grid'),
			rowHeaders : [ 'checkbox' ],
			data : dataSource,
			scrollX: true,
	        scrollY: true,
	        bodyHeight :300, 
	        rowHeight: 30,
			columns : [ {
				header : '입/출고일자',
				name : 'salMatchDate',
				align : 'center',
				editor : {
					type : 'datePicker',
					options : {
						format : 'YYYY/MM/dd',
						language: 'ko'
					} 
				}
			}, {
				header : '입/출고구분',
				name : 'salMatchInout',
				align : 'center',
				formatter: 'listItemText',
	            editor : {
	               type: 'radio',
	               options : {
	               listItems: [
	                  {text : '정산입고', value : 'INOUT004'},
	                  {text : '정산출고', value : 'INOUT005'}
	                  ]
	               }
	            }
			}, {
				header : '정산 전표번호',
				name : 'salMatchStatement',
				align : 'center'
			}, {
				header : '제품코드',
				name : 'comProductCode',
				align : 'center',
				hidden : true
			}, {
				header : '제품명',
				name : 'comProductName',
				align : 'center'
			}, {
				header : '완제품 LOT_NO',
				name : 'proProcessLotNo',
				align : 'center'
			}, {
				header : '기존수량',
				name : 'salNowQuantity',
				align : 'right',
				formatter: (ev)=>{return (ev.value == null) ? null : String(ev.value).replace(/\B(?=(\d{3})+(?!\d))/g, ","); }
			}, {
				header : '정산수량',
				name : 'salMatchQty',
				align : 'right',
				formatter: (ev)=>{return (ev.value == null) ? null : String(ev.value).replace(/\B(?=(\d{3})+(?!\d))/g, ","); }
			}, {
				header : '최종수량',
				name : 'salInoutQuantity',
				align : 'right',
				formatter: (ev)=>{return (ev.value == null) ? null : String(ev.value).replace(/\B(?=(\d{3})+(?!\d))/g, ","); }
			}, {
				header : '작성일자',
				name : 'salWriteDate',
				align : 'center'
			}]
		});
		
		mgrid = grid;
		 
		
		 $('#searchProductCode').click(function(event) {
				productCodeSearch(-1); //매개변수 -1로 함수 실행
			});
		 
		$('#searchProductLotNo').click(function(event) {
			 	productLotNoSearch(-1);
			});
	
	// option form reset  
	    $("#reset").click(function() {  
	         $("form").each(function() {  
	                if(this.id == "option") this.reset();  
	         });  
	    });  
	
}); //end of document ready

//모달 실행 함수
var rowId;

//완제품 LOT_NO 모달
function productLotNoSearch(c) {
	  rowId = c;
	  event.preventDefault();
	  $(".modal").remove();
	  this.blur(); // Manually remove focus from clicked link.
	  console.log(this.href);
	  $.get("modSearchProductLotNo.do", function(html) {
	    $(html).appendTo('body').modal();
	  });
}

</script>