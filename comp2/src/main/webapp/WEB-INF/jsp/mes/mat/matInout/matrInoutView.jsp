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
		<h2>자재입출고조회</h2>
	</div>
</div>

<!-- 관리, 지시 탭 이동 -->
<div id="tabs">
	<ul class="nav nav-tabs" role="tablist">
		<li class=""><a onclick='location.href="matrInoutForm.do"'
			aria-controls="tab1" role="tab" data-toggle="tab">관리</a></li>
		<li class="active"><a onclick='location.href="matrInoutView.do"'
			aria-controls="tab2" role="tab" data-toggle="tab">조회</a></li>
	</ul>
</div>



<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-body">
			<div class="row">
				<form id="option">
					<div class="col-md-3">
						입고일자<input type="date" id="matInoutDate" name="matInoutDate">
					</div>
					<div class="col-md-3">
						자재코드<input type="text" id="materialCode" name="materialCode">
						<a id="searchMaterialCode" href="searchMaterialCode.do">
						<i class="fa fa-search"></i></a>
						
						<input type="hidden" id="matLot" name="matLot">
						<a id="searchMatLotNo" href="searchMatLotNo.do"></a>
					</div>
					<div class="col-md-3">
						입고업체<input type="text" id="vendorCode" name="vendorCode">
						<a id="searchVendorCode" href="searchVendorCode.do">
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

<script>
$(document).ready(function () {
	
	// 옵션 폼 리셋버튼  
	$("#reset").click(function() {  
		$("form").each(function() {  
	    	if(this.id == "option") this.reset();
	    	grid.clear();
	    	outGrid.clear();
	    	});
		}); 

	//검색데이터 전송
	$(document).on("click",	"button[id=search]",
			function () {

				//데이터를 변수에 담아서 parameter로 만들기.
				var comMaterialCode = $("#materialCode").val();
				var matInoutDate = $("#matInoutDate").val();
				var erpVendorCode = $("#vendorCode").val();

				var readParams = {
					'comMaterialCode': comMaterialCode,
					'matInoutDate': matInoutDate,
					'erpVendorCode': erpVendorCode
				};
				grid.readData(1, readParams, true);
			});
	//입고목록 데이터
	const dataSource = {
		api: {
			readData: {
				url: '${pageContext.request.contextPath}/ajax/readMatInout',
				method: 'GET'
			}
		},
		// 바로 값 나오지않게함
		/* initialRequest : false, */
		contentType: "application/json"
	};
	//입고 그리드
	const grid = new tui.Grid({
		el: document.getElementById('grid'),
		rowHeaders: ['checkbox'],
		data: dataSource,
		scrollX: true,
        scrollY: true,
        bodyHeight: 150, 
        rowHeight: 30,
		columns: [{
			header: '자재입고일자',
			name: 'matInoutDate'
		}, {
			header: '업체코드',
			name: 'erpVendorCode'
		}, {
			header: '입고업체명',
			name: 'comCodeDetailName'
		}, {
			header: '자재코드',
			name: 'comMaterialCode'
		}, {
			header: '자재명',
			name: 'comMaterialName'
		}, {
			header: '규격',
			name: 'comMaterialSize'
		}, {
			header: '관리단위',
			name: 'comMaterialUnit'
		}, {
			header: '자재LOT_NO',
			name: 'matLotNo'
		}, {
			header: '수량',
			name: 'matInoutQuantity'
		}, {
			header: '단가',
			name: 'matInoutUnitPrice'
		}, {
			header: '금액',
			name: 'matInoutPrice'
		}, {
			header: '현재고',
			name: 'materialStock'
		}, {
			header: '공정코드',
			name: 'comProcessCode'
		}, {
			header: '출고공정명',
			name: 'comProcessName'
		}]
	});
	//출고 목록 데이터
	const outDataSource = {
			api: {
				readData: {
					url: '${pageContext.request.contextPath}/ajax/readMatInoutPass',
					method: 'GET'
				},
				modifyData: {
					url: '${pageContext.request.contextPath}/ajax/modifyMatInout',
					method: 'PUT'
				}

			},
			// 리스트에 값이 바로 나오지않도록 함.
			//initialRequest : false,
			contentType: "application/json"
		};
	
		//출고 그리드
		const outGrid = new tui.Grid({
			el: document.getElementById('outGrid'),
			rowHeaders: ['checkbox'],
			data: outDataSource,
			scrollX: true,
	        scrollY: true,
	        bodyHeight: 150,
	        rowHeight: 30,
			columns: [{
				header: '자재입고일자',
				name: 'matInoutDate'
			}, {
				header: '업체코드',
				name: 'erpVendorCode'
			}, {
				header: '입고업체명',
				name: 'comCodeDetailName'
			}, {
				header: '자재코드',
				name: 'comMaterialCode'
			}, {
				header: '자재명',
				name: 'comMaterialName'
			}, {
				header: '규격',
				name: 'comMaterialSize'
			}, {
				header: '관리단위',
				name: 'comMaterialUnit'
			}, {
				header: '자재LOT_NO',
				name: 'matLotNo'
			}, {
				header: '수량',
				name: 'matInoutQuantity'
			}, {
				header: '단가',
				name: 'matInoutUnitPrice'
			}, {
				header: '금액',
				name: 'matInoutPrice'
			}, {
				header: '현재고',
				name: 'materialStock'
			}, {
				header: '공정코드',
				name: 'comProcessCode'
			}, {
				header: '출고공정명',
				name: 'comProcessName'
			}]
		});
/* 	//자동 계산 (수량 *단가)
	grid.on('afterChange',ev => {
		var qty = grid.getValue( ev.changes[0].rowKey, 'matInoutQuantity');
		var unitPrice = grid.getValue( ev.changes[0].rowKey, 'matInoutUnitPrice');
		grid.setValue( ev.changes[0].rowKey, 'matInoutPrice', qty*unitPrice);
	}); */
	//데이터 제이슨타입으로 보내기
	grid.on('response', ev => {
		const { response } = ev.xhr;
		const responseObj = JSON.parse(response);

		console.log('result : ', responseObj.result);
		console.log('data : ', responseObj.data);
	});
});
</script>