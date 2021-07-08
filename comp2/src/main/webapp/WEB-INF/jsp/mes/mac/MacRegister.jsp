<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /**
  * @Class Name : MacRegister.jsp
  * @Description : Mac Register 화면
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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<c:set var="registerFlag" value="${empty macVO.macCode ? '등록' : '수정'}"/>

<title> <c:out value="${registerFlag}"/> </title>
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/sample.css'/>"/>

<!--For Commons Validator Client Side-->
<!-- script type="text/javascript" src="<c:url value='/cmmn/validator.do'/>"></script -->
<!-- validator:javascript formName="macVO" staticJavascript="false" xhtml="true" cdata="false"/ -->

<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* 글 목록 화면 function */
function fn_egov_selectList() {
   	document.getElementById("detailForm").action = "<c:url value='/mac/MacList.do'/>";
   	document.getElementById("detailForm").submit();		
}

/* 글 삭제 function */
function fn_egov_delete() {
   	document.getElementById("detailForm").action = "<c:url value='/mac/deleteMac.do'/>";
   	document.getElementById("detailForm").submit();		
}

/* 글 등록 function */
function fn_egov_save() {	
	frm = document.getElementById("detailForm");

	/* TODO Validation기능 보완 */
	
  	frm.action = "<c:url value="${registerFlag == '등록' ? '/mac/addMac.do' : '/mac/updateMac.do'}"/>";
    frm.submit();

}

// -->
</script>
</head>
<body>

