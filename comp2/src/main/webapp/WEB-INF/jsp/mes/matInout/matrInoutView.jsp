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

<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-heading">
			<div class="row">
				<div class="col-md-7">
					<p class="panel-subtitle">자재 입출고 목록</p>
				</div>
			</div>
			<div class="panel-body">
				<div id="grid"></div>
			</div>
		</div>
	</div>
</div>

<script>

//그리드 텍스트 에디터 타입 설정(최대글자수 설정) 클래스
class CustomTextEditor {
    constructor(props) {
      const el = document.createElement('input');
      const { maxLength } = props.columnInfo.editor.options;

      el.type = 'text';
      el.maxLength = maxLength;
      el.value = String(props.value);

      this.el = el;
    }

    getElement() {
      return this.el;
    }

    getValue() {
      return this.el.value;
    }

    mounted() {
      this.el.select();
    }
  };

$(document).ready(function () {
	//reset(새자료) 버튼 (문제 시 되돌리기)
/* 	$("#reset").click(function() {  
	         $("form").each(function() {  
	                if(this.id == "option") this.reset();  
	             });  
	    });   */
	//수량 곱하기 단가 계산 테스트 (아직 수정해야함)
	function getSumPrice(sum) {
		var matInoutQuantity = grid.getValue( sum.rowKey,'matInoutQuantity');
		var matInoutUnitPrice = grid.getValue( sum.rowKey,'matInoutUnitPrice');
		var matInoutPrice = grid.getValue( sum.rowKey, 'matInoutPrice');
		if(matInoutQuantity == null || matInoutUnitPrice == null){
			grid.setValue(sum.rowKey, 'matInoutPrice', '0')
		}else{
			grid.setValue(sum.rowKey, 'matInoutPrice', matInoutQuantity*matInoutUnitPrice)
		}
	}
	
	//입출고구분 체크박스 하나만 체크되거나 해제가능.
	$('input[type="checkbox"][name="gubunChkBox"]').click(function(){
			if($(this).prop('checked')){
			$('input[type="checkbox"][name="gubunChkBox"]').prop('checked',false);
			$(this).prop('checked',true);
		}
	});

	$(document).on("click", "button[id=search]",
		function () {
			//입출고구분
			var inGubun = $('input:checkbox[id="inGubun"]').is(":checked")
			var outGubun = $('input:checkbox[id="outGubun"]').is(":checked")
			if(inGubun == true && outGubun == false){
				var matInoutGubun = 'PNS002';
			}else if(inGubun == false && outGubun == true){
				var matInoutGubun = 'PNS003';
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
				url: '${pageContext.request.contextPath}/ajax/readMatInout',
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
			header: '입출고구분',
			name: 'matInoutGubun',
			editor: 'text'
		}, {
			header: '일자',
			name: 'matInoutDate',
			editor: {
				type: 'datePicker',
				options: {
					format: 'YYYY/MM/dd',
					language: 'ko'
				}
			}
		}, {
			header: '업체코드',
			name: 'comCodeDetailId',
			editor: 'text'
		}, {
			header: '입고업체명',
			name: 'comCodeDetailName',
			editor: 'text'
		}, {
			header: '자재코드',
			name: 'comMaterialCode',
			editor: 'text'
		}, {
			header: '자재LOT_NO',
			name: 'matLotNo',
			editor: 'text'
		}, {
			header: '자재명',
			name: 'comMaterialName',
			editor: 'text'
		}, {
			header: '규격',
			name: 'comMaterialSize',
			editor: 'text'
		}, {
			header: '관리단위',
			name: 'comMaterialUnit',
			editor: 'text'
		}, {
			header: '수량',
			name: 'matInoutQuantity',
			editor: 'text'
		}, {
			header: '단가',
			name: 'matInoutUnitPrice',
			editor: {
				type: CustomTextEditor,
				options: {
					maxLength: 7
				}
			}
		}, {
			header: '금액',
			name: 'matInoutPrice',
			editor: {
				type: CustomTextEditor,
				options: {
					maxLength: 7
				}
			}
		}, {
			header: '재고량',
			name: 'materialStock',
			editor: 'text'
		}]
		
	});


	grid.on('response', ev => {
		const { response } = ev.xhr;
		const responseObj = JSON.parse(response);

		console.log('result : ', responseObj.result);
		console.log('data : ', responseObj.data);
	});
});
</script>