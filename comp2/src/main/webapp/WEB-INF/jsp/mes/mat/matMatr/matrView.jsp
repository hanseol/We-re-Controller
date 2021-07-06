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
					<div class="col-md-2">
						일자<input type="date" id="matInoutDate" name="matInoutDate">
					</div>
					<div class="col-md-2">
						입/출고구분<input type="checkbox" id="inGubun" name="gubunChkBox">입고
						<input type="checkbox" id="outGubun" name="gubunChkBox">출고
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

<script>
//그리드 텍스트 에디터 타입 설정(최대글자수 설정) 클래스


$(document).ready(function () {

	//입출고구분 체크박스 하나만 체크되거나 해제가능.
	$('input[type="checkbox"][name="gubunChkBox"]').click(function(){
			if($(this).prop('checked')){
			$('input[type="checkbox"][name="gubunChkBox"]').prop('checked',false);
			$(this).prop('checked',true);
		}
	});
		
	//조회버튼
	$(document).on("click", "button[id=search]",
		function () {
			//입출고구분
			var inGubun = $('input:checkbox[id="inGubun"]').is(":checked")
			var outGubun = $('input:checkbox[id="outGubun"]').is(":checked")
			if(inGubun == true && outGubun == false){
				var matInoutGubun = 'INOUT002';
			}else if(inGubun == false && outGubun == true){
				var matInoutGubun = 'INOUT003';
			}
			//데이터를 변수에 담아서 parameter로 만들기.
			var comMaterialCode = $("#comMaterialCode").val();
			var comCodeDetailId = $("#comCodeDetailId").val();
			var matInoutDate = $("#matInoutDate").val();
			var readParams = {
				'comMaterialCode': comMaterialCode,
				'comCodeDetailId': comCodeDetailId,
				'matInoutDate': matInoutDate,
				'matInoutGubun': matInoutGubun

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
				initialRequest : false,
				contentType: "application/json"
			};

		const grid = new tui.Grid({
			el : document.getElementById('grid'),
			rowHeaders : [ 'checkbox' ],
			data : dataSource,
			columns : [ {
				header : '자재코드',
				name : 'comMaterialCode',
				editor : 'text'
			},{
				header : '자재명',
				name : 'comMaterialName',
				editor : 'text'
			},{
				header : '바코드',
				name : 'comMaterialSafetyStock',
				editor : 'text'
			},{
				header : '규격',
				name : 'comMaterialSize',
				editor : 'text'
			},{
				header : '관리단위',
				name : 'comMaterialUnit',
				editor : 'text'
			},{
				header : '공급자코드',
				name : 'comMaterialVendorCode',
				editor : 'text'
			},{
				header : '현재고',
				name : 'materialStock',
				editor : 'text'
			},{
				header : '안전재고',
				name : 'comMaterialSafetyStock',
				editor : 'text'
			},{
				header : 'MIN재고',
				name : 'comMaterialMin',
				editor : 'text'
			},{
				header : 'MAX재고',
				name : 'comMaterialMax',
				editor : 'text'
			}
			]
		});
		grid.on('response', ev => {
			const { response } = ev.xhr;
			const responseObj = JSON.parse(response);

			console.log('result : ', responseObj.result);
			console.log('data : ', responseObj.data);
		});
	});
</script>