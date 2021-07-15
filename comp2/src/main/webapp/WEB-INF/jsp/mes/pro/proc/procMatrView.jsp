<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!-- 타이틀 -->
<div class="content-fluid">
	<div>
		<h2>공정별 자재 소요 조회</h2>
	</div>
</div>

<!-- 마스터 테이블 -->
<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-body">
			<div class="row">
				<form action="">
					<div class="col-md-6">
					* 작업일자   &nbsp;&nbsp;&nbsp;<input type="date" id="startDate" name="startDate"> 
						~ <input type="date" id="endDate" name="endDate"> <br/><br/>
					* 공정이름 <br/>
						<input type="radio" id="gubun1" name="gubun" value="1" checked> 마스크면결합공정
						<input type="radio" id="gubun2" name="gubun" value="2" > 끈결합공정
						<input type="radio" id="gubun3" name="gubun" value="3" > 철사결합공정
						<input type="radio" id="gubun4" name="gubun" value="4" > 포장공정
						<br/><br/>
					* 제품 코드   &nbsp;&nbsp;&nbsp;<input type="text" id="erpProductCode" name="erpProductCode"> <br/><br/>
					</div>
					<div class="col-md-6" align="right">
						<button type="button" class="btn btn-success" id="findRow">조회</button>
						<button type="reset" class="btn btn-danger" id="reset">새자료</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>


<!-- 디테일 테이블 -->
<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-heading">
			<div class="row">
				<div class="col-md-7">
					<p class="panel-subtitle">생산지시조회</p>
				</div>
			</div>
			<div class="panel-body">
				<div id="grid"></div>
			</div>
		</div>
	</div>
</div>
<script>
	$(document).ready(function() {
		//네비게이션 바 고정.
		$('#proNav').addClass('active');
		$('#subPages4').addClass('in');
		$('#subPages4').attr('aria-expanded','true');
		$('#subPages4').attr('style','');
		$('.proMat').addClass('active');
		//M 조회 버튼	
		$(document).on("click", "button[id=findRow]",
		      function() {
		 	   var gubun = $("input[name=gubun]:checked").val();
		 	   console.log(gubun);
		         var startDate = $("#startDate").val();
		         var endDate = $("#endDate").val();
		         var erpProductCode = $("#erpProductCode").val();
		         var erpCustomerCode = $("#erpCustomerCode").val();
		         var readParams = {
		      	  'searchCondition' : gubun,
		            'startDate' : startDate,
		            'endDate' : endDate,
		            'erpProductCode' : erpProductCode,
		            'erpCustomerCode' : erpCustomerCode
		         };
		         grid.readData(1, readParams, true);
		      });
		
		// M 리셋버튼  
		$("#reset").click(function() {  
			$("form").each(function() {  
		    	if(this.id == "option") this.reset();
		    	grid.clear();

		    	$('#startDate').val("");
		    	$('#endDate').val("");
		    	$('#erpProductCode').val("");
		    	$('#erpCustomerCode').val("");
		    	});
			}); 

		
		//dataSource	
		const dataSource = {
			api : {
				readData : {
					url : '${pageContext.request.contextPath}/pro/proc/procMatView',
					method : 'GET'
				}
			},
			initialRequest : false,
			contentType : "application/json"
		};

		const grid = new tui.Grid({
			el : document.getElementById('grid'),
			rowHeaders : [ 'checkbox' ],
			data : dataSource,
			columns : [ {
				header : '공정명',
				name : 'proWorkDate'
			}, {
				header : '지시번호',
				name : 'proOrderCode'
			}, {
				header : '제품코드',
				name : 'erpCustomerCode'
			}, {
				header : '제품명',
				name : 'erpProductName'
			}, {
				header : '작업일자',
				name : 'erpOrderCode'
			}, {
				header : '자재코드',
				name : 'erpProductDeadline'
			}, {
				header : '자재명',
				name : 'erpOrderQty'
			},{
				header : '규격',
				name : 'proOrderQty'
			},{
				header : '계획량',
				name : 'proOrderGubun'
			},{
				header : '현재고',
				name : 'proMaterialLot'
			} ]
		});
	
	grid.on('response', ev => {
		  const {response} = ev.xhr;
		  const responseObj = JSON.parse(response);

		  console.log('result : ', responseObj.result);
		  console.log('data : ', responseObj.data);
		});
	
	grid.on('check', (ev) => {
		  alert(`check: ${ev.rowKey}`);
	});
	

	// 그리드 테마
	tui.Grid.applyTheme('clean', 
		{
			row: {
	       		hover: {
	       			background: "#d5dae1"
	       		}
			},
			cell: {
				header: {
					background: "#003458",
					text: "white"
				},
				currentRow : {
					background: "#d5dae1"
				}
			}
	});
	
}); //end of document ready
</script>



