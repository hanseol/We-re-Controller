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
		<div class="panel-title">
			<h3>설비 검색</h3>
		</div>
		<div class="panel-body">
		<form>
			<div class="col-md-6">
				* 설비코드   &nbsp;&nbsp;&nbsp;<input type="text" id="viewMacCode" >  &nbsp;&nbsp;&nbsp;
				* 차기점검일  &nbsp;&nbsp;&nbsp; <input type="date" id="viewMacNextChkDate"> &nbsp;&nbsp;&nbsp;
				<a href="${pageContext.request.contextPath}/mac/miv/openMacListModal.do" rel="modal:open">						
                  	<i class="fa fa-search"></i>
               	</a>
			</div>
			<div class="col-md-6" align="right">
				<button type="button" class="btn btn-success" id="findRowForm">조회</button>
				<button type="reset" class="btn btn-danger">새자료</button>
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
		columns : [ {
			header : '설비코드',
			name : 'macCode',
			validation: {
	           required:true
	        },
			align : 'center'
		}, {
			header : '점검일',
			name : 'macChkDate',
			editor : {
				type : 'datePicker',
				options : {
					format : 'YYYY-MM-dd',
					language: 'ko'
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
					language: 'ko'
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
			align : 'center'
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
		}],
		columnOptions: {
	        resizable: true
	    }
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


/* 	
proPlanGrid.on('response', ev => {
	  const {response} = ev.xhr;
	  const responseObj = JSON.parse(response);

	  console.log('result : ', responseObj.result);
	  console.log('data : ', responseObj.data);
	});
 */
 
 //체크박스 클릭시 alert 띄우기
/* proPlanGrid.on('check', (ev) => {
	  alert(`check: ${ev.rowKey}`);
}); */

}); //end of document ready
</script>