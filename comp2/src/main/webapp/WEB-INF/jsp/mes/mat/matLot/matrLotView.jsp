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
		<h2>자재LOT재고 조회</h2>
	</div>
</div>

<!-- 관리, 지시 탭 이동 -->
<div id="tabs">
	<ul class="nav nav-tabs" role="tablist">
		<li class=""><a onclick='location.href="matrLotForm.do"'
			aria-controls="tab1" role="tab" data-toggle="tab">관리</a></li>
		<li class="active"><a onclick='location.href="matrLotView.do"'
			aria-controls="tab2" role="tab" data-toggle="tab">조회</a></li>
	</ul>
</div>


<form id="option">
	<div class="content-fluid">
		<div class="panel panel-headline">
			<div class="panel-body">
				<div class="row">
					<div class="col-md-2">
						일자<input type="date" id="matInoutDate" name="matInoutDate">
					</div>
					<div class="col-md-2">
						자료구분<input type="checkbox" id="inGubun" name="gubunChkBox">정산입고
						<input type="checkbox" id="outGubun" name="gubunChkBox">정산출고
					</div>
					<div class="col-md-2">
						자재코드<a href="${pageContext.request.contextPath}/searchMaterialCode.do"	rel="modal:open">
						<input type="text" id="comMaterialCode"	name="comMaterialCode">
						<i class="fa fa-search"></i></a>
					</div>
					<div class="col-md-3">
						입고업체<a href="${pageContext.request.contextPath}/searchVendorCode.do" rel="modal:open">
						<input type="text" id="comCodeDetailId"	name="comCodeDetailId">
						<i class="fa fa-search"></i></a>
					</div>
					<div class="col-md-3">
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
		<div class="panel-heading">
			<div class="row">
				<div class="col-md-7">
					<p class="panel-subtitle">자재LOT재고 목록</p>
				</div>
			</div>
			<div class="panel-body">
				<div id="grid"></div>
			</div>
		</div>
	</div>
</div>

<script>
//네비게이션 바 고정.
$('#matNav').addClass('active');
$('#subPages3').addClass('in');
$('#subPages3').attr('aria-expanded','true');
$('#subPages3').attr('style','');
$('.matrLot').addClass('active');

$(document).ready(function () {
	//reset(새자료) 버튼 (문제 시 되돌리기)
/* 	$("#reset").click(function() {  
	         $("form").each(function() {  
	                if(this.id == "option") this.reset();  
	             });  
	    });   */

	
	//입출고구분 체크박스 하나만 체크되거나 해제가능.
	$('input[type="checkbox"][name="gubunChkBox"]').click(function(){
			if($(this).prop('checked')){
			$('input[type="checkbox"][name="gubunChkBox"]').prop('checked',false);
			$(this).prop('checked',true);
		}
	});

	$(document).on("click",	"button[id=search]",
			function () {
				//입출고구분 테스트
				var inGubun = $('input:checkbox[id="inGubun"]').is(":checked")
				var outGubun = $('input:checkbox[id="outGubun"]').is(":checked")
				if(inGubun == true && outGubun == false){
					var matMatchInout = 'INOUT004';
				}else if(inGubun == false && outGubun == true){
					var matMatchInout = 'INOUT005';
				}

				//데이터를 변수에 담아서 parameter로 만들기.

				var matMatchDate = $("#matMatchDate").val();
				var erpVendorCode = $("#erpVendorCode").val();
				var matMatchInout = $("#matMatchInout").val();

				var readParams = {
					'matMatchDate': matMatchDate,
					'erpVendorCode': erpVendorCode,
					'matMatchInout': matMatchInout
				};
				grid.readData(1, readParams, true);
			});

	const dataSource = {
		api: {
			readData: {
				url: '${pageContext.request.contextPath}/ajax/readMatLot',
				method: 'GET'
			}

		},
		// 바로 값 나오지않게함
		initialRequest : false,
		contentType: "application/json"
	};

	const grid = new tui.Grid({
		el: document.getElementById('grid'),
		rowHeaders: ['checkbox'],
		data: dataSource,
		
		columns: [{
			header : '입/출고일자',
			name : 'matMatchDate'
		}, {
			header: '정산입출고구분',
			name: 'matMatchInout'
		}, {
			header: '자재LOT_NO',
			name: 'matLotNo'
		}, {
			header: '자재코드',
			name: 'comMaterialCode'
		}, {
			header: '자재명',
			name: 'comMaterialName'
		}, {
			header: '현재수량',
			name: 'matInoutQty'
		}, {
			header: '정산량',
			name: 'matMatchQty'
		}, {
			header: '최종수량',
			name: 'finalQty'
		}]
	});
	




	grid.on('response', ev => {
		const { response } = ev.xhr;
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
	
});
</script>