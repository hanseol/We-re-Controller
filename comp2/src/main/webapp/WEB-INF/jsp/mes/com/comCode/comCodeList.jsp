<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="content-fluid">
	<div>
		<h2>공통자료 관리</h2>
	</div>
</div>

<div class="search-area search-area-border grid-option-area">
	<!--  -->
	<div class="content-fluid">
		<div>
			<div class="my-panel">
				<!-- 				<button type="button" class="btn btn-danger" id="reset">새자료</button> -->
				<button type="button" class="btn btn-info" id="modifyRow">저장</button>
			</div>
		</div>
	</div>
</div>

<!--  -->
<div>
	<form id="option">
		<div class="content-fluid">
			<div class="panel panel-headline">
				<div class="panel-heading">
					<div class="row">
						<div class="col-md-12" align="right">
							<button type="button" id=appendRow>추가</button>
							<button type="button" id="deleteRow">삭제</button>
						</div>
					</div>
					
					<div class="panel-body">
						<div class="row">
							<!-- 마스터데이터 호출 -->
							<div class="col-md-4" id="grid"></div>
							<!-- Detail 표현 -->
							<div class="col-md-8" id="gridDetail"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
</div>

<!-- 마스터데이터 -->
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
	/* grid */
	$(document)
			.ready(
					function() {
						
						//네비게이션 고정 - 2021.07.23 김한설 수정
						$('#n4000000').addClass('active');
						$('#subPages4000000').addClass('in');
						$('#subPages4000000').attr('aria-expanded','true');
						$('#subPages4000000').attr('style','');
						$('.4010000').addClass('active');
						
						//변수생성
						var comCodeIdclick = 0;
						
						//코드명 검색
						$(document).on("click", "button[id=findRowCodeId]", function() {
							var comName = $("#comCodeName").val();
							console.log(comName);
							var readParams = {
									'comCodeName' : comName
								};
							//보낼 grid 이름 지정
							grid.readData(1, readParams, true);
						});
						
						//마스터테이블 controller 연결
						const dataSource = {
							api : {
								readData : {
									url : '${pageContext.request.contextPath}/comCode/ComCodeList',
									method : 'GET'
								},
							},
							contentType : "application/json"
						};
						
						//마스터테이블 그리드
						const grid = new tui.Grid({
							el : document.getElementById('grid'),
							data : dataSource,
						    scrollX: true,
						    scrollY: true,
						     bodyHeight :480,
						     rowHeight: 30,
							columns : [ {
								header : '공통코드',
								name : 'comCodeId',
								validation: {
								required:true
								},
								filter : 'text'
							}, {
								header : '공통코드명',
								name : 'comCodeName',validation: {
								required:true
								},
								filter : 'text'
							} ]
						});
						
						/* 디테일코드 */
						
						
						//CRUD
						$(document).on("click", "button[id=modifyRow]", function() {
							gridDetail.finishEditing('rowKey','columnName');
							gridDetail.request('modifyData');
						});
						
						//행삭제
						$(document).on("click", "button[id=deleteRow]", function() {
							gridDetail.removeCheckedRows(false);
						});
						
						//디테일코드 controller 연결
						const dataSourceDetail = {
							api : {
								readData : {
									url : '${pageContext.request.contextPath}/comCode/ComCodeDetailList',
									method : 'GET'
								}, 
								modifyData: { 
									url: '${pageContext.request.contextPath}/ajax/modifyComCodeDetail',
									method: 'PUT'
								},
							},
							// 바로 값 나오지않게함
							initialRequest : false,
							contentType : "application/json"
						};
						
						//디테일코드 그리드 설정
						const gridDetail = new tui.Grid({
							el : document.getElementById('gridDetail'),
							rowHeaders : [ 'checkbox' ],
							data : dataSourceDetail,
						    scrollX: true,
						    scrollY: true,
						     bodyHeight : 480,
						     rowHeight: 30,
							columns : [ {
								header : '공통코드',
								name : 'comCodeId',
								hidden : true
								
							},{
								header : '코드',
								name : 'comCodeDetailId',
								editor : 'text',
								validation: {
						               required:true
						            },
							sortable: true ,
							align : 'center'
							}, {
								header : '코드명',
								name : 'comCodeDetailName',
								editor : 'text',
								align : 'center'
							}, {
								header : '코드설명',
								name : 'comCodeDetailDesc',
								editor : 'text',
								align : 'center'
							}, {
								header : '표시순번',
								name : 'comCodeDetailSeq',
								editor : 'text',
									align : 'center'
							}, {
								header : '사용여부',
								name : 'comCodeDetailUsedchk',
								editor : 'text',
								renderer: { type: CustomCheckboxRenderer},
								align : 'center'
								} ]
						});
						
						//마스터테이블 클릭시 데이터 전달
						grid.on('click', (ev) => {
							comCodeIdclick = grid.getValue(ev.rowKey, "comCodeId");
							console.log(comCodeIdclick);
					   	var readParams = {
								'comCodeId' : comCodeIdclick
							};
						gridDetail.readData(1, readParams, true);
					   });
					
						//행추가
						$(document).on("click", "button[id=appendRow]", function() {
							console.log(comCodeIdclick);
							var rowData =  {
									comCodeId : comCodeIdclick,
									comCodeDetailId : "",
									comCodeDetailName : "",
									comCodeDetailDesc : "",
									comCodeDetailSeq : "",
									comCodeDetailUsedchk : "",
								} ;
								gridDetail.appendRow(rowData, {
									at : gridDetail.getRowCount(),
									focus : true
								});
								gridDetail.enable();
						});
						
						// option form reset  
						 $(document).ready(function() {  
						    $("#reset").click(function() {  
						         $("form").each(function() {  
						                if(this.id == "option") this.reset();  
						             });  
						    });  
						 });  
						

					});//end of ready

</script>