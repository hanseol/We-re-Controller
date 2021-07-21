<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!-- 타이틀 -->
<div class="content-fluid">
	<div>
		<h2>공정별 자재 소요 조회</h2>
	</div>
</div>


<!-- 생산 전, 생산 완료 탭 이동 -->
<div class="tabs">
   <ul class="nav nav-tabs" role="tablist">
     <li class="tablinks active"><a href="#" onclick="tabgubun('totalgrid');" aria-controls="tab1" role="tab" data-toggle="tab">전체 조회</a></li>
     <li class="tablinks"><a href="#" onclick="tabgubun('finishgrid');" aria-controls="tab2" role="tab" data-toggle="tab">완료 조회</a></li>
   </ul>
</div>

<!-----------------------------------생산 전 자재 소요 조회(total)----------------------------------->
<!-- 마스터 테이블 -->
<div id="totalgrid" class="tabcontent" style="display: block;">
<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-body">
			<div class="row">
				<form id="totalProcMatrFrm" name="totalProcMatrFrm" method="POST" action="${pageContext.request.contextPath}/procMatrExcel">
					<div class="col-md-6">
					* 공정이름   &nbsp;&nbsp;&nbsp;
						<input type="radio" id="totalGubun1" name="totalGubun" value="1" checked> 제작공정  &nbsp;&nbsp;&nbsp;
						<input type="radio" id="totalGubun2" name="totalGubun" value="2" > 포장공정
					
						<br/><br/>
					* 지시 코드   &nbsp;&nbsp;&nbsp;<input type="text" id="totalProOrderDetailCode" name="totalProOrderDetailCode">
						<!-- 지시검색모달 -->
						<a href="${pageContext.request.contextPath}/pro/proc/totalOrderSearch.do" rel="modal:open">						
                    		<i class="fa fa-search"></i>
                 		</a>
                 	
					
					</div>
					<div class="col-md-6" align="right">
						<button type="button" class="btn btn-success" id="totalFindRow">조회</button>
						<button type="reset" class="btn btn-danger" id="totalReset">새자료</button>
						<button type="submit" class="btn btn-primary" id="totalExcelBtn">Excel</button>
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
				<div id="totalGrid"></div>
			</div>
		</div>
	</div>
</div>
</div>


<!-----------------------------------생산이 완료된 자재 소요 조회----------------------------------->
<!-- 마스터 테이블 -->
<div id="finishgrid" class="tabcontent" style="display: none;">
<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-body">
			<div class="row">
				<form id="procMatrFrm" name="procMatrFrm" method="POST" action="${pageContext.request.contextPath}/procMatrExcel">
					<div class="col-md-6">
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
</div>

<script>
var totalGrid;
var grid;

	$(document).ready(function() {
		//네비게이션 바 고정.
		$('#n7000000').addClass('active');
		$('#subPages7000000').addClass('in');
		$('#subPages7000000').attr('aria-expanded','true');
		$('#subPages7000000').attr('style','');
		$('.7040000').addClass('active');
		
		
// ---------------------------------------- 완료 ----------------------------------------		
		//완료 탭 조회 버튼	
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
		
		
		//완료 탭 리셋버튼  
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
		grid = new tui.Grid({
			el : document.getElementById('grid'),
			rowHeaders : [ 'checkbox' ],
			data : dataSource,
			scrollX: true,
	        scrollY: true,
	        bodyHeight :300, 
	        rowHeight: 30,
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


// ---------------------------------------- 전체 ----------------------------------------
		
		//전체 탭 조회 버튼	
		$("#totalFindRow").click(function() {
		 	   var gubun = $("input[name=totalGubun]:checked").val();
		         var startDate = $("#startDate").val();
		         var endDate = $("#endDate").val();
		         var erpProductCode = $("#erpProductCode").val();
		         var erpCustomerCode = $("#erpCustomerCode").val();
		         var totlaProOrderDetailCode = $("#totalProOrderDetailCode").val();
		         
		         var readParams = {
		      	  'searchCondition' : gubun,
		            'startDate' : startDate,
		            'endDate' : endDate,
		            'erpProductCode' : erpProductCode,
		            'erpCustomerCode' : erpCustomerCode,
		            'totalProOrderDetailCode' : totlaProOrderDetailCode
		         };
		         totalGrid.readData(1, readParams, true);
		      });
		
		
		//전체 탭 리셋버튼  
		$("#totalReset").click(function() {  
			$("form").each(function() {  
		    	if(this.id == "option") this.reset();
		    	totalGrid.clear();

		    	$('#startDate').val("");
		    	$('#endDate').val("");
		    	$('#totalProOrderDetailCode').val("")
		    	});
			}); 
		
		
		
		//dataSource	
		const totalDataSource = {
			api : {
				readData : {
					url : '${pageContext.request.contextPath}/pro/proc/totalProcLot',
					method : 'GET'
				}
			},
			initialRequest : false,
			contentType : "application/json"
		};

		//그리드
		 totalGrid = new tui.Grid({
			el : document.getElementById('totalGrid'),
			rowHeaders : [ 'checkbox' ],
			data : totalDataSource,
			scrollX: true,
	        scrollY: true,
	        bodyHeight :300, 
	        rowHeight: 30,
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
			}, {
				header : '생산여부',
				name : 'proProcessQuantity',
				align: 'center',
				formatter: (ev)=>{return (ev.value == null) ? null : String(ev.value).replace(/\B(?=(\d{3})+(?!\d))/g, ","); }
			} ]
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
	  
	  if(inout == 'totalgrid'){
          totalGrid.refreshLayout();
       } else if(inout == 'finishgrid'){
          grid.refreshLayout();
       }
}





</script>



