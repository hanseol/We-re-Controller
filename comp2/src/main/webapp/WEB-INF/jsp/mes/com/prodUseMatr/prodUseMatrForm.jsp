<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet"
	href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<link rel="stylesheet"
	href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css">

<script
	src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
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
		<h2>제품BOM관리</h2>
	</div>
</div>

<div class="content-fluid">
	<div>
		<div class="my-panel">
			<button type="button" class="btn btn-success" id="search">조회</button>
			<button type="button" class="btn btn-danger" id="reset">새자료</button>
			<button type="button" class="btn btn-info" id="modifyRow">저장</button>
		</div>
	</div>
</div>

<form id="option">
	<div class="content-fluid">
		<div class="panel panel-headline">
			<div class="panel-body">
				<div class="row">
					<div class="col-md-4">
						<form>
							제품코드 <input type="text" id="productCode" name="productCode">
							<a id="ProdUseMatrModal" href="ProdUseMatrModal.do"
								rel="modal:open"> <i class="fa fa-search"></i></a>
							<!-- 모달창 -->
							<a id="showModal"
								href="${pageContext.request.contextPath}/prodUseMatr/proCodeSearchModal.do"
								rel="modal:open"></a>
						</form>
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
					<p class="panel-subtitle">제품 소요량 관리</p>
				</div>
				<div class="col-md-5" align="right">
					<button type="button" id=appendRow>추가</button>
					<button type="button" id="deleteRow">삭제</button>
				</div>
			</div>
			<div class="panel-body">
				<div id="grid"></div>
			</div>
		</div>
	</div>
</div>

<script>
/* 체크박스 */
class CustomCheckboxRenderer {
   constructor(props) {
       const { grid, rowKey,columnInfo, value } = props;
       const label = document.createElement('checkbox');
/*         const { disabled } = props.columnInfo.renderer.options; */
       label.className = 'checkbox';
       //label.setAttribute('for', String(rowKey));

       const hiddenInput = document.createElement('input');
       hiddenInput.className = 'hidden-input';
       hiddenInput.id = String(rowKey);

       hiddenInput.setAttribute( 'data-check-val', '0' );
       
       label.appendChild(hiddenInput);

       hiddenInput.type = 'checkbox';
       hiddenInput.addEventListener('change', () => {
           if (hiddenInput.checked) {
               hiddenInput.setAttribute( 'data-check-val', '1' );
               grid.setValue(rowKey, columnInfo.name, "1");
           } else {
               hiddenInput.setAttribute( 'data-check-val', '0' );
               grid.setValue(rowKey, columnInfo.name, "0");
           }
           try {
               fnCustomChkboxChange();
           } catch(e) {
               
           }
           
       });

       this.el = label;

       this.render(props);
   }

   getElement() {
       return this.el;
   }

