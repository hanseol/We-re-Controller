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

.table, #headline{
	margin-top:30px;
}

th {
	background-color: #f1f7fe;
	width: 120px;
	text-align: center;
	color:black;
}

#imgDiv, #searchDiv {
	text-align: center;
}

#img {
	width : 50%;
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
	.form-control{
		display: inline;
		font-size:17px; 
		width: 100%;
	}

</style>
<div>
	<!-- 관리, 조회 탭 이동 -->
	<div id="tabs">
	   <ul class="nav nav-tabs" role="tablist">
	     <li class=""><a onclick='location.href="${pageContext.request.contextPath}/mac/miv/macInfoView.do"' 
	    				aria-controls="tab1" role="tab" data-toggle="tab">조회</a></li>
	     <li class=""><a onclick='location.href="${pageContext.request.contextPath}/mac/mim/macInfoForm.do"' 
	     				aria-controls="tab2" role="tab" data-toggle="tab">수정/삭제</a></li>
	     <li class="active"><a onclick='location.href="${pageContext.request.contextPath}/mac/mim/macRegisterForm.do"' 
	     				aria-controls="tab3" role="tab" data-toggle="tab">등록</a></li>
	   </ul>
	</div>
	<!-- END 관리, 조회 탭 이동 -->

	
	
	<!-- 정보 (테이블 출력) -->
	<div class="panel">
		<div align="center" id="headline"><h2>설비 등록</h2></div>
		<div class="panel-body">
		<form name="frm" method="post" enctype="multipart/form-data" accept-charset="UTF-8"
				action="${pageContext.request.contextPath}/mac/mim/registerMac.do">
			<input type="hidden" id="erpEmployeeId" name="erpEmployeeId" value="${loginVO.id }">
			<table class="table table-bordered">
				<thead>
				</thead>
				<tbody>
					<tr>
						<th>* 설비코드</th>
						<td><input class="form-control" id="macCode" name="macCode" required></td>
						<th>* 설비규격</th>
						<td><select class="form-control" name="macSize" id="macSize" required></select></td>
						<th>* 모델명</th>
						<td><select class="form-control" name="macModel" id="macModel" required></select></td>
					</tr>
					<tr>
						<th>* 설비구분</th>
						<td><select class="form-control" name="macGubun" id="macGubun" required></select></td>
						<th>* 사용여부</th>
						<td><input class="form-control" id="macUnused" name="macUnused" value="1" required></td>
						<th>* 구매일자</th>
						<td><input class="form-control" type="date" id="macMachineDate" name="macMachineDate" required></td>
					</tr>
					<tr>
						<th>* 라인번호</th>
						<td><input class="form-control" id="macLineNo" name="macLineNo" required></td>
						<th>* 공정코드</th>
						<td><input class="form-control" id="macProcessCode" name="macProcessCode" required></td>
						<th>* 점검일</th>
						<td><input class="form-control" type="date" id="macChkDate" name="macChkDate" required></td>
					</tr>
					<tr>
						<th>* 용도</th>
						<td><input class="form-control" id="macUsePurpose" name="macUsePurpose" required></td>
						<th>* 점검주기</th>
						<td><input class="form-control" id="macChkCycle" name="macChkCycle" required></td>
						<th>* 차기점검일</th>
						<td><input class="form-control" type="date" id="macNextChkDate" name="macNextChkDate" required></td>
					</tr>
					<tr>
						<th>* 1H생산량</th>
						<td><input class="form-control" id="macHourQty" name="macHourQty" required></td>
						<th>생산량</th>
						<td><input class="form-control" id="macPossibleSize" name="macPossibleSize"></td>
						<th>기준부하율</th>
						<td><input class="form-control" id="macBuha" name="macBuha"></td>
					</tr>
					<tr>
						<th>제작업체</th>
						<td><input class="form-control" id="macMachineConstructor" name="macMachineConstructor" required></td>
						<th>* 비상연락망</th>
						<td><input class="form-control" id="macConstructorPhone" name="macConstructorPhone" required></td>
						<th>* 구매가격</th>
						<td><input class="form-control" id="macMachineCost" name="macMachineCost" required></td>
					</tr>
					<tr>
						<th>* 이미지</th>
						<td colspan="5"><input class="form-control" type="file" id="uploadFile" name="uploadFile" required/></td>
					</tr>
				</tbody>
			</table>
			<div align="center">
				<button type="submit" id="registerMac" class="btn btn-primary">등록</button>
				<button type="reset" id="resetBtn" class="btn btn-success">새자료</button>
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
	<input type="hidden" id="erpEmployeeId" value="${loginVo.id }">
</div>

<script>

	$(document).ready(function(){
		var erpEmployeeId = $("#erpEmployeeId").val();
		//네비게이션 고정
		$('#n8000000').addClass('active');
		$('#subPages8000000').addClass('in');
		$('#subPages8000000').attr('aria-expanded','true');
		$('#subPages8000000').attr('style','');
		$('.8030000').addClass('active');
		
		/* $("#registerMac").on("click",function(){

			 $("#frm").ajaxForm({
				url: '${pageContext.request.contextPath}/ajax/mac/registerMac',
				type: 'POST',
				enctype: "multipart/form-data",
				success: function(response){
					alert("등록 완료");
				}
			}).submit(); 
		}); */
		
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
		
		//필요한 정보 가져오기.
	/* 	$.ajax({
			url: '${pageContext.request.contextPath}/ajax/mac/getNextMacCode',
			success : function(result){
				$("#macCode").val(result);
			}
		}); */
		
		$.ajax({
			url: '${pageContext.request.contextPath}/ajax/mac/getInfo',
			contentType : "application/json",
			success : function(result){
				$("#macCode").val(result.code);
				$("select[name='macSize']").empty(); 
				//$("select[name='macSize']").append('<option value="">--------선택--------</option>');
				var data = result.size;
				$.each(data,function(index,item){
					var rdata = "<option value='"+item+"'>"+ item + "</option>";
					$("select[name='macSize']").append(rdata);
				});
				
				$("select[name='macModel']").empty(); 
				//$("select[name='macModel']").append('<option value="">--------선택--------</option>');
				data = result.model;
				$.each(data,function(index,item){
					var rdata = "<option value='"+item+"'>"+ item + "</option>";
					$("select[name='macModel']").append(rdata);
				});
				
				$("select[name='macGubun']").empty(); 
				//$("select[name='macGubun']").append('<option value="">--------선택--------</option>');
				data = result.usePurpose;
				$.each(data,function(index,item){
					var rdata = "<option value='"+item+"'>"+ item + "</option>";
					$("select[name='macGubun']").append(rdata);
				});
			
			}
		})
		
	});
</script>

