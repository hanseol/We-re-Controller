<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<div class="content-fluid">
	<div>
		<h2>제품공정흐름관리</h2>
	</div>
</div>

<!--  -->
<div class="content-fluid">
	<div>
		<div class="my-panel">
			<button type="button" class="btn btn-danger" id="reset">새자료</button>
			<button type="button" class="btn btn-info" id="modifyRow">저장</button>
		</div>
	</div>
</div>

<!--  -->
<form id="option">
	<div class="content-fluid">
		<div class="panel panel-headline">
			<div class="panel-heading">
				<div class="row">
					<div class="col-md-7"></div>

				</div>
				<div class="panel-body">
					<div class="row">
						<div>
							<!-- 마스터데이터 호출 -->
							<div class="col-md-4" id="masterGrid"></div>
							<div class="col-md-8">
								<div id="gridDetail"></div>
								<div align="right">
									<button type="button" id=appendRow>추가</button>
									<button type="button" id="deleteRow">삭제</button>

									<div id="gridFlow"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
</form>

<!-- 마스터데이터 -->
<script>
//그리드모달창을 위한 그리드 선언-------------------------------------
let procGrid;
//-----------------------------------------------------------
	$(document).ready(function() {
		//변수생성
		var masterClick = 0;

		//마스터테이블 controller 연결
		const masterDataSource = {
			api : {
				readData : {
					url : '${pageContext.request.contextPath}/prodProc/ComProdList',
					method : 'GET'
				},
			},
			contentType : "application/json"
		};

		//마스터테이블 그리드
		const grid = new tui.Grid({
			el : document.getElementById('masterGrid'),
			data : masterDataSource,
			scrollX : true,
			scrollY : true,
			bodyHeight : 480,
			rowHeight : 30,
			columns : [ {
				header : '제품코드',
				name : 'comProductCode',
			}, {
				header : '제품명',
				name : 'comProductName',
			} ]
		});

		
		//디테일코드 controller 연결
		const detailDataSource = {
			api : {
				readData : {
					url : '${pageContext.request.contextPath}/prodProc/ProdProcList',
					method : 'GET'
				}, 
			},
			// 바로 값 나오지않게함
			initialRequest : false,
			contentType : "application/json"
		};
		
		//디테일코드 그리드 설정
		const detailGrid = new tui.Grid({
			el : document.getElementById('gridDetail'),
			data : detailDataSource,
		    scrollX: true,
		    scrollY: true,
		     bodyHeight : 150,
		     rowHeight: 30,
			columns : [ {
				header : '제품코드',
				name : 'comProductCode',
			},{
				header : '제품명',
				name : 'comProductName',
				editor : 'text'
			}, {
				header : '규격',
				name : 'comProductSize',
				editor : 'text'
			}, {
				header : '관리단위',
				name : 'comProductUnit',
				editor : 'text'
			}, {
				header : '사용여부',
				name : 'comProductUse',
				editor : 'text'
			} ]
		}); 
		
		//공정전개 controller 연결
		const flowDataSource = {
			api : {
				readData : {
					url : '${pageContext.request.contextPath}/prodProc/ProcFlowList',
					method : 'GET'
				},
				modifyData: { 
					url: '${pageContext.request.contextPath}/ajax/modifyProcPlow',
					method: 'PUT'
				},
			},
			// 바로 값 나오지않게함
			initialRequest : false,
			contentType : "application/json"
		};
		
		//디테일코드 그리드 설정
		const flowGrid = new tui.Grid({
			el : document.getElementById('gridFlow'),
			rowHeaders : [ 'checkbox' ],
			data : flowDataSource,
		    scrollX: true,
		    scrollY: true,
		     bodyHeight : 330,
		     rowHeight: 30,
			columns : [ {
				header : '제품코드',
				name : 'comProductCode',
				
			},{
				header : '순서',
				name : 'comProcessSeq',
				editor : 'text'
			},{
				header : '공정코드',
				name : 'comProcessCode',
			},{
				header : '공정명',
				name : 'comProcessName',
				editor : 'text',
				validation: {
		               required:true
		            } 
			}, {
				header : '공정설명',
				name : 'comProcessDesc',
			}, {
				header : '관리단위',
				name : 'comProcessUnit',
				editor : 'text'
			}, {
				header : '부하',
				name : 'comProcessBuha',
				editor : 'text'
			}, {
				header : 'LEAD타임(M)',
				name : 'comProcessLeadtime',
				editor : 'text'
			}]
		}); 
		
		//모달 그리드 초기화 ----------------------------------
		procGrid = flowGrid;
		//--------------------------------------------------
		
		//마스터테이블 클릭시 데이터 전달
		grid.on('click', (ev) => {
			masterClick = grid.getValue(ev.rowKey, "comProductCode");
			console.log(masterClick);
	   	var readParams = {
				'comProductCode' : masterClick
				
			};
	   	detailGrid.readData(1, readParams, true);
	   	flowGrid.readData(1, readParams, true);
   		});
		
		//행추가
		$(document).on("click", "button[id=appendRow]", function() {

			var rowData =  {
					comProductCode : masterClick,
					comProcessSeq : "",
					comProcessCode : "",
					comProcessName : "",
					comProcessDesc : "",
					comProcessUnit : "",
					comProcessBuha : "",
					comProductUse : "",
				};
					flowGrid.appendRow(rowData, {
						at: 0,
						focus : true
				});
				flowGrid.enable();
		});
		
		//CRUD
		$(document).on("click", "button[id=modifyRow]", function() {
			flowGrid.finishEditing('rowKey','columnName');
			flowGrid.request('modifyData');
		});
		
		//행삭제
		$(document).on("click", "button[id=deleteRow]", function() {
			flowGrid.finishEditing('rowKey','columnName');
			flowGrid.removeCheckedRows(false);
		});
		

		//그리드 모달 더블클릭--------------------------------------------------
		//자재
		flowGrid.on('dblclick', ev =>{
			if(ev.columnName == 'comProcessName'){
				procCodeSearch(ev.rowKey);
			}
		})
		//-----------------------------------------------------------------


		// 분석필요
		flowGrid.on('response', ev => {
			  const {response} = ev.xhr;
			  const responseObj = JSON.parse(response);
	
			  console.log('result : ', responseObj.result);
			  console.log('data : ', responseObj.data);
			});
		
		
		//분석필요
		$('#proCodeSearchModal').click(function(event) {
			procCodeSearch(-1);
		});
	})
		
		//그리드모달 :모달페이지로 값 넘기기----------------------------------------
		var comProcId;
		function procCodeSearch(c) {
			comProcId = c;
			  console.log(comProcId);
			  event.preventDefault();
			  $(".modal").remove();
			  this.blur(); // Manually remove focus from clicked link.
			  console.log(this.href);
			  $.get("${pageContext.request.contextPath}/prodUseMatr/ProCodeSearchModal.do", function(html) {
			    $(html).appendTo('body').modal();
			  });
		}
		//---------------------------------------------------------------
</script>