<form:form commandName="macVO" name="detailForm" id="detailForm" >
<div id="content_pop">
	<!-- 타이틀 -->
	<div id="title">
		<ul>
			<li><img src="<c:url value='/images//title_dot.gif'/>" alt="" /><c:out value="${registerFlag}"/></li>
		</ul>
	</div>
	<!-- // 타이틀 -->
	<div id="table">
	<table width="100%" border="1" cellpadding="0" cellspacing="0" >
		<colgroup>
			<col width="150"/>
			<col width=""/>
		</colgroup>
			
		<c:if test="${registerFlag == '수정'}">
	   <tr>
			<th>MAC_CODE *</th>
			<td>
				<form:input path="macCode" cssClass="essentiality" readonly="true" />
			</td>			
		</tr>	
		</c:if>
		<c:if test="${registerFlag == '등록'}">
	   <tr>
			<th>MAC_CODE *</th>
			<td>
				<form:input path="macCode" cssClass="txt" readonly="false" />
			</td>			
		</tr>	
		</c:if>		
		<tr>
			<th>MAC_LINE_NO</th>
			<td>
				<form:input path="macLineNo" cssClass="txt"/>
				&nbsp;<form:errors path="macLineNo" />
			</td>
		</tr>	
		<tr>
			<th>MAC_HOUR_QTY</th>
			<td>
				<form:input path="macHourQty" cssClass="txt"/>
				&nbsp;<form:errors path="macHourQty" />
			</td>
		</tr>	
		<tr>
			<th>COM_PRODUCT_CODE</th>
			<td>
				<form:input path="comProductCode" cssClass="txt"/>
				&nbsp;<form:errors path="comProductCode" />
			</td>
		</tr>	
		<tr>
			<th>COM_PROCESS_CODE</th>
			<td>
				<form:input path="comProcessCode" cssClass="txt"/>
				&nbsp;<form:errors path="comProcessCode" />
			</td>
		</tr>	
		<tr>
			<th>MAC_UNUSED</th>
			<td>
				<form:input path="macUnused" cssClass="txt"/>
				&nbsp;<form:errors path="macUnused" />
			</td>
		</tr>	
		<tr>
			<th>ERP_EMPLOYEE_ID</th>
			<td>
				<form:input path="erpEmployeeId" cssClass="txt"/>
				&nbsp;<form:errors path="erpEmployeeId" />
			</td>
		</tr>	
		<tr>
			<th>MAC_USE_PURPOSE</th>
			<td>
				<form:input path="macUsePurpose" cssClass="txt"/>
				&nbsp;<form:errors path="macUsePurpose" />
			</td>
		</tr>	
		<tr>
			<th>MAC_GUBUN</th>
			<td>
				<form:input path="macGubun" cssClass="txt"/>
				&nbsp;<form:errors path="macGubun" />
			</td>
		</tr>	
		<tr>
			<th>MAC_NAME</th>
			<td>
				<form:input path="macName" cssClass="txt"/>
				&nbsp;<form:errors path="macName" />
			</td>
		</tr>	
		<tr>
			<th>MAC_SIZE</th>
			<td>
				<form:input path="macSize" cssClass="txt"/>
				&nbsp;<form:errors path="macSize" />
			</td>
		</tr>	
		<tr>
			<th>MAC_MODEL</th>
			<td>
				<form:input path="macModel" cssClass="txt"/>
				&nbsp;<form:errors path="macModel" />
			</td>
		</tr>	
		<tr>
			<th>MAC_MACHINE_CONSTRUCTOR</th>
			<td>
				<form:input path="macMachineConstructor" cssClass="txt"/>
				&nbsp;<form:errors path="macMachineConstructor" />
			</td>
		</tr>	
		<tr>
			<th>MAC_POSSIBLE_SIZE</th>
			<td>
				<form:input path="macPossibleSize" cssClass="txt"/>
				&nbsp;<form:errors path="macPossibleSize" />
			</td>
		</tr>	
		<tr>
			<th>MAC_MACHINE_DATE</th>
			<td>
				<form:input path="macMachineDate" cssClass="txt"/>
				&nbsp;<form:errors path="macMachineDate" />
			</td>
		</tr>	
		<tr>
			<th>MAC_MACHINE_COST</th>
			<td>
				<form:input path="macMachineCost" cssClass="txt"/>
				&nbsp;<form:errors path="macMachineCost" />
			</td>
		</tr>	
		<tr>
			<th>MAC_BUHA</th>
			<td>
				<form:input path="macBuha" cssClass="txt"/>
				&nbsp;<form:errors path="macBuha" />
			</td>
		</tr>	
		<tr>
			<th>MAC_TEMP</th>
			<td>
				<form:input path="macTemp" cssClass="txt"/>
				&nbsp;<form:errors path="macTemp" />
			</td>
		</tr>	
		<tr>
			<th>MAC_CHK_DATE</th>
			<td>
				<form:input path="macChkDate" cssClass="txt"/>
				&nbsp;<form:errors path="macChkDate" />
			</td>
		</tr>	
		<tr>
			<th>MAC_NEXT_CHK_DATE</th>
			<td>
				<form:input path="macNextChkDate" cssClass="txt"/>
				&nbsp;<form:errors path="macNextChkDate" />
			</td>
		</tr>	
		<tr>
			<th>MAC_CHK_CYCLE</th>
			<td>
				<form:input path="macChkCycle" cssClass="txt"/>
				&nbsp;<form:errors path="macChkCycle" />
			</td>
		</tr>	
	</table>
  </div>
	<div id="sysbtn">
		<ul>
			<li><span class="btn_blue_l"><a href="javascript:fn_egov_selectList();">List</a><img src="<c:url value='/images//btn_bg_r.gif'/>" alt="" /></span></li>
			<li><span class="btn_blue_l"><a href="javascript:fn_egov_save();"><c:out value='${registerFlag}'/></a><img src="<c:url value='/images//btn_bg_r.gif'/>" alt="" /></span></li>
			<c:if test="${registerFlag == '수정'}">
			<li><span class="btn_blue_l"><a href="javascript:fn_egov_delete();">삭제</a><img src="<c:url value='/images//btn_bg_r.gif'/>" alt="" /></span></li>
			</c:if>
			<li><span class="btn_blue_l"><a href="javascript:document.detailForm.reset();">Reset</a><img src="<c:url value='/images//btn_bg_r.gif'/>" alt="" /></span></li></ul>
	</div>
</div>
<!-- 검색조건 유지 -->
<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
</form:form>
</body>
</html>

