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
	background-color: #fff9bd;
	width: 120px;
	text-align: center;
	color:black;
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
		<div align="center" id="headline"><h3>설비등록</h3></div>
		<div class="panel-body">
		<form name="frm" id="frm" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
			<table class="table table-bordered">
				<thead>
				</thead>
				<tbody>
					<tr>
						<th>설비코드</th>
						<td><input class="form-control" id="macCode" name="macCode" disabled></td>
						<th>설비규격</th>
						<td><select class="form-control" name="macSize" id="macSize"></select></td>
						<th>모델명</th>
						<td><select class="form-control" name="macModel" id="macModel"></select></td>
					</tr>
					<tr>
						<th>설비구분</th>
						<td><select class="form-control" name="macGubun" id="macGubun"></select></td>
						<th>사용여부</th>
						<td><input class="form-control" id="macUnused" name="macUnused" value="1"></td>
						<th>구매일자</th>
						<td><input class="form-control" type="date" id="macLineNo" name="macLineNo"></td>
					</tr>
					<tr>
						<th>라인번호</th>
						<td><input class="form-control" id="macLineNo" name="macLineNo"></td>
						<th>공정코드</th>
						<td><input class="form-control" id="macProcessCode" name="macProcessCode"></td>
						<th>점검일</th>
						<td><input class="form-control" type="date" id="macChkdate" name="macChkdate"></td>
					</tr>
					<tr>
						<th>온도</th>
						<td><input class="form-control" id="macTemp" name="macTemp"></td>
						<th>점검주기</th>
						<td><input class="form-control" id="macChkCycle" name="macChkCycle"></td>
						<th>차기점검일</th>
						<td><input class="form-control" type="date" id="macNextChkDate" name="macNextChkDate"></td>
					</tr>
					<tr>
						<th>1H생산량</th>
						<td><input class="form-control" id="macHourQty" name="macHourQty"></td>
						<th>생산량</th>
						<td><input class="form-control" id="macPossibleSize" name="macPossibleSize"></td>
						<th>기준부하율</th>
						<td><input class="form-control" id="macBuha" name="macBuha"></td>
					</tr>
					<tr>
						<th>제작업체</th>
						<td><input class="form-control" id="macMachineConstructor" name="macMachineConstructor"></td>
						<th>연락처</th>
						<td><input class="form-control" id="macConstructorPhone" name="macConstructorPhone"></td>
						<th>구매가격</th>
						<td><input class="form-control" id="macMachineCost" name="macMachineCost"></td>
					</tr>
					<tr>
						<th>이미지</th>
						<td colspan="3"><input class="form-control" type="file" id="uploadFile" name="uploadFile"/></td>
						<th>비고</th>
						<td><input class="form-control" id="macUsePurpose" name="macUsePurpose"></td>
					</tr>
				</tbody>
			</table>
			<div align="center">
				<button type="reset" id="resetBtn" class="btn btn-warning">새자료</button>
				<button type="button" id="registerMac" class="btn btn-success">등록</button>
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
		var erpEmployeeId = "${loginVO.id }";
		$("#registerMac").on("click",function(){

			$("#frm").ajaxForm({
				url: '${pageContext.request.contextPath}/ajax/mac/registerMac',
				type: 'POST',
				contentType: "application/json",
				dataType : "json",
				data:{"erpEmployoeeId": erpEmployeeId},
				enctype: "multipart/form-data",
				success: function(response){
					
					alert("등록처리");
					
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

