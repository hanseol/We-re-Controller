<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /**
  * @Class Name : macRegisterForm.jsp
  * @Description : Mac Information 등록 페이지 
  * @Modification Information
  * 
  * @author hanseol
  * @since 20210708
  * @version 1.0
  * @see
  *  
  * Copyright (C) All right reserved.
  */
%>
<script type="text/javascript" src="<c:url value='/js/egovframework/cmm/fms/EgovMultiFile.js'/>" ></script>

<style>
th {
	width: 120px;
	text-align: center;
}

#imgDiv, #searchDiv {
	text-align: center;
}

.panel .table>thead>tr>td:last-child, .panel .table>thead>tr>th:last-child,
	.panel .table>tbody>tr>td:last-child, .panel .table>tbody>tr>th:last-child,
	.panel .table>tfoot>tr>td:last-child, .panel .table>tfoot>tr>th:last-child
	{
	padding-left: 5px;
}

.panel .table>thead>tr>td:first-child, .panel .table>thead>tr>th:first-child,
	.panel .table>tbody>tr>td:first-child, .panel .table>tbody>tr>th:first-child,
	.panel .table>tfoot>tr>td:first-child, .panel .table>tfoot>tr>th:first-child
	{
	padding-left: 5px;
}
</style>
<div>
	<!-- 관리, 조회 탭 이동 -->
	<div id="tabs">
	   <ul class="nav nav-tabs" role="tablist">
	     <ul class="nav nav-tabs" role="tablist">
	     <li class=""><a onclick='location.href="${pageContext.request.contextPath}/mac/macInfoView.do"' 
	    				aria-controls="tab1" role="tab" data-toggle="tab">조회</a></li>
	     <li class=""><a onclick='location.href="${pageContext.request.contextPath}/mac/macInfoForm.do"' 
	     				aria-controls="tab2" role="tab" data-toggle="tab">수정/삭제</a></li>
	     <li class="active"><a onclick='location.href="${pageContext.request.contextPath}/mac/macRegisterForm.do"' 
	     				aria-controls="tab3" role="tab" data-toggle="tab">등록</a></li>
	   </ul>
	</div>
	<!-- END 관리, 조회 탭 이동 -->

	
	<form>
	<!-- 정보 (테이블 출력) -->
	<div class="panel">
		<div class="panel-body">
			<table class="table table-bordered">
				<thead>
				</thead>
				<tbody>
					<tr>
						<th>설비코드</th>
						<td><input id="macCode"></td>
						<th>설비규격</th>
						<td><input id="macSize"></td>
						<th>모델명</th>
						<td><input id="macModel"></td>
					</tr>
					<tr>
						<th>설비구분</th>
						<td><input id="macGubun"></td>
						<th>용도</th>
						<td><input id="macUsePurpose"></td>
						<th>사용여부</th>
						<td><input id="macUnused"></td>
					</tr>
					<tr>
						<th>라인번호</th>
						<td><input id="macLineNo"></td>
						<th>제품코드</th>
						<td><input id="comProductCode"></td>
						<th>공정코드</th>
						<td><input id="macProcessCode"></td>
					</tr>
					<tr>
						<th>점검일</th>
						<td><input type="date" id="macChkdate"</td>
						<th>차기점검일</th>
						<td><input type="date" id="macNextChkDate"></td>
						<th>점검주기</th>
						<td><input id="macChkCycle"></td>
					</tr>
					<tr>
						<th>1H생산량</th>
						<td><input id="macHourQty"></td>
						<th>생산량</th>
						<td><input id="macPossibleSize"></td>
						<th>기준부하율</th>
						<td><input id="macBuha"></td>
					</tr>
					<tr>
						<th>구매일자</th>
						<td><input type="date" id="macLineNo"></td>
						<th></th>
						<td></td>
						<th>온도</th>
						<td><input id="macTemp"></td>
					</tr>
					<tr>
						<th>제작업체</th>
						<td><input id="macMachineConstructor"></td>
						<th>연락처</th>
						<td><input id="macConstructorPhone"></td>
						<th>구매가격</th>
						<td><input id="macMachineCost"></td>
					</tr>
					<tr>
						<th>이미지</th>
						<td colspan="3"><img id="macImage" src="" alt=""></td>
					</tr>
				</tbody>
			</table>
		</div>
		
		<div>
			<button type="reset" id="resetBtn" class="btn btn-info">새자료</button>
			<button type="button" id="registerMac" class="btn btn-info">등록</button>
		</div>
	
	</div>
	<!-- END 정보 -->
	</form>
</div>

<script type="text/javascript">
   var maxFileNum = document.frm.posblAtchFileNumber.value;
   if(maxFileNum==null || maxFileNum==""){
     maxFileNum = 3;
    }     
   var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum );
   multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );			
</script> 


<script>
	
	$(document).ready(function(){
		var obj = {};
		
		$("#registerMac").on("click",function(){
			//value 다 받아와서
			var macCode = $("#macCode").val();
			var macSize = $("#macSize").val();
			var macGubun = $("#macGubun").val();
			var macUsePurpose = $("#macUsePurpose").val();
			var macUnused = $("#macUnused").val();
			var macLineNo = $("#macLineNo").val();
			var comProductCode = $("#comProductCode").val();
			var comProcessCode = $("#comProcessCode").val();
			var macChkdate = $("#macChkdate").val();
			var macNextChkDate = $("#macNextChkDate").val();
			var macChkCycle = $("#macChkCycle").val();
			var macHourQty = $("#macHourQty").val();
			var macPossibleSize = $("#macPossibleSize").val();
			var macBuha = $("#macBuha").val();
			var macLineNo = $("#macLineNo").val();
			var macModel = $("#macModel").val();
			var macTemp = $("#macTemp").val();
			var macMachineConstructor = $("#macMachineConstructor").val();
			var macConstructorPhone = $("#macConstructorPhone").val();
			var macMachineCost = $("#macMachineCost").val();
			//var macImage = $("#macMachineCost").val();
			var erpEmployoeeId = ${session.erpEmployeeId};
			
			//obj 넣고
			obj["macCode"] = macCode;
			obj["macSize"] = macSize;
			obj["macGubun"] = macGubun;
			obj["macUsePurpose"] = macUsePurpose;
			obj["macUnused"] = macUnused;
			obj["macLineNo"] = macLineNo;
			obj["comProductCode"] = comProductCode;
			obj["comProcessCode"] = comProcessCode;
			obj["macChkdate"] = macChkdate;
			obj["macNextChkDate"] = macNextChkDate;
			obj["macChkCycle"] = macChkCycle;
			obj["macHourQty"] = macHourQty;
			obj["macPossibleSize"] = macPossibleSize;
			obj["macBuha"] = macBuha;
			obj["macLineNo"] = macLineNo;
			obj["macModel"] = macModel;
			obj["macTemp"] = macTemp;
			obj["macMachineConstructor"] = macMachineConstructor;
			obj["macConstructorPhone"] = macConstructorPhone;
			obj["macMachineCost"] = macMachineCost;
			//obj["macImage"] = macImage;
			obj["erpEmployoeeId"] = erpEmployoeeId;
			
			//stringify 사용
			$.ajax({
				url: '${pageContext.request.contextPath}/ajax/mac/registerMac',
				type: 'POST',
				dataType: 'JSON',
				contentType : "application/json",
				data: JSON.stringify(obj),
				success: function(response){
					
					console.log(response);
					//성공메시지 토스트로 보여주기
					//form reset.
					
				}
			});
		});
		
	});
</script>

