<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /**
  * @Class Name : macInfoForm.jsp
  * @Description : Mac Info 수정 화면 (점검일, 차기점검일, 사용여부, 점검주기, 제작업체, 비상연락망 수정 페이지)
  * @Modification Information
  * 
  * @author hanseol
  * @since 20210709
  * @version 1.0
  * @see
  *  
  * Copyright (C) All right reserved.
  */
%>

<div>
	<!-- 조회, 수정/삭제, 등록 탭 이동 -->
	<div id="tabs">
	   <ul class="nav nav-tabs" role="tablist">
	     <li class=""><a onclick='location.href="${pageContext.request.contextPath}/mac/miv/macInfoView.do"' 
	    				aria-controls="tab1" role="tab" data-toggle="tab">조회</a></li>
	     <li class="active"><a onclick='location.href="${pageContext.request.contextPath}/mac/mim/macInfoForm.do"' 
	     				aria-controls="tab2" role="tab" data-toggle="tab">수정/삭제</a></li>
	     <li class=""><a onclick='location.href="${pageContext.request.contextPath}/mac/mim/macRegisterForm.do"' 
	     				aria-controls="tab3" role="tab" data-toggle="tab">등록</a></li>
	   </ul>
	</div>
	
	
	<!-- 검색  -->
	<div class="panel" id="searchDiv">
		<div class="panel-body">
		<form>
			<div class="col-md-8">
				* 설비코드   &nbsp;&nbsp;&nbsp;<input type="text" id="viewMacCode" class="form-control" >  &nbsp;&nbsp;&nbsp;
				* 차기점검일  &nbsp;&nbsp;&nbsp; <input type="date" id="viewMacNextChkDate" class="form-control"> &nbsp;&nbsp;&nbsp;
				<a href="${pageContext.request.contextPath}/mac/miv/openMacListModal.do" rel="modal:open">						
                  	<i class="fa fa-search"></i>
               	</a>
			</div>
			<div class="col-md-4" align="right">
				<button type="button" class="btn btn-primary" id="findRowForm">조회</button>
				<button type="reset" class="btn btn-success">새자료</button>
			</div>
		</form> 
		</div>
	</div>
	<!-- END 검색  -->
	
	<!-- 그리드 -->
	<div class="content-fluid">
		<div class="panel panel-headline">
			<div class="panel-heading">
				<div class="row">
					<div class="col-md-7">
						<p class="panel-subtitle">설비 정보 관리</p>
					</div>
					<div class="col-md-5" align="right">
						<button type="button" id="deleteRow">삭제</button>
						<button type="button" id="modifyRow">저장</button>
					</div>
				</div>
				<div class="panel-body">
					<div id="macGrid"></div>
				</div>
			</div>
		</div>
	</div>
	<!-- END 그리드 -->
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

var macInfoGrid;
var macInfoRowKey;

$(document).ready(function() {
	
	//네비게이션 고정
	$('#n8000000').addClass('active');
	$('#subPages8000000').addClass('in');
	$('#subPages8000000').attr('aria-expanded','true');
	$('#subPages8000000').attr('style','');
	$('.8020000').addClass('active');
	
	//M 조회 버튼
	$("#findRowForm").on("click", function() {
	    var macCode = $("#viewMacCode").val();
	    var macNextChkDate = $("#viewMacNextChkDate").val();
	    console.log(macCode);
	    console.log(macNextChkDate);
	    var readParams = {
	       'macCode' : macCode,
	       'macNextChkDate' : macNextChkDate
	    }; 
	    macInfoGrid.readData(1, readParams, true);
     });
	 
	//D 저장 버튼
	$("#modifyRow").on("click", function () {
		macInfoGrid.finishEditing('rowKey', 'columnName');
		macInfoGrid.request('modifyData');
	});
	 
	//D 삭제 버튼 
	$("#deleteRow").on("click", function() {
		//뷰에서만 삭제. 최종적으로 저장 버튼을 눌러야 업데이트 완료됨.
		macInfoGrid.removeCheckedRows(false); 
	});
	
	//dataSource		
	const dataSource = {
		api : {
			readData : { url : '${pageContext.request.contextPath}/ajax/mac/macList', method : 'GET' },  
			modifyData : { url: '${pageContext.request.contextPath}/ajax/mac/modifyMacInfo', method: 'PUT' }
		},
		initialRequest : false,
		contentType : "application/json"
	};
	

	macInfoGrid = new tui.Grid({
		el : document.getElementById('macGrid'),
		rowHeaders : [ 'checkbox' ],
		data : dataSource,
		scrollX: true,
        scrollY: true,
        bodyHeight :300, 
        rowHeight: 30,
		columnOptions: {
	        resizable: true
	    },
		columns : [ {
			header : '설비코드',
			name : 'macCode',
			validation: {
	           required:true
	        },
	        width :'auto',
	        minWidth : 70,
			align : 'center'
		}, {
			header : '점검일',
			name : 'macChkDate',
			editor : {
				type : 'datePicker',
				options : {
					format : 'YYYY-MM-dd',
					language: 'ko',
					selectableRanges : [[new Date(), new Date(2099, 1, 1)]]
				} 
			},
			align : 'center'
		}, {
			header : '차기점검일',
			name : 'macNextChkDate',
			editor : {
				type : 'datePicker',
				options : {
					format : 'YYYY-MM-dd',
					language: 'ko',
					selectableRanges : [[new Date(), new Date(2099, 1, 1)]]
				} 
			},
			align : 'center'
		}, {
			header : '점검주기',
			name : 'macChkCycle',
			editor : 'text',
			align : 'center'
		}, {
			header : '사용여부',
			name : 'macUnused',
			editor : 'text',
			align : 'center',
			width : 'auto',
			renderer: { type: CustomCheckboxRenderer},
        	minWidth : 70
		}, {
			header : '부하율',
			name : 'macBuha',
			editor : 'text',
			align : 'center'
		}, {
			header : '생산량',
			name : 'macPossibleSize',
			editor : 'text',
			align : 'center'
		}, {
			header : '제작업체',
			name : 'macMachineConstructor',
			editor : 'text',
			align : 'center'
		}, {
			header : '비상연락망',
			name : 'macConstructorPhone',
			editor : 'text',
			align : 'center'
		}]
	});

}); //end of document ready
</script>