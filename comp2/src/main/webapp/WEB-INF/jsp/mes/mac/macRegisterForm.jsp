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
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.form/4.3.0/jquery.form.min.js"></script>
<style>
th {
	width: 120px;
	text-align: center;
}

#imgDiv, #searchDiv {
	text-align: center;
}

#img {
	width : 100%;
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
	     <li class=""><a onclick='location.href="${pageContext.request.contextPath}/mac/macInfoView.do"' 
	    				aria-controls="tab1" role="tab" data-toggle="tab">조회</a></li>
	     <li class=""><a onclick='location.href="${pageContext.request.contextPath}/mac/macInfoForm.do"' 
	     				aria-controls="tab2" role="tab" data-toggle="tab">수정/삭제</a></li>
	     <li class="active"><a onclick='location.href="${pageContext.request.contextPath}/mac/macRegisterForm.do"' 
	     				aria-controls="tab3" role="tab" data-toggle="tab">등록</a></li>
	   </ul>
	</div>
	<!-- END 관리, 조회 탭 이동 -->

	
	
	<!-- 정보 (테이블 출력) -->
	<div class="panel">
		<div class="panel-body">
		<form name="frm" id="frm" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
			<table class="table table-bordered">
				<thead>
				</thead>
				<tbody>
					<tr>
						<th>설비코드</th>
						<td><input id="macCode" name="macCode"></td>
						<th>설비규격</th>
						<td><input id="macSize" name="macSize"></td>
						<th>모델명</th>
						<td><input id="macModel" name="macModel"></td>
					</tr>
					<tr>
						<th>설비구분</th>
						<td><input id="macGubun" name="macGubun"></td>
						<th>용도</th>
						<td><input id="macUsePurpose" name="macUsePurpose"></td>
						<th>사용여부</th>
						<td><input id="macUnused" name="macUnused"></td>
					</tr>
					<tr>
						<th>라인번호</th>
						<td><input id="macLineNo" name="macLineNo"></td>
						<th>제품코드</th>
						<td><input id="comProductCode" name="comProductCode"></td>
						<th>공정코드</th>
						<td><input id="macProcessCode" name="macProcessCode"></td>
					</tr>
					<tr>
						<th>점검일</th>
						<td><input type="date" id="macChkdate" name="macChkdate"></td>
						<th>차기점검일</th>
						<td><input type="date" id="macNextChkDate" name="macNextChkDate"></td>
						<th>점검주기</th>
						<td><input id="macChkCycle" name="macChkCycle"></td>
					</tr>
					<tr>
						<th>1H생산량</th>
						<td><input id="macHourQty" name="macHourQty"></td>
						<th>생산량</th>
						<td><input id="macPossibleSize" name="macPossibleSize"></td>
						<th>기준부하율</th>
						<td><input id="macBuha" name="macBuha"></td>
					</tr>
					<tr>
						<th>구매일자</th>
						<td><input type="date" id="macLineNo" name="macLineNo"></td>
						<th></th>
						<td></td>
						<th>온도</th>
						<td><input id="macTemp" name="macTemp"></td>
					</tr>
					<tr>
						<th>제작업체</th>
						<td><input id="macMachineConstructor" name="macMachineConstructor"></td>
						<th>연락처</th>
						<td><input id="macConstructorPhone" name="macConstructorPhone"></td>
						<th>구매가격</th>
						<td><input id="macMachineCost" name="macMachineCost"></td>
					</tr>
					<tr>
						<th>이미지</th>
						<td colspan="3"><input type="file" id="uploadFile" name="uploadFile"/></td>
					</tr>
				</tbody>
			</table>
			<div>
				<button type="reset" id="resetBtn" class="btn btn-info">새자료</button>
				<button type="button" id="registerMac" class="btn btn-info">등록</button>
			</div>
			</form>
		</div>
	</div>
	<!-- END 정보 -->
	</form>
	
	<div class="panel">
		<div class="panel-body" id="imgDiv">
			<img id="img" />
		</div>
	</div>
	
</div>

<script>
//네비게이션 고정
$('#macNav').addClass('active');
$('#subPages5').addClass('in');
$('#subPages5').attr('aria-expanded','true');
$('#subPages5').attr('style','');
$('.macInfo').addClass('active');

	$(document).ready(function(){
		var erpEmployeeId = ${session.erpEmployeeId };
		console.log(erpEmployeeId);
		$("#registerMac").on("click",function(){

			$("#frm").ajaxForm({
				url: '${pageContext.request.contextPath}/ajax/mac/registerMac',
				type: 'POST',
				contentType: "application/json",
				dataType : "json",
				data:{"erpEmployoeeId": erpEmployeeId},
				enctype: "multipart/form-data",
				success: function(response){
					
					console.log(response);
					//성공메시지 토스트로 보여주기
					//form reset.
					
				}
			}).submit();
		});
		
		$("#uploadFile").on("change", handleImgFileSelect);
		
		function handleImgFileSelect(e) {
            var files = e.target.files;
            var filesArr = Array.prototype.slice.call(files);
 
            filesArr.forEach(function(f) {
                if(!f.type.match("image.*")) {
                    alert("확장자는 이미지 확장자만 가능합니다.");
                    return;
                }
 
                sel_file = f;
 
                var reader = new FileReader();
                reader.onload = function(e) {
                    $("#img").attr("src", e.target.result);
                }
                reader.readAsDataURL(f);
            });
        }
		
	});
</script>