   render(props) {
   const hiddenInput = this.el.querySelector('.hidden-input');
   const checked = Boolean(props.value == '1');
   hiddenInput.checked = checked;
  const disabled = props.columnInfo.renderer.disabled;
   hiddenInput.disabled = disabled; 
   }
};
//그리드모달창을 위한 그리드 선언-------------------------------------
let procGrid;
//-----------------------------------------------------------

	$(document).ready(function() {
		//변수생성
		var productCode = 0;
		//코드명 검색
		$(document).on("click", "button[id=search]",
				function() {
					productCode = $("#productCode").val();
					var readParams = {
						'comProductCode' : productCode,
					};
				    if ( productCode == '' ) {
				    	alert('제품코드를 넣어주세요.');
				        return false;
				    };
					grid.readData(1, readParams, true);
				});
		
		
		const dataSource = {
			api : {
				readData : {
					url : '${pageContext.request.contextPath}/prodUseMatr/ProdUseMatrList',
					method : 'GET'
				}, 
				modifyData: { 
					url: '${pageContext.request.contextPath}/ajax/modifyProdUseMatr',
					method: 'PUT'
				},
			},
			initialRequest: false, 
			contentType : "application/json"
		};
		
		//디테일 그리드
		const grid = new tui.Grid({
			el : document.getElementById('grid'),
			rowHeaders : [ 'checkbox' ],
			data : dataSource,
			columns : [{
				header : '제품코드',
				name : 'comProductCode',
				hidden : true
			},{
				header : '자재코드',
				name : 'comMaterialCode',
/* 				validation: {
		               required:true
		            } */
				editor : 'text'
			}, {
				header : '자재명',
				name : 'comProductName',
			}, {
				header : '사용량',
				name : 'comBomUnit',
				editor : 'text'
			}, {
				header : '발주',
				name : 'comBomOrder',
				editor : 'text',
				renderer: { type: CustomCheckboxRenderer},
				align : 'center'
			}, {
				header : '생산',
				name : 'comBomProduce',
				editor : 'text',
				renderer: { type: CustomCheckboxRenderer},
				align : 'center'
			},{
				header : '공정코드',
				name : 'comProcessCode',
				editor : 'text',
				hidden : true
			}, {
				header : '사용공정명',
				name : 'comProcessName',
				editor : 'text',
				validation: {
		               required:true
		            } 
			}, {
				header : '비고',
				name : 'comBomEtc',
				editor : 'text'
			}]
		}); 
		
		//Insert
		$(document).on("click", "button[id=appendRow]", function() {
			
			var rowData = {
					comProductCode : productCode,
					comMaterialCode : "",
					comBomUnit : "",
					comBomOrder : "",
					comBomProduce : "",
					comProcessCode : "",
					comBomEtc : "",
			};
		    if ( productCode == '' ) {
		    	alert('제품코드를 넣어주세요.');
		        return false;
		    };
			grid.appendRow(rowData, {
				at: 0,
				focus : true
			});
			grid.enable();
		});
		
		//Delete
		$(document).on("click", "button[id=deleteRow]", function() {
			grid.finishEditing('rowKey','columnName');
			grid.removeCheckedRows(false);
		});
		
		//CRUD
		$(document).on("click", "button[id=modifyRow]", function() {
			grid.finishEditing('rowKey','columnName');
			grid.request('modifyData');
		});
		

		
//모달 그리드 초기화 ----------------------------------
		procGrid = grid;
//--------------------------------------------------

//그리드 모달 더블클릭--------------------------------------------------
		//자재
		grid.on('dblclick', ev =>{
			if(ev.columnName == 'comProcessName'){
				procCodeSearch(ev.rowKey);
			}
		})
//-----------------------------------------------------------------

		// 분석필요
		grid.on('response', ev => {
			  const {response} = ev.xhr;
			  const responseObj = JSON.parse(response);
	
			  console.log('result : ', responseObj.result);
			  console.log('data : ', responseObj.data);
			});
		
		
		//분석필요
		$('#proCodeSearchModal').click(function(event) {
			procCodeSearch(-1);
		});
		

		
/* 		//더블클릭 모달창 on(공정코드)
		grid.on('dblclick', ev => {
		    if(ev.columnName == 'comProcessName'){
		       
		       $('#showModal').click();
		       
		    }
		 }); */
	
		// option form reset  
		 $(document).ready(function() {  
		    $("#reset").click(function() {  
		         $("form").each(function() {  
		                if(this.id == "option") this.reset();  
		             });  
		    });  
		 });  
	
	}); //end of document ready
	//그리드모달 :모달페이지로 값 넘기기----------------------------------------
	//자재
	var comProcId;
	function procCodeSearch(c) {
		comProcId = c;
		  console.log(comProcId);
		  event.preventDefault();
		  $(".modal").remove();
		  this.blur(); // Manually remove focus from clicked link.
		  console.log(this.href);
		  $.get("proCodeSearchModal.do", function(html) {
		    $(html).appendTo('body').modal();
		  });
	}
	//---------------------------------------------------------------
</script>