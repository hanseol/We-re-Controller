<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /**
  * @Class Name : ErpEmpRegister.jsp
  * @Description : ErpEmp Register 화면
  * @Modification Information
  * 
  * @author hanseol
  * @since 20210706
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

<c:set var="registerFlag" value="${empty erpEmpVO.erpEmployeeId ? '등록' : '수정'}"/>

<title> <c:out value="${registerFlag}"/> </title>
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/sample.css'/>"/>

<!--For Commons Validator Client Side-->
<!-- script type="text/javascript" src="<c:url value='/cmmn/validator.do'/>"></script -->
<!-- validator:javascript formName="erpEmpVO" staticJavascript="false" xhtml="true" cdata="false"/ -->

<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* 글 목록 화면 function */
function fn_egov_selectList() {
   	document.getElementById("detailForm").action = "<c:url value='/erpEmp/ErpEmpList.do'/>";
   	document.getElementById("detailForm").submit();		
}

/* 글 삭제 function */
function fn_egov_delete() {
   	document.getElementById("detailForm").action = "<c:url value='/erpEmp/deleteErpEmp.do'/>";
   	document.getElementById("detailForm").submit();		
}

/* 글 등록 function */
function fn_egov_save() {	
	frm = document.getElementById("detailForm");

	/* TODO Validation기능 보완 */
	
  	frm.action = "<c:url value="${registerFlag == '등록' ? '/erpEmp/addErpEmp.do' : '/erpEmp/updateErpEmp.do'}"/>";
    frm.submit();

}

// -->
</script>
</head>
<body>

<form:form commandName="erpEmpVO" name="detailForm" id="detailForm" >
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
			<th>ERP_EMPLOYEE_ID *</th>
			<td>
				<form:input path="erpEmployeeId" cssClass="essentiality" readonly="true" />
			</td>			
		</tr>	
		</c:if>
		<c:if test="${registerFlag == '등록'}">
	   <tr>
			<th>ERP_EMPLOYEE_ID *</th>
			<td>
				<form:input path="erpEmployeeId" cssClass="txt" readonly="false" />
			</td>			
		</tr>	
		</c:if>		
		<tr>
			<th>ERP_EMPLOYEE_NAME</th>
			<td>
				<form:input path="erpEmployeeName" cssClass="txt"/>
				&nbsp;<form:errors path="erpEmployeeName" />
			</td>
		</tr>	
		<tr>
			<th>ERP_EMPLOYEE_POSITION</th>
			<td>
				<form:input path="erpEmployeePosition" cssClass="txt"/>
				&nbsp;<form:errors path="erpEmployeePosition" />
			</td>
		</tr>	
		<tr>
			<th>ERP_EMPLOYEE_EMAIL</th>
			<td>
				<form:input path="erpEmployeeEmail" cssClass="txt"/>
				&nbsp;<form:errors path="erpEmployeeEmail" />
			</td>
		</tr>	
		<tr>
			<th>ERP_EMPLOYEE_PHONE</th>
			<td>
				<form:input path="erpEmployeePhone" cssClass="txt"/>
				&nbsp;<form:errors path="erpEmployeePhone" />
			</td>
		</tr>	
		<tr>
			<th>ERP_EMPLOYEE_HIREDATE</th>
			<td>
				<form:input path="erpEmployeeHiredate" cssClass="txt"/>
				&nbsp;<form:errors path="erpEmployeeHiredate" />
			</td>
		</tr>	
		<tr>
			<th>ERP_JOB_NAME</th>
			<td>
				<form:input path="erpJobName" cssClass="txt"/>
				&nbsp;<form:errors path="erpJobName" />
			</td>
		</tr>	
		<tr>
			<th>ERP_DEPARTMENT_NAME</th>
			<td>
				<form:input path="erpDepartmentName" cssClass="txt"/>
				&nbsp;<form:errors path="erpDepartmentName" />
			</td>
		</tr>	
		<tr>
			<th>ERP_EMPLOYEE_PASSWORD</th>
			<td>
				<form:input path="erpEmployeePassword" cssClass="txt"/>
				&nbsp;<form:errors path="erpEmployeePassword" />
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

