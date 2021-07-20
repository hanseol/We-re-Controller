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
				<form id="procMatrFrm" name="procMatrFrm" method="POST" action="${pageContext.request.contextPath}/procMatrExcel">
					<div class="col-md-6">
					<!-- * 작업일자   &nbsp;&nbsp;&nbsp;<input type="date" id="startDate" name="startDate"> 
						~ <input type="date" id="endDate" name="endDate"> <br/><br/> -->
					* 공정이름   &nbsp;&nbsp;&nbsp;
						<input type="radio" id="gubun1" name="gubun" value="1" checked> 제작공정  &nbsp;&nbsp;&nbsp;
						<input type="radio" id="gubun2" name="gubun" value="2" > 포장공정
					
						<br/><br/>
					* 지시 코드   &nbsp;&nbsp;&nbsp;<input type="text" id="proOrderDetailCode" name="proOrderDetailCode">
						<!-- 지시검색모달 -->
						<a href="${pageContext.request.contextPath}/pro/proc/finishOrderSearch.do" rel="modal:open">						
                    		<i class="fa fa-search"></i>
                 		</a>
                 	
					
					</div>
					<div class="col-md-6" align="right">
						<button type="button" class="btn btn-success" id="findRow">조회</button>
						<button type="reset" class="btn btn-danger" id="reset">새자료</button>
						<button type="submit" class="btn btn-primary" id="excelBtn">Excel</button>
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
		$("#findRow").click(function() {
		 	   var gubun = $("input[name=gubun]:checked").val();
		 	   console.log(gubun);
		         var startDate = $("#startDate").val();
		         var endDate = $("#endDate").val();
		         var erpProductCode = $("#erpProductCode").val();
		         var erpCustomerCode = $("#erpCustomerCode").val();
		         var proOrderDetailCode = $("#proOrderDetailCode").val();
		         
		         var readParams = {
		      	  'searchCondition' : gubun,
		            'startDate' : startDate,
		            'endDate' : endDate,
		            'erpProductCode' : erpProductCode,
		            'erpCustomerCode' : erpCustomerCode,
		            'proOrderDetailCode' : proOrderDetailCode
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
		    	$('#proOrderDetailCode').val("")
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

		//그리드
		const grid = new tui.Grid({
			el : document.getElementById('grid'),
			rowHeaders : [ 'checkbox' ],
			data : dataSource,
			columns : [ {
				header : '공정명',
				name : 'comCodeDetailName',
				align: 'center'
			}, {
				header : '지시번호',
				name : 'proOrderDetailCode',
				align: 'center'
			}, {
				header : '제품코드',
				name : 'erpProductCode',
				align: 'center'
			}, {
				header : '제품명',
				name : 'erpProductName',
				align: 'center'
			}, {
				header : '자재로트번호',
				name : 'matLotNo',
				align: 'center'
			}, {
				header : '작업일자',
				name : 'proWorkDate',
				align: 'center'
			}, {
				header : '자재코드',
				name : 'comMaterialCode',
				align: 'center'
			}, {
				header : '자재명',
				name : 'comMaterialName',
				align: 'center'
			}, {
				header : '계획량',
				name : 'proPlanQty',
				align: 'right',
				formatter: (ev)=>{return (ev.value == null) ? null : String(ev.value).replace(/\B(?=(\d{3})+(?!\d))/g, ","); }
			}, {
				header : '지시량',
				name : 'proOrderQty',
				align: 'right',
				formatter: (ev)=>{return (ev.value == null) ? null : String(ev.value).replace(/\B(?=(\d{3})+(?!\d))/g, ","); }
			}]
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
	
	
	
	/* 	grid.on('response', ev => {
			  const {response} = ev.xhr;
			  const responseObj = JSON.parse(response);

			  console.log('result : ', responseObj.result);
			  console.log('data : ', responseObj.data);
			});
		
		grid.on('check', (ev) => {
			  alert(`check: ${ev.rowKey}`);
		});
		 */
	
	
	
}); //end of document ready
</script>



